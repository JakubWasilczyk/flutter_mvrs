import 'change_tracker.dart';

abstract class BaseModel<T> extends ChangeTracker {
  final T id;

  BaseModel({required this.id});

  T getId() => get('id', id);
  void setId(T value) => set('id', value);
}
