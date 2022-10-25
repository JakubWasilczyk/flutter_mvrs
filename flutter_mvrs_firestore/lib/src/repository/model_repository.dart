import 'package:flutter_mvrs/flutter_mvrs.dart';
import 'package:flutter_mvrs_firestore/flutter_mvrs_firestore.dart';

abstract class ModelServiceRepository<T extends BaseModel> extends ServiceRepository<T>
    with ModelGetServiceRepository, ModelSetServiceRepository {
  ModelServiceRepository(CollectionProvider<T> service) : super(service);
}

abstract class ModelParamServiceRepository<T extends BaseModel, P> extends ServiceParamRepository<T, P>
    with ModelGetParamServiceRepository, ModelSetParamServiceRepository {
  ModelParamServiceRepository(SubCollectionProvider<T, P> service) : super(service);
}
