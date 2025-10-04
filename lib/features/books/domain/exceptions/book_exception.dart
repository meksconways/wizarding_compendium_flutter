sealed class BookException implements Exception {
  const BookException();
}

class BookFetchException extends BookException {
  final String message;
  final Object? cause;
  final StackTrace? stackTrace;

  const BookFetchException(this.message, [this.cause, this.stackTrace]);

  @override
  String toString() => 'BookFetchException: $message';
}

class BookNotFoundException extends BookException {
  final String id;

  const BookNotFoundException(this.id);

  @override
  String toString() => 'BookNotFoundException: Book with id=$id not found';
}

class BookInvalidDataException extends BookException {
  final String message;

  const BookInvalidDataException(this.message);

  @override
  String toString() => 'BookInvalidDataException: $message';
}
