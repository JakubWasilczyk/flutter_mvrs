import 'package:flutter_mvrs/flutter_mvrs.dart';

abstract class ListenableRepository<T> {
  Stream<T?> listen(String id, {Filters filters});
  Stream<List<T>> listenList({Filters filters});
}
