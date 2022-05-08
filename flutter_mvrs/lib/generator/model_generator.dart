import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:flutter_mvrs/annotations/model_annotation.dart';
import 'package:source_gen/source_gen.dart';

import 'model_visitor.dart';

class ModelGenerator extends GeneratorForAnnotation<Model> {
  final String _template = "class {{baseClassName}} extends BaseModel<{{idType}}> {{mixins}} {\n"
      "{{fields}}\n"
      "\n"
      "{{baseClassName}}(\n"
      "   {{constructorFields}}\n"
      ") : \n"
      "   {{fieldsLoad}}\n"
      "   {{superConstructor}};\n"
      "\n"
      " //GETTERS\n"
      "{{getters}}\n"
      "\n"
      " //SETTERS\n"
      "{{setters}}\n"
      "\n"
      "Map<String, dynamic> toJson() => {\n"
      "   {{toJson}}\n"
      "};\n"
      "\n"
      "static {{className}} fromJson(Map<String, dynamic> json) => {{className}}(\n"
      "   {{fromJson}}\n"
      ");\n"
      "\n"
      "}\n";

  @override
  generateForAnnotatedElement(Element element, ConstantReader annotation, BuildStep buildStep) {
    try {
      final visitor = ModelVisitor();
      element.visitChildren(visitor);

      final className = visitor.className;
      final baseClassName = "Base$className";
      final params = visitor.params;
      //final fields = visitor.fields;
      String idType = params['id'] != null ? params['id']!.type.toString() : 'void';
      idType = idType.replaceFirst('*', '');

      String template = _template;
      template = template.replaceAll("{{baseClassName}}", baseClassName);
      template = template.replaceAll("{{className}}", className);
      template = template.replaceAll("{{idType}}", idType);
      template = template.replaceAll("{{mixins}}", generateMixins(annotation));

      template = template.replaceAll("{{fields}}", generateFields(annotation, params));
      template = template.replaceAll("{{constructorFields}}", generateConstructorFields(annotation, params));

      final fieldsLoad = generateFieldsLoad(annotation, params);
      final superConstructor = params.containsKey('id') ? "super(id: id)" : "super(id: null)";

      template = template.replaceAll("{{fieldsLoad}}", fieldsLoad);
      template = template.replaceAll("{{superConstructor}}", superConstructor);

      template = template.replaceAll("{{getters}}", generateGetters(annotation, params));
      template = template.replaceAll("{{setters}}", generateSetters(annotation, params));

      template = template.replaceAll("{{toJson}}", generateToJson(annotation, params));
      template = template.replaceAll("{{fromJson}}", generateFromJson(annotation, params));

      return template;
    } catch (e) {
      print(e.toString());
      return "//ERROR";
    }
  }

  String generateMixins(ConstantReader annotation) {
    final buffer = StringBuffer();

    List<String> _mixins = [];
    final hasCreatedAt = annotation.read('createdAt').boolValue;
    final hasUpdatedAt = annotation.read('updatedAt').boolValue;
    if (hasCreatedAt) _mixins.add('CreatedAt');
    if (hasUpdatedAt) _mixins.add('UpdatedAt');
    if (_mixins.isNotEmpty) {
      String _mixin = '';
      for (final mixin in _mixins) {
        _mixin += ", $mixin";
      }
      buffer.write(" with ${_mixin.substring(1).trim()}");
    }

    return buffer.toString();
  }

  String generateFields(ConstantReader annotation, Map<String, ParameterElement> params) {
    final buffer = StringBuffer();
    final bool hasCreatedAt = annotation.read('createdAt').boolValue;
    final bool hasUpdatedAt = annotation.read('updatedAt').boolValue;
    final overrides = [];
    if (hasCreatedAt) overrides.add("createdAt");
    if (hasUpdatedAt) overrides.add("updatedAt");

    for (final param in params.keys) {
      if (param == 'id') continue;
      final paramType = params[param]!.type.toString().replaceFirst('*', '');
      if (overrides.contains(param)) {
        buffer.writeln("@override");
        buffer.writeln("final $paramType $param;");
      } else {
        buffer.writeln("final $paramType _$param;");
      }
    }

    return buffer.toString();
  }

