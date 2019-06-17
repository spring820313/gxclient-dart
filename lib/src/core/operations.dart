import 'dart:typed_data';
import 'ops/optype.dart';
import 'serialization.dart';
import 'encoder.dart';

class Operation extends Serializable{
  OpType opType() {
    return OpType.TransferOpType;
  }

  @override
  bool serialize(Encoder encoder) {
    return false;
  }

  @override
  dynamic toJson() {
    return null;
  }
}

class OperationTuple extends Serializable{
  OpType type;
  Operation op;

  OperationTuple(this.type, this.op);

  bool serialize(Encoder encoder)  {
    return op.serialize(encoder);
  }

  dynamic toJson() {
    var o = [type.index, op];
    return o;
  }
}

class Operations extends Serializable{
  List<Operation> ops = List();

  bool serialize(Encoder encoder)  {
    encoder.encodeVarint(ops.length);
    for(var x in ops) {
      x.serialize(encoder);
    }
    return true;
  }

  dynamic toJson() {
    List<dynamic> result = List();
    for(var x in ops) {
      var o = [x.opType().index, x];
      result.add(o);
    }

    return result;
  }

  void add(Operation op) {
    ops.add(op);
  }
}

