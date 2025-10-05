sealed class CharacterException implements Exception {
  const CharacterException();
}

class CharacterFetchException extends CharacterException {
  final String message;
  final Object? cause;
  final StackTrace? stackTrace;

  const CharacterFetchException(this.message, [this.cause, this.stackTrace]);

  @override
  String toString() => 'CharacterFetchException: $message';
}

class CharacterNotFoundException extends CharacterException {
  final String id;

  const CharacterNotFoundException(this.id);

  @override
  String toString() => 'HouseNotFoundException: House with id=$id not found';
}

class CharacterInvalidDataException extends CharacterException {
  final String message;

  const CharacterInvalidDataException(this.message);

  @override
  String toString() => 'CharacterInvalidDataException: $message';
}
