abstract class Filter {}

class Where implements Filter {
  final Object field;
  final dynamic value;

  Where(this.field, {this.value});
}

class Limit implements Filter {
  final int limit;
  Limit(this.limit);
}

class LimitLast implements Filter {
  final int limit;
  LimitLast(this.limit);
}

enum OrderByDirection { ascending, descending }

class OrderBy implements Filter {
  final Object field;
  final OrderByDirection direction;

  OrderBy(this.field, this.direction);

  bool get isDescending => direction == OrderByDirection.descending;
  bool get isAscending => direction == OrderByDirection.ascending;
}
