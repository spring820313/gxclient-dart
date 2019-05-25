library bytes.src.buffer;

import "buffer_impl.dart";

abstract class Buffer implements Sink<List<int>> {

  /// Create a new Buffer.
  factory Buffer() => new BufferImpl();

  /// Appends [bytes] at the end of the buffer.
  @override
  void add(List<int> bytes);

  /// Appens a single [byte] at the end of the buffer.
  void addByte(int byte);

  /// Grow the buffer's capacity to guarantee space for another n bytes.
  void grow(int n);

  /// The size of the buffer's content.
  int get length;

  /// The size of the underlying buffer. This is the length to which it can grow
  /// without having to reallocate new space.
  int get capacity;

  /// Clear the content of the buffer.
  void clear();

  /// Returns `true` if this buffer is empty.
  bool get isEmpty;

  /// Returns a view on the current content of the buffer.
  List<int> asBytes();

  /// Returns a copy of the current content of the buffer.
  List<int> copyBytes();

  /// Returns a view on the current content of the buffer and clears its
  /// contents.
  List<int> takeBytes();
}
