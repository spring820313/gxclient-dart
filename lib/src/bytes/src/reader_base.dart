library bytes.src.reader_base;

import "reader.dart";

/// Base implementations of the [Reader] interface.
abstract class ReaderBase implements Reader {
  @override
  int readByte() => readBytes(1)[0];

  @override
  int addToSink(Sink<List<int>> sink) {
    int num = remainingLength;
    sink.add(readBytes(num));
    return num;
  }
}
