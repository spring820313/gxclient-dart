import 'optype.dart';
import '../operations.dart';
import '../encoder.dart';
import '../../models/models.dart';
import '../../core/core.dart';

class TransferToBlindOperation extends Operation {
  AssetAmount fee;
  AssetAmount amount;
  GrapheneId from;
  String blindingFactor;
  List<BlindOutput> outputs;

  TransferToBlindOperation(this.amount, this.from,
      this.blindingFactor, this.outputs, this.fee);

  @override
  OpType opType() {
    return OpType.TransferToBlindOpType;
  }

  @override
  bool serialize(Encoder encoder) {
    encoder.encodeVarint(opType().index);
    this.fee.serialize(encoder);
    this.amount.serialize(encoder);
    this.from.serialize(encoder);

    final codeBytes = hexToBytes(this.blindingFactor);
    encoder.encodeVarint(codeBytes.length);
    encoder.encodeBytes(codeBytes);

    encoder.encodeVarint(this.outputs.length);
    for(var i in outputs) {
      i.serialize(encoder);
    }

    return true;
  }

  @override
  dynamic toJson() {
    final val = <String, dynamic>{
      'amount': this.amount.toJson(),
      'from': this.from.toJson(),
      'blinding_factor': this.blindingFactor,
      'outputs': fromList(this.outputs),
      'fee': this.fee.toJson(),
    };

    return val;
  }
}