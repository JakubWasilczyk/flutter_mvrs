import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_mvrs/flutter_mvrs.dart';

import 'filter.dart' as core;

class Limit extends core.Filter {
  final int limit;
  Limit(this.limit);

  @override
  Query<T> apply<T>(Query<T> query) => query.limit(limit);
}

class LimitLast extends core.Filter {
  final int limit;
  LimitLast(this.limit);

  @override
  Query<T> apply<T>(Query<T> query) => query.limitToLast(limit);
}

class OrderBy extends core.Filter {
  final Object field;
  final OrderByDirection direction;

  OrderBy(this.field, this.direction);

  bool get isDescending => direction == OrderByDirection.descending;
  bool get isAscending => direction == OrderByDirection.ascending;

  @override
  Query<T> apply<T>(Query<T> query) =>
      query.orderBy(field, descending: isDescending);
}

class IsEqualTo extends core.Where {
  IsEqualTo(Object field, Object value) : super(field, value: value);

  @override
  Query<T> apply<T>(Query<T> query) => query.where(field, isEqualTo: value);
}

class IsNotEqualTo extends core.Where {
  IsNotEqualTo(Object field, Object value) : super(field, value: value);

  @override
  Query<T> apply<T>(Query<T> query) => query.where(field, isNotEqualTo: value);
}

class IsLessThan extends core.Where {
  IsLessThan(Object field, Object value) : super(field, value: value);

  @override
  Query<T> apply<T>(Query<T> query) => query.where(field, isLessThan: value);
}

class IsLessThanOrEqualTo extends core.Where {
  IsLessThanOrEqualTo(Object field, Object value) : super(field, value: value);

  @override
  Query<T> apply<T>(Query<T> query) =>
      query.where(field, isLessThanOrEqualTo: value);
}

class IsGreaterThan extends core.Where {
  IsGreaterThan(Object field, Object value) : super(field, value: value);

  @override
  Query<T> apply<T>(Query<T> query) => query.where(field, isGreaterThan: value);
}

class IsGreaterThanOrEqualTo extends core.Where {
  IsGreaterThanOrEqualTo(Object field, Object value)
      : super(field, value: value);

  @override
  Query<T> apply<T>(Query<T> query) =>
      query.where(field, isGreaterThanOrEqualTo: value);
}

class ArrayContains extends core.Where {
  ArrayContains(Object field, List<Object> value) : super(field, value: value);

  @override
  Query<T> apply<T>(Query<T> query) => query.where(field, arrayContains: value);
}

class ArrayContainsAny extends core.Where {
  ArrayContainsAny(Object field, List<Object> value)
      : super(field, value: value);

  @override
  Query<T> apply<T>(Query<T> query) =>
      query.where(field, arrayContainsAny: value);
}

class WhereIn extends core.Where {
  WhereIn(Object field, List<Object> value) : super(field, value: value);

  @override
  Query<T> apply<T>(Query<T> query) => query.where(field, whereIn: value);
}

class WhereNotIn extends core.Where {
  WhereNotIn(Object field, List<Object> value) : super(field, value: value);

  @override
  Query<T> apply<T>(Query<T> query) => query.where(field, whereNotIn: value);
}

class IsNull extends core.Where {
  IsNull(Object field) : super(field);

  @override
  Query<T> apply<T>(Query<T> query) => query.where(field, isNull: true);
}

class IsNotNull extends core.Where {
  IsNotNull(Object field) : super(field);

  @override
  Query<T> apply<T>(Query<T> query) => query.where(field, isNull: false);
}

class EndAtDocument extends core.Filter {
  final DocumentSnapshot document;
  EndAtDocument(this.document) : super();

  @override
  Query<T> apply<T>(Query<T> query) => query.endAtDocument(document);
}

class EndAt extends core.Filter {
  final List<Object?> values;
  EndAt(this.values) : super();

  @override
  Query<T> apply<T>(Query<T> query) => query.endAt(values);
}

class EndBeforeDocument extends core.Filter {
  final DocumentSnapshot document;
  EndBeforeDocument(this.document) : super();

  @override
  Query<T> apply<T>(Query<T> query) => query.endBeforeDocument(document);
}

class EndBefore extends core.Filter {
  final List<Object?> values;
  EndBefore(this.values) : super();

  @override
  Query<T> apply<T>(Query<T> query) => query.endBefore(values);
}

class StartAfterDocument extends core.Filter {
  final DocumentSnapshot document;
  StartAfterDocument(this.document) : super();

  @override
  Query<T> apply<T>(Query<T> query) => query.startAfterDocument(document);
}

class StartAfter extends core.Filter {
  final List<Object?> values;
  StartAfter(this.values) : super();

  @override
  Query<T> apply<T>(Query<T> query) => query.startAfter(values);
}

class StartAtDocument extends core.Filter {
  final DocumentSnapshot document;
  StartAtDocument(this.document) : super();

  @override
  Query<T> apply<T>(Query<T> query) => query.startAtDocument(document);
}

class StartAt extends core.Filter {
  final List<Object?> values;
  StartAt(this.values) : super();

  @override
  Query<T> apply<T>(Query<T> query) => query.startAt(values);
}
