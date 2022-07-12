import 'package:flutter_mvrs/src/service/filters/filter.dart';

class Filters {
  final List<Filter> _filters = [];

  Filters();

  void add(Filter filter) => _filters.add(filter);
}
