import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_mvrs/flutter_mvrs.dart';
import 'package:flutter_mvrs_firestore/flutter_mvrs_firestore.dart';

abstract class ServiceRepository<T extends BaseModel> {
  final CollectionProvider<T> service;

  ServiceRepository(this.service);

  DataError<T> onError(dynamic e) {
    if (e is FirebaseException) return DataError(e.message ?? e.toString(), e.stackTrace);
    return DataError(e.toString());
  }
}

abstract class ServiceParamRepository<T extends BaseModel, P> {
  final SubCollectionProvider<T, P> service;

  ServiceParamRepository(this.service);

  DataError<T> onError(dynamic e) {
    if (e is FirebaseException) return DataError(e.message ?? e.toString(), e.stackTrace);
    return DataError(e.toString());
  }
}
