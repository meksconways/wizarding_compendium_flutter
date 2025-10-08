sealed class SpellException implements Exception {
  const SpellException();
}

class SpellFetchException extends SpellException {
  final String message;
  final Object? cause;
  final StackTrace? stackTrace;

  const SpellFetchException(this.message, [this.cause, this.stackTrace]);

  @override
  String toString() => 'SpellFetchException: $message';
}

class SpellNotFoundException extends SpellException {
  final String id;

  const SpellNotFoundException(this.id);

  @override
  String toString() => 'SpellNotFoundException: Spell with id=$id not found';
}

class SpellInvalidDataException extends SpellException {
  final String message;
  final StackTrace? stackTrace;

  const SpellInvalidDataException(this.message, this.stackTrace);

  @override
  String toString() => 'SpellInvalidDataException: $message, $stackTrace';
}
