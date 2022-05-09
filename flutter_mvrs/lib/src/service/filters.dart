import 'filter.dart';

export 'filter.dart';

class Filters extends Iterable<Filter> {
  final List<Filter> _list = [];

  @override
  Iterator<Filter> get iterator => _list.iterator;

  Filters addFilter(Filter filter) {
    _list.add(filter);
    return this;
  }

  Filters removeFilter(Filter filter) {
    _list.remove(filter);
    return this;
  }
}
