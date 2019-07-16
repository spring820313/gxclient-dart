import 'optype.dart';
import '../operations.dart';
import '../encoder.dart';
import '../../models/models.dart';
import '../../core/core.dart';

class TransferFromBlindOperation extends Operation {
  AssetAmount fee;
  AssetAmount amount;
  GrapheneId to;
  String blindingFactor;
  List<BlindInput> inputs;

  TransferFromBlindOperation(this.amount, this.to,
      this.blindingFactor, this.inputs, this.fee);

  @override
  OpType opType() {
    return OpType.TransferFromBlindOpType;
  }

  @override
  bool serialize(Encoder encoder) {
    encoder.encodeVarint(opType().index);
    this.fee.serialize(encoder);
    this.amount.serialize(encoder);
    this.to.serialize(encoder);

    final codeBytes = hexToBytes(this.blindingFactor);
    encoder.encodeVarint(codeBytes.length);
    encoder.encodeBytes(codeBytes);

    encoder.encodeVarint(this.inputs.length);
    for(var i in inputs) {
      i.serialize(encoder);
    }

    return true;
  }

  @override
  dynamic toJson() {
    final val = <String, dynamic>{
      'amount': this.amount.toJson(),
      'to': this.to.toJson(),
      'blinding_factor': this.blindingFactor,
      'inputs': fromList(this.inputs),
      'fee': this.fee.toJson(),
    };

    return val;
  }
}