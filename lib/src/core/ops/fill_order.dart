import 'optype.dart';
import '../operations.dart';
import '../encoder.dart';
import '../../models/models.dart';

class FillOrderOperation extends Operation {
  AssetAmount fee;
  GrapheneId orderId;
  GrapheneId accountId;
  AssetAmount pays;
  AssetAmount receives;

  FillOrderOperation(this.orderId, this.accountId, this.pays, this.receives, this.fee);

  @override
  OpType opType() {
    return OpType.FillOrderOpType;
  }

  @override
  bool serialize(Encoder encoder) {
    encoder.encodeVarint(opType().index);
    this.fee.serialize(encoder);
    this.orderId.serialize(encoder);
    this.accountId.serialize(encoder);
    this.pays.serialize(encoder);
    this.receives.serialize(encoder);

    return true;
  }

  @override
  dynamic toJson() {
    final val = <String, dynamic>{
      'order_id': this.orderId.toJson(),
      'account_id': this.accountId.toJson(),
      'pays': this.pays.toJson(),
      'receives': this.receives.toJson(),
      'fee': this.fee.toJson(),
    };

    return val;
  }
}