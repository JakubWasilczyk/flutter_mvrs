import 'package:equatable/equatable.dart';

import 'change_tracker.dart';

abstract class BaseModel<T> extends Equatable with ChangeTracker {
  final T id;

  BaseModel({required this.id});
}
