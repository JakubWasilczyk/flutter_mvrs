import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/visitor.dart';

class ModelVisitor extends SimpleElementVisitor<void> {
  late String className;
  final Map<String, DartType> params = {};
  final Map<String, DartType> fields = {};

  @override
  void visitConstructorElement(ConstructorElement element) {
    try {
      final elementReturnType = element.type.returnType.toString();
      className = elementReturnType.replaceFirst('*', '');
      for (final param in element.parameters) {
        params[param.name] = param.type;
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
