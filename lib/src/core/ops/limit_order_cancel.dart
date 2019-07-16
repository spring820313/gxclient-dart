import 'optype.dart';
import '../operations.dart';
import '../encoder.dart';
import '../../models/models.dart';

class LimitOrderCancelOperation extends Operation {
  AssetAmount fee;
  GrapheneId feePayingAccount;
  GrapheneId order;
  List<dynamic> extensions;

  LimitOrderCancelOperation(this.feePayingAccount, this.order, this.fee);

  @override
  OpType opType() {
    return OpType.LimitOrderCancelOpType;
  }

  @override
  bool serialize(Encoder encoder) {
    encoder.encodeVarint(opType().index);
    this.fee.serialize(encoder);
    this.feePayingAccount.serialize(encoder);
    this.order.serialize(encoder);
    encoder.encodeVarint(0);

    return true;
  }

  @override
  dynamic toJson() {
    final val = <String, dynamic>{
      'fee_paying_account': this.feePayingAccount.toJson(),
      'order': this.order.toJson(),
      'fee': this.fee.toJson(),
      'extensions' : [],
    };

    return val;
  }
}