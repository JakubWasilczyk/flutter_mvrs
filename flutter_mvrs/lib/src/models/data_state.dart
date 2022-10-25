abstract class DataState<T> {}

class DataSuccess<T> implements DataState<T> {
  final T result;

  DataSuccess(this.result);
}

class DataError<T> implements DataState<T> {
  final String message;
  final StackTrace? stackTrace;

  DataError(this.message, [this.stackTrace]);
}
