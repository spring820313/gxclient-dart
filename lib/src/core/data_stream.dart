import 'dart:typed_data';
import 'dart:convert';
import 'numeric.dart' as numeric;
import '../ecc/ecc.dart';
import '../core/formatting.dart';

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

  /// Append a `uint64` */
  void pushUint64(int v) {
    var t = [
      (v >> 0) & 0xff,
      (v >> 8) & 0xff,
      (v >> 16) & 0xff,
      (v >> 24) & 0xff,
      (v >> 32) & 0xff,
      (v >> 40) & 0xff,
      (v >> 48) & 0xff,
      (v >> 56) & 0xff
    ];
    push(t);
  }

  /// Get a `uint64` */
  int getUint64() {
    var v = 0;
    v |= get() << 0;
    v |= get() << 8;
    v |= get() << 16;
    v |= get() << 24;
    v |= get() << 32;
    v |= get() << 40;
    v |= get() << 48;
    v |= get() << 56;
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

  void writeBytes(List<int> v) {
    pushArray(v);
  }

  /// Append a `symbol_code`. Unlike `symbol`, `symbol_code` doesn't include a precision. */
  void pushSymbolCode(String name) {
    Uint8List a = Uint8List.fromList(utf8.encode(name));
    while (a.length < 8) {
      a.add(0);
    }
    pushArray(a.sublist(0, 8));
  }

  /// Get a `symbol_code`. Unlike `symbol`, `symbol_code` doesn't include a precision. */
  dynamic getSymbolCode() {
    var a = getUint8List(8);
    int len;
    for (len = 0; len < a.length; ++len) {
      if (a[len] == 0) {
        break;
      }
    }
    var name = utf8.decode(Uint8List.view(a.buffer, a.offsetInBytes, len));
    return name;
  }

  /*
  /// Append a `symbol`
  void pushSymbol(Symbol symbol) {
    var a = [symbol.precision & 0xff];
    a.addAll(utf8.encode(symbol.name));
    while (a.length < 8) {
      a.add(0);
    }
    pushArray(a.sublist(0, 8));
  }

  /// Get a `symbol`
  Symbol getSymbol() {
    var precision = get();
    var a = getUint8List(7);
    int len;
    for (len = 0; len < a.length; ++len) {
      if (a[len] == 0) {
        break;
      }
    }
    var name = utf8.decode(new Uint8List.view(a.buffer, a.offsetInBytes, len));
    return Symbol(name: name, precision: precision);
  }

  /// Append an asset
  void pushAsset(String s) {
    s = s.trim();
    var pos = 0;
    var amount = '';
    var precision = 0;
    if (s[pos] == '-') {
      amount += '-';
      ++pos;
    }
    var foundDigit = false;
    while (pos < s.length &&
        s.codeUnitAt(pos) >= '0'.codeUnitAt(0) &&
        s.codeUnitAt(pos) <= '9'.codeUnitAt(0)) {
      foundDigit = true;
      amount += s[pos];
      ++pos;
    }
    if (!foundDigit) {
      throw 'Asset must begin with a number';
    }
    if (s[pos] == '.') {
      ++pos;
      while (pos < s.length &&
          s.codeUnitAt(pos) >= '0'.codeUnitAt(0) &&
          s.codeUnitAt(pos) <= '9'.codeUnitAt(0)) {
        amount += s[pos];
        ++precision;
        ++pos;
      }
    }
    var name = s.substring(pos).trim();
    pushArray(numeric.signedDecimalToBinary(8, amount));
    pushSymbol(Symbol(name: name, precision: precision));
  }

  /// Get an asset
  String getAsset() {
    var amount = getUint8List(8);
    var sym = getSymbol();
    var s = numeric.signedBinaryToDecimal(amount, minDigits: sym.precision + 1);
    if (sym.precision != 0) {
      s = s.substring(0, s.length - sym.precision) +
          '.' +
          s.substring(s.length - sym.precision);
    }
    return s + ' ' + sym.name;
  }
*/

  /// Append a `name` */
  void pushName(String s) {
    charToSymbol(int c) {
      if (c >= 'a'.codeUnitAt(0) && c <= 'z'.codeUnitAt(0)) {
        return (c - 'a'.codeUnitAt(0)) + 6;
      }
      if (c >= '1'.codeUnitAt(0) && c <= '5'.codeUnitAt(0)) {
        return (c - '1'.codeUnitAt(0)) + 1;
      }
      return 0;
    }

    var a = new Uint8List(8);
    var bit = 63;
    for (var i = 0; i < s.length; ++i) {
      var c = charToSymbol(s.codeUnitAt(i));
      if (bit < 5) {
        c = c << 1;
      }
      for (var j = 4; j >= 0; --j) {
        if (bit >= 0) {
          a[(bit / 8).floor()] |= ((c >> j) & 1) << (bit % 8);
          --bit;
        }
      }
    }
    //var t = bytesToHex(a);
    pushArray(a);
  }

  /// Get a `name` */
  String getName() {
    var a = getUint8List(8);
    var result = '';
    for (var bit = 63; bit >= 0;) {
      var c = 0;
      for (var i = 0; i < 5; ++i) {
        if (bit >= 0) {
          c = (c << 1) | ((a[(bit / 8).floor()] >> (bit % 8)) & 1);
          --bit;
        }
      }
      if (c >= 6) {
        result += String.fromCharCode(c + 'a'.codeUnitAt(0) - 6);
      } else if (c >= 1) {
        result += String.fromCharCode(c + '1'.codeUnitAt(0) - 1);
      } else {
        result += '.';
      }
    }
    while (result.endsWith('.')) {
      result = result.substring(0, result.length - 1);
    }
    return result;
  }

  /// Append a public key */
  void pushPublicKey(String s) {
    var key = GXCPublicKey.fromString(s);
    //pushVarint32(numeric.publicKeyDataSize);
    pushArray(key.toBuffer());
  }

  /// Get a public key */
  String getPublicKey() {
    //var size = getVaruint32();
    var data = getUint8List(numeric.publicKeyDataSize);
    return GXCPublicKey.fromBuffer(data).toString();
  }

  /// Append a private key */
  void pushPrivateKey(String s) {
    var key = GXCPrivateKey.fromString(s);
    //pushVarint32(numeric.privateKeyDataSize);
    pushArray(key.d);
  }

  /// Get a private key */
  String getPrivateKey() {
    //var size = getVaruint32();
    var data = getUint8List(numeric.privateKeyDataSize);
    return GXCPrivateKey.fromBuffer(data).toString();
  }

  /// Append a signature */
  void pushSignature(String s) {
    var bs = hexToBytes(s);
    pushArray(bs);
  }

  /// Get a signature */
  String getSignature() {
    var data = getUint8List(numeric.signatureDataSize);
    return bytesToHex(data);
  }
} // DataStream
