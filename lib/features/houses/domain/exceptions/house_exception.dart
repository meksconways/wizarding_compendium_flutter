sealed class HouseException implements Exception {
  const HouseException();
}

class HouseFetchException extends HouseException {
  final String message;
  final Object? cause;
  final StackTrace? stackTrace;

  const HouseFetchException(this.message, [this.cause, this.stackTrace]);

  @override
  String toString() => 'HouseFetchException: $message';
}

class HouseNotFoundException extends HouseException {
  final String id;

  const HouseNotFoundException(this.id);

  @override
  String toString() => 'BookNotFoundException: Book with id=$id not found';
}

class HouseInvalidDataException extends HouseException {
  final String message;

  const HouseInvalidDataException(this.message);

  @override
  String toString() => 'HouseInvalidDataException: $message';
}
