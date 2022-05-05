import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:flutter_mvrs/flutter_mvrs.dart';
import 'package:source_gen/source_gen.dart';

import 'model_visitor.dart';

class ModelGenerator extends GeneratorForAnnotation<Model> {
  @override
  generateForAnnotatedElement(Element element, ConstantReader annotation, BuildStep buildStep) {
    final visitor = ModelVisitor();
    element.visitChildren(visitor);

    final className = visitor.className;
    final baseClassName = "Base$className";
    final params = visitor.params;
    final idType = params['id'] ?? 'void';

    final buffer = StringBuffer();
    buffer.writeln("class $baseClassName extends BaseModel<$idType>${generateMixins(annotation)} {");

    buffer.writeln(generateFields(params));
    buffer.writeln(generateConstructor(params, className));
    buffer.writeln(generateGettersAndSetters(annotation, params));
    buffer.writeln(generateJsonConstructors(annotation, params, className));

    buffer.writeln("}");
    return buffer.toString();
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

  String generateFields(Map<String, String> params) {
    final buffer = StringBuffer();
    for (final param in params.keys) {
      if (param == 'id') continue;
      buffer.writeln("final ${params[param]} _$param;");
    }
    return buffer.toString();
  }

  String generateConstructor(Map<String, String> params, String className) {
    final buffer = StringBuffer();
    final baseClassName = "Base$className";
    buffer.writeln("$baseClassName(");
    for (final param in params.keys) {
      if (param == 'id') continue;
      buffer.writeln("${params[param]} this._$param,");
    }
    if (params.containsKey('id')) {
      buffer.write(") : super(id: id);");
    } else {
      buffer.write(");");
    }
    return buffer.toString();
  }

  String generateGettersAndSetters(ConstantReader annotation, Map<String, String> params) {
    final buffer = StringBuffer();
    final hasCreatedAt = annotation.read('createdAt').boolValue;
    final hasUpdatedAt = annotation.read('updatedAt').boolValue;

    for (final param in params.keys) {
      if (param == 'id') continue;
      if (param == 'createdAt' && hasCreatedAt) continue;
      if (param == 'updatedAt' && hasUpdatedAt) continue;
      buffer.writeln("${params[param]} get $param => get('$param', _$param);");
    }

    for (final param in params.keys) {
      if (param == 'id') continue;
      if (param == 'createdAt' && hasCreatedAt) continue;
      if (param == 'updatedAt' && hasUpdatedAt) continue;
      buffer.writeln("set $param(${params[param]} value) => set('$param', value);");
    }
    return buffer.toString();
  }

  String generateJsonConstructors(ConstantReader annotation, Map<String, String> params, String className) {
    final buffer = StringBuffer();
    final jsonIgnore = annotation.read('jsonIgnore').listValue as List<String>;
    final hasCreatedAt = annotation.read('createdAt').boolValue;
    final hasUpdatedAt = annotation.read('updatedAt').boolValue;

    buffer.writeln("Map<String, dynamic> toJson() => {");
    for (final param in params.keys) {
      if (param == 'id') continue;
      if (param == 'createdAt' && hasCreatedAt) continue;
      if (param == 'updatedAt' && hasUpdatedAt) continue;
      if (jsonIgnore.contains(param)) continue;
      buffer.writeln("'$param': $param,");
    }
    buffer.writeln("};");

    buffer.writeln("$className.fromJson(Map<String, dynamic> json) : ");
    for (final param in params.keys) {
      if (param == 'id') continue;
      if (param == 'createdAt' && hasCreatedAt) continue;
      if (param == 'updatedAt' && hasUpdatedAt) continue;
      if (jsonIgnore.contains(param)) continue;
      buffer.writeln("$param: json['$param']");
      if (params.keys.last != param) buffer.write(',');
    }
    buffer.write(";");

    return buffer.toString();
  }
}
