import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:flutter_mvrs/annotations/model_annotation.dart';
import 'package:source_gen/source_gen.dart';

import 'model_visitor.dart';

class ModelGenerator extends GeneratorForAnnotation<Model> {
  @override
  generateForAnnotatedElement(Element element, ConstantReader annotation, BuildStep buildStep) {
    try {
      final visitor = ModelVisitor();
      element.visitChildren(visitor);

      final className = visitor.className;
      final baseClassName = "Base$className";
      final params = visitor.params;
      String idType = params['id'] != null ? params['id']!.type.toString() : 'void';
      idType = idType.replaceFirst('*', '');

      final buffer = StringBuffer();
      //buffer.writeln("// $baseClassName");
      buffer.writeln("class $baseClassName extends BaseModel<$idType>${generateMixins(annotation)} {");

      buffer.writeln(generateFields(annotation, params));
      buffer.writeln(generateConstructor(annotation, params, className));
      buffer.writeln(generateGettersAndSetters(annotation, params));
      buffer.writeln(generateJsonConstructors(annotation, params, className));

      buffer.writeln("}");
      return buffer.toString();
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

  String generateConstructor(ConstantReader annotation, Map<String, ParameterElement> params, String className) {
    final buffer = StringBuffer();
    final bool hasCreatedAt = annotation.read('createdAt').boolValue;
    final bool hasUpdatedAt = annotation.read('updatedAt').boolValue;
    final directParams = [];
    if (hasCreatedAt) directParams.add("createdAt");
    if (hasUpdatedAt) directParams.add("updatedAt");

    final baseClassName = "Base$className";
    buffer.writeln("$baseClassName({");
    for (final param in params.keys) {
      final required = params[param]!.isRequiredNamed ? 'required ' : '';
      final paramType = params[param]!.type.toString().replaceFirst('*', '');

      if (directParams.contains(param)) {
        buffer.writeln("${required}this.$param,");
      } else {
        buffer.writeln("$required$paramType $param,");
      }
    }
    buffer.write("}) : ");
    final paramsToPrint = <String>[];
    for (final param in params.keys) {
      if (param == 'id') continue;
      if (directParams.contains(param)) continue;
      paramsToPrint.add("_$param = $param");
    }
    for (final param in paramsToPrint) {
      buffer.write(param);
      if (paramsToPrint.last != param) buffer.write(",");
      buffer.writeln();
    }
    if (params.containsKey('id')) {
      buffer.write(", super(id: id)");
    }
    return buffer.toString() + ";";
  }

  String generateGettersAndSetters(ConstantReader annotation, Map<String, ParameterElement> params) {
    final buffer = StringBuffer();
    final hasCreatedAt = annotation.read('createdAt').boolValue;
    final hasUpdatedAt = annotation.read('updatedAt').boolValue;

    buffer.writeln('');
    buffer.writeln('// GETTERS');
    for (final param in params.keys) {
      if (param == 'id') continue;
      if (param == 'createdAt' && hasCreatedAt) continue;
      if (param == 'updatedAt' && hasUpdatedAt) continue;
      final paramType = params[param]!.type.toString().replaceFirst('*', '');
      buffer.writeln("$paramType get $param => get('$param', _$param);");
    }

    buffer.writeln('');
    buffer.writeln('// SETTERS');
    for (final param in params.keys) {
      if (param == 'id') continue;
      if (param == 'createdAt' && hasCreatedAt) continue;
      if (param == 'updatedAt' && hasUpdatedAt) continue;
      final paramType = params[param]!.type.toString().replaceFirst('*', '');
      buffer.writeln("set $param($paramType value) => set('$param', value);");
    }
    buffer.writeln('');

    return buffer.toString();
  }

  String generateJsonConstructors(ConstantReader annotation, Map<String, ParameterElement> params, String className) {
    final buffer = StringBuffer();
    final List<String> jsonIgnore = annotation.read('jsonIgnore').listValue.map((e) => e.toString()).toList();
    final bool hasCreatedAt = annotation.read('createdAt').boolValue;
    final bool hasUpdatedAt = annotation.read('updatedAt').boolValue;

    buffer.writeln("Map<String, dynamic> toJson() => {");
    for (final param in params.keys) {
      if (param == 'id') continue;
      if (param == 'createdAt' && hasCreatedAt) continue;
      if (param == 'updatedAt' && hasUpdatedAt) continue;
      if (jsonIgnore.contains(param)) continue;
      buffer.writeln("'$param': $param,");
    }
    buffer.writeln("};");

    buffer.writeln("static $className fromJson(Map<String, dynamic> json) => $className(");
    for (final param in params.keys) {
      if (param == 'id') continue;
      if (jsonIgnore.contains(param)) continue;
      buffer.write("$param: json['$param'],");
    }
    buffer.writeln(");");

    return buffer.toString();
  }
}
