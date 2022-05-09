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

  late final bool hasCreatedAt;
  late final bool hasUpdatedAt;
  late final List<String> fromJsonIgnore;
  late final List<String> toJsonIgnore;
  late final Map<String, ParameterElement> params;

  @override
  generateForAnnotatedElement(Element element, ConstantReader annotation, BuildStep buildStep) {
    try {
      final visitor = ModelVisitor();
      element.visitChildren(visitor);

      hasCreatedAt = annotation.read('createdAt').boolValue;
      hasUpdatedAt = annotation.read('updatedAt').boolValue;
      fromJsonIgnore = annotation.read('fromJsonIgnore').listValue.map((e) => e.toStringValue()!).toList();
      toJsonIgnore = annotation.read('toJsonIgnore').listValue.map((e) => e.toStringValue()!).toList();
      params = visitor.params;

      final className = visitor.className;
      final baseClassName = "Base$className";
      //final fields = visitor.fields;
      String idType = params['id'] != null ? params['id']!.type.toString() : 'void';
      idType = idType.replaceFirst('*', '');

      String template = _template;
      template = template.replaceAll("{{baseClassName}}", baseClassName);
      template = template.replaceAll("{{className}}", className);
      template = template.replaceAll("{{idType}}", idType);
      template = template.replaceAll("{{mixins}}", generateMixins());

      template = template.replaceAll("{{fields}}", generateFields());
      template = template.replaceAll("{{constructorFields}}", generateConstructorFields());

      final fieldsLoad = generateFieldsLoad();
      final superConstructor = params.containsKey('id') ? "super(id: id)" : "super(id: null)";

      template = template.replaceAll("{{fieldsLoad}}", fieldsLoad);
      template = template.replaceAll("{{superConstructor}}", superConstructor);

      template = template.replaceAll("{{getters}}", generateGetters());
      template = template.replaceAll("{{setters}}", generateSetters());

      template = template.replaceAll("{{toJson}}", generateToJson());
      template = template.replaceAll("{{fromJson}}", generateFromJson());

      return template;
    } catch (e) {
      print(e.toString());
      return "//ERROR";
    }
  }

  String generateMixins() {
    final buffer = StringBuffer();

    List<String> _mixins = [];
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

  String generateFields() {
    final buffer = StringBuffer();
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

  String generateConstructorFields() {
    if (params.isEmpty) return "";
    final buffer = StringBuffer();
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

  String generateFieldsLoad() {
    final buffer = StringBuffer();
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

  String generateGetters() {
    final buffer = StringBuffer();
    for (final param in params.keys) {
      if (param == 'id') continue;
      if (param == 'createdAt' && hasCreatedAt) continue;
      if (param == 'updatedAt' && hasUpdatedAt) continue;
      final paramType = params[param]!.type.toString().replaceFirst('*', '');
      buffer.writeln("$paramType get $param => get('$param', _$param);");
    }
    return buffer.toString();
  }

  String generateSetters() {
    final buffer = StringBuffer();
    for (final param in params.keys) {
      if (param == 'id') continue;
      if (param == 'createdAt' && hasCreatedAt) continue;
      if (param == 'updatedAt' && hasUpdatedAt) continue;
      final paramType = params[param]!.type.toString().replaceFirst('*', '');
      buffer.writeln("set $param($paramType value) => set('$param', value);");
    }
    return buffer.toString();
  }

  String generateToJson() {
    final buffer = StringBuffer();
    for (final param in params.keys) {
      if (toJsonIgnore.contains(param)) continue;
      buffer.writeln("'$param': $param,");
    }
    return buffer.toString();
  }

  String generateFromJson() {
    final buffer = StringBuffer();
    for (final param in params.keys) {
      if (fromJsonIgnore.contains(param)) continue;
      buffer.write("$param: json['$param'],");
    }
    return buffer.toString();
  }
}
