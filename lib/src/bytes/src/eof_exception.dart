library bytes.src.eof_exception;

/// An [Exception] that is throws when trying to read more bytes than available.
class EndOfFileException implements Exception {
  @override
  String toString() => "EOF";
}
