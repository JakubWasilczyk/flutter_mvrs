import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:analyzer/dart/element/visitor.dart';

class ModelVisitor extends SimpleElementVisitor<void> {
  late String className;
  final Map<String, ParameterElement> params = {};
  final Map<String, DartType> fields = {};

  @override
  void visitConstructorElement(ConstructorElement element) {
    try {
      final elementReturnType = element.type.returnType.toString();
      className = elementReturnType.replaceFirst('*', '');
      final _params1 = element.parameters;
      final _params2 = element.declaration.parameters;
      print("Parameters difference(${_params1.length} - ${_params2.length}): ${_params1.length - _params2.length}");
      for (final param in element.declaration.parameters) {
        print("------------${param.name}------------");
        print("isNamed: ${param.isNamed}");
        print("isOptionalNamed: ${param.isOptionalNamed}");
        print("isFinal: ${param.isFinal}");
        print("isPublic: ${param.isPublic}");
        print("location: ${param.location}");
        print("hasFactory: ${param.hasFactory}");
        print("-------------------------------------");
        params[param.name] = param;
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  void visitFieldElement(FieldElement element) {
    try {
      fields[element.name] = element.type;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
