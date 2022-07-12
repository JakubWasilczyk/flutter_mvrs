import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_mvrs/flutter_mvrs.dart';

abstract class Filter implements BaseFilter {
  Query<T> apply<T>(Query<T> query);
}

abstract class Where implements Filter {
  final Object field;
  final dynamic value;

  Where(this.field, {this.value});
}
