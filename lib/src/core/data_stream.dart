import 'dart:typed_data';
import 'dart:convert';

class DataStream {
  /// Amount of valid data in `array` */
  int length;

  /// Data in serialized (binary) form */
  Uint8List array;

  /// Current position while reading (deserializing) */
  int readPos = 0;


  DataStream(this.array) {
    length = array != null ? array.length : 0;
  }

  /// Resize `array` if needed to have at least `size` bytes free */
  void reserve(int size) {
    if (length + size <= array.length) {
      return;
    }
    var l = array.length;
    while (length + size > l) {
      l = (l * 1.5).ceil();
    }
    var newArray = Uint8List.fromList(array);
    array = newArray;
  }

  /// Is there data available to read? */
  bool haveReadData() {
    return readPos < length;
  }

  /// Restart reading from the beginning */
  void restartRead() {
    readPos = 0;
  }

  /// Return data with excess storage trimmed away */
  Uint8List asUint8List() {
    return Uint8List.view(array.buffer, array.offsetInBytes, length);
  }

  /// Append bytes */
  void pushArray(List<int> v) {
    var t = array.toList();
    t.addAll(v);
    array = Uint8List.fromList(t);
    length += v.length;
  }

  /// Append bytes */
  void push(List<int> v) {
    pushArray(v);
  }

  /// Get a single byte */
  int get() {
    if (readPos < length) {
      return array[readPos++];
    }
    throw 'Read past end of buffer';
  }

  /// Append bytes in `v`. Throws if `len` doesn't match `v.length` */
  void pushUint8ListChecked(Uint8List v, int len) {
    if (v.length != len) {
      throw 'Binary data has incorrect size';
    }
    pushArray(v);
  }

  /// Get `len` bytes */
  Uint8List getUint8List(int len) {
    if (readPos + len > length) {
      throw 'Read past end of buffer';
    }
    var result =
        Uint8List.view(array.buffer, array.offsetInBytes + readPos, len);
    readPos += len;
    return result;
  }

  /// Append a `uint16` */
  void pushUint16(int v) {
    push([(v >> 0) & 0xff, (v >> 8) & 0xff]);
  }

  /// Get a `uint16` */
  int getUint16() {
    var v = 0;
    v |= get() << 0;
    v |= get() << 8;
    return v;
  }

  /// Append a `uint32` */
  void pushUint32(int v) {
    var t = [
      (v >> 0) & 0xff,
      (v >> 8) & 0xff,
      (v >> 16) & 0xff,
      (v >> 24) & 0xff
    ];
    push(t);
  }

  /// Get a `uint32` */
  int getUint32() {
    var v = 0;
    v |= get() << 0;
    v |= get() << 8;
    v |= get() << 16;
    v |= get() << 24;
    return v >> 0;
  }

  /// Append a `uint64`. *Caution*: `number` only has 53 bits of precision */
  void pushNumberAsUint64(int v) {
    pushUint32(v >> 0);
    pushUint32(((v ~/ 0x10000) >> 0).floor());
  }

  int getUint64AsNumber() {
    var low = getUint32();
    var high = getUint32();
    return (high >> 0) * 0x10000 + (low >> 0);
  }

  /// Append a `varuint32` */
  void pushVaruint32(int v) {
    while (true) {
      if (v >> 7 != 0) {
        push([0x80 | (v & 0x7f)]);
        v = v >> 7;
      } else {
        push([v]);
        break;
      }
    }
  }

  /// Get a `varuint32` */
  int getVaruint32() {
    var v = 0;
    var bit = 0;
    while (true) {
      var b = get();
      v |= (b & 0x7f) << bit;
      bit += 7;
      if ((b & 0x80) == 0) {
        break;
      }
    }
    return v >> 0;
  }

  /// Append a `varint32` */
  void pushVarint32(int v) {
    pushVaruint32((v << 1) ^ (v >> 31));
  }

  /// Get a `varint32` */
  int getVarint32() {
    var v = getVaruint32();
    if ((v & 1) != 0) {
      return ((~v) >> 1) | 0x8000;
    } else {
      return v >> 1;
    }
  }

 /** Append a `float32` */
 void pushFloat32(double v) {
     pushArray(Uint8List.view(Float32List.fromList([v]).buffer));
 }

/** Get a `float32` */
 double getFloat32() {
     return Float32List.view(getUint8List(4).buffer)[0];
 }

 /** Append a `float64` */
 void pushFloat64(double v) {
    pushArray(Uint8List.view(Float64List.fromList([v]).buffer));
 }

 /** Get a `float64` */
  double getFloat64() {
    return new Float64List.view(getUint8List(8).buffer)[0];
 }

  /// Append length-prefixed binary data */
  void pushBytes(List<int> v) {
    pushVaruint32(v.length);
    pushArray(v);
  }

  /// Get length-prefixed binary data */
  Uint8List getBytes() {
    return getUint8List(getVaruint32());
  }

  /// Append a string */
  void pushString(String v) {
    pushBytes(utf8.encode(v));
  }

  /// Get a string */
  String getString() {
    return utf8.decode(getBytes());
  }
} // DataStream
