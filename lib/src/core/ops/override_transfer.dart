import 'optype.dart';
import '../operations.dart';
import '../encoder.dart';
import '../../models/models.dart';

class OverrideTransferOperation extends Operation {
  AssetAmount fee;
  GrapheneId issuer;
  GrapheneId from;
  GrapheneId to;
  AssetAmount amount;
  Memo memo;
  List<dynamic> extensions;

  OverrideTransferOperation(this.issuer, this.from, this.to, this.amount, this.fee, [this.memo]);

  @override
  OpType opType() {
    return OpType.OverrideTransferOpType;
  }

  @override
  bool serialize(Encoder encoder) {
    encoder.encodeVarint(opType().index);
    this.fee.serialize(encoder);
    this.issuer.serialize(encoder);
    this.from.serialize(encoder);
    this.to.serialize(encoder);
    this.amount.serialize(encoder);
    if(this.memo != null && this.memo.message.length > 0) {
      encoder.encodeVarint(1);
      this.memo.serialize(encoder);
    } else {
      //Memo?
      encoder.encodeVarint(0);
    }
    encoder.encodeVarint(0);

    return true;
  }

  @override
  dynamic toJson() {
    final val = <String, dynamic>{
      'from': this.from.toJson(),
      'to': this.to.toJson(),
      'amount': this.amount.toJson(),
      'issuer': this.issuer.toJson(),
      'fee': this.fee.toJson(),
      'extensions' : [],
    };

    if(this.memo != null) {
      val['memo'] = this.memo.toJson();
    }

    return val;
  }
}