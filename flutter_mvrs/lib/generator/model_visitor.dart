import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/visitor.dart';

class ModelVisitor extends SimpleElementVisitor<void> {
  late String className;
  final params = <String, dynamic>{};
  final fields = <String, dynamic>{};

  @override
  void visitConstructorElement(ConstructorElement element) {
    try {
      final elementReturnType = element.type.returnType.toString();
      className = elementReturnType.replaceFirst('*', '');
      for (final param in element.parameters) {
        final elementType = param.type.toString();
        params[param.name] = elementType.replaceFirst('*', '');
      }
    } catch (e) {
      print("visitConstructorElement");
      throw Exception(e.toString());
    }
  }

  @override
  void visitFieldElement(FieldElement element) {
    try {
      final elementType = element.type.toString();
      fields[element.name] = elementType.replaceFirst('*', '');
    } catch (e) {
      print("visitFieldElement");
      throw Exception(e.toString());
    }
  }
}
