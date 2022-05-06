import 'package:flutter/widgets.dart';

abstract class ChangeTracker with ChangeNotifier {
  final Map<String, dynamic> changes = {};

  bool get hasChanges => changes.isNotEmpty;

  void set(String field, dynamic value) {
    changes[field] = value;
    notifyListeners();
  }

  dynamic get(String field, [dynamic orValue]) {
    return changes[field] ?? orValue;
  }

  void reset() => changes.clear();
}
