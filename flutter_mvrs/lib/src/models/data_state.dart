abstract class DataState<T> {}

class DataSuccess<T> implements DataState<T> {
  final T result;

  DataSuccess(this.result);
}

class DataError<T> implements DataState<T> {
  final String message;
  final StackTrace? stackTrace;

  DataError(this.message, [this.stackTrace]);

  static Future<DataError<T>> future<T>(String message, [StackTrace? stackTrace]) {
    return Future.value(DataError(message, stackTrace));
  }

  static Stream<DataError<T>> stream<T>(String message, [StackTrace? stackTrace]) {
    return Stream.value(DataError(message, stackTrace));
  }
}
