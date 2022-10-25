import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_mvrs/flutter_mvrs.dart';
import 'package:flutter_mvrs_firestore/flutter_mvrs_firestore.dart';

abstract class ListenableServiceRepository<T extends BaseModel> extends ListenableRepository<T> {
  final CollectionProvider<T> service;

  ListenableServiceRepository(this.service);

  @override
  Stream<DataState<T?>> listen(String id) {
    try {
      return service.listen(id).map((r) => DataSuccess(r));
    } on FirebaseException catch (e) {
      return DataError.stream(e.message ?? e.toString(), e.stackTrace);
    } catch (e) {
      return DataError.stream(e.toString());
    }
  }

  @override
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

abstract class ListenableParamServiceRepository<T extends BaseModel, P> extends ListenableParamRepository<T, P> {
  final SubCollectionProvider<T, P> service;

  ListenableParamServiceRepository(this.service);

  @override
  Stream<DataState<T?>> listen(String id, P param) {
    try {
      return service.listen(param, id).map((r) => DataSuccess(r));
    } on FirebaseException catch (e) {
      return DataError.stream(e.message ?? e.toString(), e.stackTrace);
    } catch (e) {
      return DataError.stream(e.toString());
    }
  }

  @override
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
