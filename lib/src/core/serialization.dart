import 'dart:typed_data';
import "encoder.dart";

abstract class Serializable {
  bool serialize(Encoder encoder);
  dynamic toJson();
}

class SerializationException implements Exception {
  final String message;

  SerializationException([String this.message]);

  @override
  String toString() => "SerializationException: $message";

  @override
  bool operator ==(dynamic other) {
    if (other.runtimeType != SerializationException) return false;
    return message == other.message;
  }
}