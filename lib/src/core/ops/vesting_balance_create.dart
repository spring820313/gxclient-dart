import 'optype.dart';
import '../operations.dart';
import '../encoder.dart';
import '../../models/models.dart';
import '../../core/core.dart';

class VestingBalanceCreateOperation extends Operation {
  AssetAmount fee;
  GrapheneId creator;
  GrapheneId owner;
  AssetAmount amount;
  VestingPolicy policy;

  VestingBalanceCreateOperation(this.creator, this.owner, this.amount, this.policy, this.fee);

  @override
  OpType opType() {
    return OpType.VestingBalanceCreateOpType;
  }

  @override
  bool serialize(Encoder encoder) {
    encoder.encodeVarint(opType().index);
    this.fee.serialize(encoder);
    this.creator.serialize(encoder);
    this.owner.serialize(encoder);
    this.amount.serialize(encoder);
    this.policy.serialize(encoder);

    return true;
  }

  @override
  dynamic toJson() {
    final val = <String, dynamic>{
      'creator': this.creator.toJson(),
      'owner': this.owner.toJson(),
      'amount': this.amount.toJson(),
      'policy': this.policy.toJson(),
      'fee': this.fee.toJson(),
    };

    return val;
  }
}