import '../operations.dart';
import '../encoder.dart';
import 'optype.dart';
import '../../models/models.dart';

class TransferOperation extends Operation {
  GrapheneId from;
  GrapheneId to;
  AssetAmount amount;
  AssetAmount fee;
  Memo memo;
  List<dynamic> extensions;

  TransferOperation(this.from, this.to, this.amount, this.fee, this.memo);

  @override
  OpType opType() {
    return OpType.TransferOpType;
  }

  @override
  bool serialize(Encoder encoder) {
    encoder.encodeVarint(opType().index);
    this.fee.serialize(encoder);
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

    //Extensions
    encoder.encodeVarint(0);

    return true;
  }

  @override
  dynamic toJson() {
    final val = <String, dynamic>{
      'from': this.from.toJson(),
      'to':   this.to.toJson(),
      'amount': this.amount.toJson(),
      'fee': this.fee.toJson(),
      'extensions' : [],
    };

    if(this.memo != null) {
      val['memo'] = this.memo.toJson();
    }
    return val;
  }
}