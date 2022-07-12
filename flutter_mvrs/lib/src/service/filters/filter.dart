abstract class Filter {}

abstract class Where implements Filter {
  final Object field;
  final dynamic value;

  Where(this.field, {this.value});
}

enum OrderByDirection { ascending, descending }

abstract class OrderBy implements Filter {
  final Object field;
  final OrderByDirection direction;

  OrderBy(this.field, this.direction);

  bool get isDescending => direction == OrderByDirection.descending;
  bool get isAscending => direction == OrderByDirection.ascending;
}
