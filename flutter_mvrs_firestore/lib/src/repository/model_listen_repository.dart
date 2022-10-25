import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_mvrs/flutter_mvrs.dart';
import 'package:flutter_mvrs_firestore/flutter_mvrs_firestore.dart';

mixin ModelListenServiceRepository<T extends BaseModel> on ServiceRepository<T> {
  Stream<DataState<T?>> listen(String id) {
    try {
      return service.listen(id).map((r) => DataSuccess(r));
    } on FirebaseException catch (e) {
      return DataError.stream(e.message ?? e.toString(), e.stackTrace);
    } catch (e) {
      return DataError.stream(e.toString());
    }
  }

  Stream<DataState<List<T>>> listenList() {
    try {
      return service.listenList().map((r) => DataSuccess(r));
    } on FirebaseException catch (e) {
      return DataError.stream(e.message ?? e.toString(), e.stackTrace);
    } catch (e) {
      return DataError.stream(e.toString());
    }
  }
}

mixin ModelListenParamServiceRepository<T extends BaseModel, P> on ServiceParamRepository<T, P> {
  Stream<DataState<T?>> listen(String id, P param) {
    try {
      return service.listen(param, id).map((r) => DataSuccess(r));
    } on FirebaseException catch (e) {
      return DataError.stream(e.message ?? e.toString(), e.stackTrace);
    } catch (e) {
      return DataError.stream(e.toString());
    }
  }

  Stream<DataState<List<T>>> listenList(P param) {
    try {
      return service.listenList(param).map((r) => DataSuccess(r));
    } on FirebaseException catch (e) {
      return DataError.stream(e.message ?? e.toString(), e.stackTrace);
    } catch (e) {
      return DataError.stream(e.toString());
    }
  }
}
