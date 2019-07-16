import 'optype.dart';
import '../operations.dart';
import '../encoder.dart';
import '../../models/models.dart';

class InlineTransferOperation extends Operation {
  AssetAmount fee;
  GrapheneId from;
  GrapheneId to;
  AssetAmount amount;
  String memo;
  List<dynamic> extensions;

  InlineTransferOperation(this.from, this.to, this.amount, this.memo, this.fee);

  @override
  OpType opType() {
    return OpType.InlineTransferOpType;
  }

  @override
  bool serialize(Encoder encoder) {
    encoder.encodeVarint(opType().index);
    this.fee.serialize(encoder);
    this.from.serialize(encoder);
    this.to.serialize(encoder);
    this.amount.serialize(encoder);
    encoder.encodeString(this.memo);
    encoder.encodeVarint(0);

    return true;
  }

  @override
  dynamic toJson() {
    final val = <String, dynamic>{
      'from': this.from.toJson(),
      'to': this.to.toJson(),
      'amount': this.amount.toJson(),
      'memo': this.memo,
      'fee': this.fee.toJson(),
      'extensions' : [],
    };

    return val;
  }
}