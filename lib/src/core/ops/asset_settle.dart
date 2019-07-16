import 'optype.dart';
import '../operations.dart';
import '../encoder.dart';
import '../../models/models.dart';

class AssetSettleOperation extends Operation {
  AssetAmount fee;
  GrapheneId account;
  AssetAmount amount;
  List<dynamic> extensions;

  AssetSettleOperation(this.account, this.amount,
      this.fee);

  @override
  OpType opType() {
    return OpType.AssetSettleOpType;
  }

  @override
  bool serialize(Encoder encoder) {
    encoder.encodeVarint(opType().index);
    this.fee.serialize(encoder);
    this.account.serialize(encoder);
    this.amount.serialize(encoder);

    //Extensions
    encoder.encodeVarint(0);

    return true;
  }

  @override
  dynamic toJson() {
    final val = <String, dynamic>{
      'account': this.account.toJson(),
      'amount': this.amount.toJson(),
      'fee': this.fee.toJson(),
      'extensions' : [],
    };

    return val;
  }
}