import 'dart:typed_data';
import "../bytes/bytes.dart" as bytes;

abstract class Serializable {
  bool deserialize(bytes.Reader reader, int ver);
  bool serialize(bytes.Buffer buffer, int ver);

  Uint8List asBytes(int ver) {
    var buffer = new bytes.Buffer();
    serialize(buffer, ver);
    return buffer.asBytes();
  }
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