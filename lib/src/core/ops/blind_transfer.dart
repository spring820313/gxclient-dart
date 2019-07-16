import 'optype.dart';
import '../operations.dart';
import '../encoder.dart';
import '../../models/models.dart';
import '../serialization.dart';

class BlindTransferOperation extends Operation {
  AssetAmount fee;
  List<BlindInput> inputs;
  List<BlindOutput> outputs;

  BlindTransferOperation(this.inputs, this.outputs, this.fee);

  @override
  OpType opType() {
    return OpType.BlindTransferOpType;
  }

  @override
  bool serialize(Encoder encoder) {
    encoder.encodeVarint(opType().index);
    this.fee.serialize(encoder);
    encoder.encodeVarint(this.inputs.length);
    for(var i in inputs) {
      i.serialize(encoder);
    }

    encoder.encodeVarint(this.outputs.length);
    for(var o in this.outputs) {
      o.serialize(encoder);
    }

    return true;
  }

  @override
  dynamic toJson() {
    final val = <String, dynamic>{
      'inputs': fromList(this.inputs),
      'outputs': fromList(this.outputs),
      'fee': this.fee.toJson(),
    };

    return val;
  }
}