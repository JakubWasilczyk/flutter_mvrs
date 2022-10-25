import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_mvrs/flutter_mvrs.dart';
import 'package:flutter_mvrs_firestore/flutter_mvrs_firestore.dart';

mixin ModelSetServiceRepository<T extends BaseModel> on ServiceRepository<T> {
  Future<DataState<String>> save(T model) {
    try {
      return service.save(model).then((r) => DataSuccess(r), onError: onError);
    } on FirebaseException catch (e) {
      return DataError.future(e.message ?? e.toString(), e.stackTrace);
    } catch (e) {
      return DataError.future(e.toString());
    }
  }

  Future<DataState<void>> delete(T model) {
    try {
      return service.delete(model).then((r) => DataSuccess(r), onError: onError);
    } on FirebaseException catch (e) {
      return DataError.future(e.message ?? e.toString(), e.stackTrace);
    } catch (e) {
      return DataError.future(e.toString());
    }
  }
}

mixin ModelSetParamServiceRepository<T extends BaseModel, P> on ServiceParamRepository<T, P> {
  Future<DataState<String>> save(T model, P param) {
    try {
      return service.save(param, model).then((r) => DataSuccess(r), onError: onError);
    } on FirebaseException catch (e) {
      return DataError.future(e.message ?? e.toString(), e.stackTrace);
    } catch (e) {
      return DataError.future(e.toString());
    }
  }

  Future<DataState<void>> delete(T model, P param) {
    try {
      return service.delete(param, model).then((r) => DataSuccess(r), onError: onError);
    } on FirebaseException catch (e) {
      return DataError.future(e.message ?? e.toString(), e.stackTrace);
    } catch (e) {
      return DataError.future(e.toString());
    }
  }
}