  String generateConstructorFields(ConstantReader annotation, Map<String, ParameterElement> params) {
    if (params.isEmpty) return "";
    final buffer = StringBuffer();
    final bool hasCreatedAt = annotation.read('createdAt').boolValue;
    final bool hasUpdatedAt = annotation.read('updatedAt').boolValue;
    final directParams = [];
    if (hasCreatedAt) directParams.add("createdAt");
    if (hasUpdatedAt) directParams.add("updatedAt");

    buffer.write("{");
    for (final param in params.keys) {
      final required = params[param]!.isRequiredNamed ? 'required ' : '';
      final paramType = params[param]!.type.toString().replaceFirst('*', '');

      if (directParams.contains(param)) {
        buffer.writeln("${required}this.$param,");
      } else {
        buffer.writeln("$required$paramType $param,");
      }
    }
    buffer.write("}");
    return buffer.toString();
  }

  String generateFieldsLoad(ConstantReader annotation, Map<String, ParameterElement> params) {
    final buffer = StringBuffer();
    final bool hasCreatedAt = annotation.read('createdAt').boolValue;
    final bool hasUpdatedAt = annotation.read('updatedAt').boolValue;
    final directParams = ['id'];
    if (hasCreatedAt) directParams.add("createdAt");
    if (hasUpdatedAt) directParams.add("updatedAt");

    for (final param in params.keys) {
      if (!directParams.contains(param)) {
        buffer.writeln("_$param = $param,");
      }
    }
    return buffer.toString();
  }

  String generateGetters(ConstantReader annotation, Map<String, ParameterElement> params) {
    final buffer = StringBuffer();
    final hasCreatedAt = annotation.read('createdAt').boolValue;
    final hasUpdatedAt = annotation.read('updatedAt').boolValue;

    for (final param in params.keys) {
      if (param == 'id') continue;
      if (param == 'createdAt' && hasCreatedAt) continue;
      if (param == 'updatedAt' && hasUpdatedAt) continue;
      final paramType = params[param]!.type.toString().replaceFirst('*', '');
      buffer.writeln("$paramType get $param => get('$param', _$param);");
    }
    return buffer.toString();
  }

  String generateSetters(ConstantReader annotation, Map<String, ParameterElement> params) {
    final buffer = StringBuffer();
    final hasCreatedAt = annotation.read('createdAt').boolValue;
    final hasUpdatedAt = annotation.read('updatedAt').boolValue;

    for (final param in params.keys) {
      if (param == 'id') continue;
      if (param == 'createdAt' && hasCreatedAt) continue;
      if (param == 'updatedAt' && hasUpdatedAt) continue;
      final paramType = params[param]!.type.toString().replaceFirst('*', '');
      buffer.writeln("set $param($paramType value) => set('$param', value);");
    }
    return buffer.toString();
  }

  String generateToJson(ConstantReader annotation, Map<String, ParameterElement> params) {
    final buffer = StringBuffer();
    final List<String> jsonIgnore = annotation.read('jsonIgnore').listValue.map((e) => e.toString()).toList();
    final bool hasCreatedAt = annotation.read('createdAt').boolValue;
    final bool hasUpdatedAt = annotation.read('updatedAt').boolValue;

    for (final param in params.keys) {
      if (param == 'id') continue;
      if (param == 'createdAt' && hasCreatedAt) continue;
      if (param == 'updatedAt' && hasUpdatedAt) continue;
      if (jsonIgnore.contains(param)) continue;
      buffer.writeln("'$param': $param,");
    }
    return buffer.toString();
  }

  String generateFromJson(ConstantReader annotation, Map<String, ParameterElement> params) {
    final buffer = StringBuffer();
    final List<String> jsonIgnore = annotation.read('jsonIgnore').listValue.map((e) => e.toString()).toList();

    for (final param in params.keys) {
      if (jsonIgnore.contains(param)) continue;
      buffer.write("$param: json['$param'],");
    }

    return buffer.toString();
  }
}
