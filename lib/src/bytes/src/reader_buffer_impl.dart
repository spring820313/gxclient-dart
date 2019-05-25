library bytes.src.reader_buffer_impl;

import "dart:math";
import "dart:typed_data";

import "eof_exception.dart";
import "reader_base.dart";
import "reader_buffer.dart";

/// The default implementation of [ReaderBuffer].
class ReaderBufferImpl extends ReaderBase implements ReaderBuffer {
  // Start with 1024 bytes.
  static const int _INIT_SIZE = 1024;

  Uint8List _buffer;
  int _offset = 0;
  int _length = 0;

  bool _copy;

  ReaderBufferImpl(this._buffer, this._offset, this._length, this._copy);

  @override
  void add(List<int> bytes) {
    int bytesLength = bytes.length;
    if (bytesLength == 0) return;
    int required = _length + bytesLength;
    if (_buffer == null || _buffer.length < required) {
      grow(required);
    }
    assert(_buffer.length >= required);
    if (bytes is Uint8List) {
      _buffer.setRange(_length, required, bytes);
    } else {
      for (int i = 0; i < bytesLength; i++) {
        _buffer[_length + i] = bytes[i];
      }
    }
    _length = required;
  }

  @override
  void addByte(int byte) {
    add([byte]);
  }

  @override
  void grow(int n) {
    if (n < 0) throw new ArgumentError.value(n, "n", "negative");
    // We will create a list in the range of 2-4 times larger than
    // required.
    int size = _pow2roundup(n);
    size = max(size, _INIT_SIZE);
    var newBuffer = new Uint8List(size);
    if (_buffer != null) {
      newBuffer.setRange(0, _buffer.length, _buffer);
    }
    _buffer = newBuffer;
  }

  // create a Uint8List view on the underlying ByteBuffer of _buffer
  Uint8List _view(int offset, int size) =>
      _buffer.buffer.asUint8List(_buffer.offsetInBytes + offset, size);

  @override
  List<int> readBytes(int n) {
    if (n < 0) throw new ArgumentError.value(n, "n", "negative");
    if (remainingLength < n) throw new EndOfFileException();

    Uint8List result = _view(_offset, n);
    if (_copy) {
      result = new Uint8List.fromList(result);
    }
    _offset += n;
    return result;
  }

  @override
  int readBytesInto(List<int> b) {
    int num = min(remainingLength, b.length);
    b.setRange(0, num, _view(_offset, num));
    _offset += num;
    return num;
  }

  @override
  int get length => _length;

  @override
  int get capacity => _buffer.length;

  @override
  int get remainingLength => _length - _offset;

  @override
  bool get isEmpty => _length == 0;

  @override
  void clear() {
    _length = 0;
    _offset = 0;
    _buffer = null;
  }

  @override
  void close() {}

  @override
  List<int> asBytes() {
    if (_buffer == null) return new Uint8List(0);
    return _view(0, length);
  }

  @override
  List<int> copyBytes() {
    if (_buffer == null) return new Uint8List(0);
    return new Uint8List.fromList(asBytes());
  }

  @override
  List<int> takeBytes() {
    var bytes = asBytes();
    clear();
    return bytes;
  }

  int _pow2roundup(int x) {
    --x;
    x |= x >> 1;
    x |= x >> 2;
    x |= x >> 4;
    x |= x >> 8;
    x |= x >> 16;
    return x + 1;
  }
}
