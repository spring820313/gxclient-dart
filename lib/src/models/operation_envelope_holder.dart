import '../core/core.dart';

class OperationEnvelopeHolder extends Serializable{
  OperationTuple op;

  OperationEnvelopeHolder(this.op);

  bool serialize(Encoder encoder)  {
    return op.serialize(encoder);
  }

  dynamic toJson() {
    final val = <String, dynamic>{
      'op': this.op.toJson(),
    };
    return val;
  }
}