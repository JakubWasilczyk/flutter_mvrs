import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_mvrs/flutter_mvrs.dart';
import 'package:flutter_mvrs_firestore/flutter_mvrs_firestore.dart';

mixin ModelGetServiceRepository<T extends BaseModel> on ServiceRepository<T> {
  Future<DataState<T?>> get(String id) {
    try {
      return service.get(id).then((r) => DataSuccess(r), onError: onError);
    } on FirebaseException catch (e) {
      return DataError.future(e.message ?? e.toString(), e.stackTrace);
    } catch (e) {
      return DataError.future(e.toString());
    }
  }

  Future<DataState<List<T>>> getList() {
    try {
      return service.getList().then((r) => DataSuccess(r), onError: onError);
    } on FirebaseException catch (e) {
      return DataError.future(e.message ?? e.toString(), e.stackTrace);
    } catch (e) {
      return DataError.future(e.toString());
    }
  }
}

mixin ModelGetParamServiceRepository<T extends BaseModel, P> on ServiceParamRepository<T, P> {
  Future<DataState<T?>> get(String id, P param) {
    try {
      return service.get(param, id).then((r) => DataSuccess(r), onError: onError);
    } on FirebaseException catch (e) {
      return DataError.future(e.message ?? e.toString(), e.stackTrace);
    } catch (e) {
      return DataError.future(e.toString());
    }
  }

  Future<DataState<List<T>>> getList(P param) {
    try {
      return service.getList(param).then((r) => DataSuccess(r), onError: onError);
    } on FirebaseException catch (e) {
      return DataError.future(e.message ?? e.toString(), e.stackTrace);
    } catch (e) {
      return DataError.future(e.toString());
    }
  }
}
