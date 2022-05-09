class Filter {
  Object field;

  Object? isEqualTo;
  Object? isNotEqualTo;
  Object? isLessThan;
  Object? isLessThanOrEqualTo;
  Object? isGreaterThan;
  Object? isGreaterThanOrEqualTo;
  Object? arrayContains;
  List<Object?>? arrayContainsAny;
  List<Object?>? whereIn;
  List<Object?>? whereNotIn;
  bool? isNull;

  Filter(
    this.field, {
    this.isEqualTo,
    this.isNotEqualTo,
    this.isLessThan,
    this.isLessThanOrEqualTo,
    this.isGreaterThan,
    this.isGreaterThanOrEqualTo,
    this.arrayContains,
    this.arrayContainsAny,
    this.whereIn,
    this.whereNotIn,
    this.isNull,
  });
}

class IsEqualToFilter extends Filter {
  IsEqualToFilter(
    String field,
    Object isEqualTo,
  ) : super(
          field,
          isEqualTo: isEqualTo,
        );
}

class IsNotEqualToFilter extends Filter {
  IsNotEqualToFilter(
    String field,
    Object isNotEqualTo,
  ) : super(
          field,
          isNotEqualTo: isNotEqualTo,
        );
}

class IsLessThanFilter extends Filter {
  IsLessThanFilter(
    String field,
    Object isLessThan,
  ) : super(
          field,
          isLessThan: isLessThan,
        );
}

class IsLessThanOrEqualToFilter extends Filter {
  IsLessThanOrEqualToFilter(String field, Object isLessThanOrEqualTo)
      : super(field, isLessThanOrEqualTo: isLessThanOrEqualTo);
}

class IsGreaterThanFilter extends Filter {
  IsGreaterThanFilter(
    String field,
    Object isGreaterThan,
  ) : super(
          field,
          isGreaterThan: isGreaterThan,
        );
}

class IsGreaterThanOrEqualToFilter extends Filter {
  IsGreaterThanOrEqualToFilter(String field, Object isGreaterThanOrEqualTo)
      : super(field, isGreaterThanOrEqualTo: isGreaterThanOrEqualTo);
}

class ArrayContainsFilter extends Filter {
  ArrayContainsFilter(
    String field,
    Object arrayContains,
  ) : super(
          field,
          arrayContains: arrayContains,
        );
}

class ArrayContainsAnyFilter extends Filter {
  ArrayContainsAnyFilter(String field, List<Object?> arrayContainsAny)
      : super(field, arrayContainsAny: arrayContainsAny);
}

class WhereInFilter extends Filter {
  WhereInFilter(
    String field,
    List<Object?> whereIn,
  ) : super(
          field,
          whereIn: whereIn,
        );
}

class WhereNotInFilter extends Filter {
  WhereNotInFilter(
    String field,
    List<Object?> whereNotIn,
  ) : super(
          field,
          whereNotIn: whereNotIn,
        );
}

class IsNullFilter extends Filter {
  IsNullFilter(
    String field,
    bool isNull,
  ) : super(
          field,
          isNull: isNull,
        );
}
