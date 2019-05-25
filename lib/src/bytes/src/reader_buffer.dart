library bytes.src.reader_buffer;

import "dart:typed_data";

import "buffer.dart";
import "reader.dart";
import "reader_buffer_impl.dart";

abstract class ReaderBuffer implements Reader, Buffer {
  /// Create a new [ReaderBuffer] with [bytes] as it's initial content.
  ///
  /// Arguments:
  ///  - [bytes]: the initial content of the buffer - can be either
  ///             [ByteBuffer], [TypedData] or [List<int>].
  ///  - [offset]: the initial reading offset
  ///  - [copy]: if true, this [ReaderBuffer] will always make a copy of data
  ///            before returning it
  factory ReaderBuffer({dynamic bytes, int offset: 0, bool copy: false}) {
    // extract a ByteBuffer from the bytes data
    Uint8List buffer;
    int length;
    if (bytes == null) {
      buffer = null;
      length = 0;
    } else if (bytes is ByteBuffer) {
      buffer = new Uint8List.view(bytes, 0, bytes.lengthInBytes);
      length = bytes.lengthInBytes;
    } else if (bytes is TypedData) {
      buffer = new Uint8List.view(
          bytes.buffer, bytes.offsetInBytes, bytes.lengthInBytes);
      length = buffer.length;
    } else if (bytes is List) {
      buffer = new Uint8List.fromList(bytes);
      length = buffer.length;
    }

    return new ReaderBufferImpl(buffer, offset ?? 0, length, copy ?? false);
  }
}
