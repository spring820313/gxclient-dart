import "dart:convert";
import "dart:typed_data";
import 'package:pointycastle/src/utils.dart';


Uint8List toBytes(List<int> bytes, [int start = 0, int end = -1]) {
  if (bytes == null) return null;
  if (end == -1) end = bytes.length;
  if (bytes is Uint8List) {
    return new Uint8List.view(bytes.buffer, start, end - start);
  }
  if (start == 0 && end == bytes.length) {
    return new Uint8List.fromList(bytes);
  }
  Uint8List result = new Uint8List(end - start);
  for (int i = 0; i < end - start; i++) {
    result[i] = bytes[start + i];
  }
  return result;
}

Uint8List utf8Encode(String string) {
  List<int> encoded = utf8.encode(string);
  return encoded is Uint8List ? encoded : new Uint8List.fromList(encoded);
}

String utf8Decode(Uint8List bytes) => utf8.decode(bytes);

Uint8List reverseBytes(Uint8List bytes) {
  if (bytes == null) return null;
  int length = bytes.length;
  Uint8List result = new Uint8List(length);
  for (int i = 0; i < length; i++) result[i] = bytes[length - 1 - i];
  return result;
}


Uint8List concatBytes(Uint8List bytes1, Uint8List bytes2) {
  Uint8List result = new Uint8List(bytes1.length + bytes2.length);
  result.setRange(0, bytes1.length, bytes1);
  result.setRange(bytes1.length, result.length, bytes2);
  return result;
}

Uint8List uintToBytesLE(int val, [int size = -1]) {
  if (val < 0) throw new Exception("Only positive values allowed.");
  List<int> result = new List();
  while (val > 0) {
    int mod = val & 0xff;
    val = val >> 8;
    result.add(mod);
  }
  if (size >= 0 && result.length > size) throw new Exception("Value doesn't fit in given size.");
  while (result.length < size) result.add(0);
  return new Uint8List.fromList(result);
}

Uint8List uintToBytesBE(int val, [int size = -1]) {
  if (val < 0) throw new ArgumentError("Only positive values allowed.");
  List<int> result = new List();
  while (val > 0) {
    int mod = val & 0xff;
    val = val >> 8;
    result.insert(0, mod);
  }
  if (size >= 0 && result.length > size)
    throw new ArgumentError("Value doesn't fit in given size.");
  while (result.length < size) result.insert(0, 0);
  return new Uint8List.fromList(result);
}

Uint8List uBigIntToBytesLE(BigInt val, [int size = -1]) {
  List<int> bytes = encodeBigInt(val);
  if (bytes.length > size && size >= 0) {
    throw new Exception("Input too large to encode into a uint64");
  }
  bytes = new List.from(bytes.reversed);
  if (bytes.length < size) {
    while (bytes.length < size) bytes.add(0);
  }
  return new Uint8List.fromList(bytes);
}

BigInt bytesToUBigIntLE(Uint8List bytes, [int size = -1]) {
  if (size < 0) size = bytes.length;
  ByteData bd = bytes.buffer.asByteData();
  return decodeBigInt(reverseBytes(bytes.sublist(0, size)));
}


int bytesToUintBE(Uint8List bytes, [int size]) {
  if (size == null) size = bytes.length;
  int result = 0;
  for (int i = 0; i < size; i++) {
    result += bytes[i] << (8 * (size - i - 1));
  }
  return result;
}




