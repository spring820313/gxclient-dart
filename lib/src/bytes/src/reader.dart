library bytes.src.reader;

import "dart:typed_data";

import "reader_impl.dart";

/// A class for reading bytes from an underlying buffer.
abstract class Reader {
  /// Create a new [Reader] for [bytes].
  ///
  /// Arguments:
  ///  - [bytes]: the underlying byte buffer - can be either [ByteBuffer],
  ///             [TypedData] or [List<int>].
  ///  - [offset]: the initial offset
  ///  - [copy]: if true, this [Reader] will always make a copy of data before
  ///            returning it
  factory Reader(dynamic bytes, {int offset: 0, bool copy: false}) {
    // extract a ByteBuffer from the bytes data
    ByteBuffer buffer;
    if (bytes is ByteBuffer) {
      buffer = bytes;
    } else if (bytes is TypedData) {
      buffer = bytes.buffer;
      offset += bytes.offsetInBytes;
    } else if (bytes is List) {
      buffer = new Uint8List.fromList(bytes).buffer;
    }

    return new ReaderImpl(buffer, offset ?? 0, copy ?? false);
  }

  /// The number of bytes in the unread portion of the reader.
  int get remainingLength;

  /// The total size of the underlying bytes.
  int get length;

  /// Read the next [n] bytes.
  List<int> readBytes(int n);

  /// Read and copy bytes into [b] and return the number of bytes read.
  /// This value will be the minimum of [remaining] and [b.length].
  int readBytesInto(List<int> b);

  /// Read a single byte.
  int readByte();

  /// Write the remaining content into [sink] and return the amount of bytes
  /// written.
  int addToSink(Sink<List<int>> sink);
}
