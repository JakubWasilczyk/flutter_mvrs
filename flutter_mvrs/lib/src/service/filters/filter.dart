abstract class Filter {
  dynamic apply(dynamic query);
}

abstract class Where implements Filter {
  final Object field;
  final dynamic value;

  Where(this.field, {this.value});
}
