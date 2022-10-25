import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_mvrs/flutter_mvrs.dart';
import 'package:flutter_mvrs_firestore/flutter_mvrs_firestore.dart';

DataError<T> onError<T>(dynamic e) {
  if (e is FirebaseException) {
    return DataError(e.message ?? e.toString(), e.stackTrace);
  }
  return DataError(e.toString());
}

abstract class ModelServiceRepository<T extends BaseModel> extends ModelRepository<T> {
  final CollectionProvider<T> service;

  ModelServiceRepository(this.service);

  @override
  Future<DataState<void>> delete(T model) {
    try {
      return service.delete(model).then((r) => DataSuccess(r), onError: onError);
    } on FirebaseException catch (e) {
      return DataError.future(e.message ?? e.toString(), e.stackTrace);
    } catch (e) {
      return DataError.future(e.toString());
    }
  }

  @override
  Future<DataState<T?>> get(String id) {
    try {
      return service.get(id).then((r) => DataSuccess(r), onError: onError);
    } on FirebaseException catch (e) {
      return DataError.future(e.message ?? e.toString(), e.stackTrace);
    } catch (e) {
      return DataError.future(e.toString());
    }
  }

  @override
  Future<DataState<List<T>>> getList() {
    try {
      return service.getList().then((r) => DataSuccess(r), onError: onError);
    } on FirebaseException catch (e) {
      return DataError.future(e.message ?? e.toString(), e.stackTrace);
    } catch (e) {
      return DataError.future(e.toString());
    }
  }

  @override
  Future<DataState<String>> save(T model) {
    try {
      return service.save(model).then((r) => DataSuccess(r), onError: onError);
    } on FirebaseException catch (e) {
      return DataError.future(e.message ?? e.toString(), e.stackTrace);
    } catch (e) {
      return DataError.future(e.toString());
    }
  }
}

abstract class ModelParamServiceRepository<T extends BaseModel, P> extends ModelParamRepository<T, P> {
  final SubCollectionProvider<T, P> service;

  ModelParamServiceRepository(this.service);

  @override
  Future<DataState<void>> delete(T model, P param) {
    try {
      return service.delete(param, model).then((r) => DataSuccess(r), onError: onError);
    } on FirebaseException catch (e) {
      return DataError.future(e.message ?? e.toString(), e.stackTrace);
    } catch (e) {
      return DataError.future(e.toString());
    }
  }

  @override
  Future<DataState<T?>> get(String id, P param) {
    try {
      return service.get(param, id).then((r) => DataSuccess(r), onError: onError);
    } on FirebaseException catch (e) {
      return DataError.future(e.message ?? e.toString(), e.stackTrace);
    } catch (e) {
      return DataError.future(e.toString());
    }
  }

  @override
  Future<DataState<List<T>>> getList(P param) {
    try {
      return service.getList(param).then((r) => DataSuccess(r), onError: onError);
    } on FirebaseException catch (e) {
      return DataError.future(e.message ?? e.toString(), e.stackTrace);
    } catch (e) {
      return DataError.future(e.toString());
    }
  }

  @override
  Future<DataState<String>> save(T model, P param) {
    try {
      return service.save(param, model).then((r) => DataSuccess(r), onError: onError);
    } on FirebaseException catch (e) {
      return DataError.future(e.message ?? e.toString(), e.stackTrace);
    } catch (e) {
      return DataError.future(e.toString());
    }
  }
}
