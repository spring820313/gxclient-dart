import 'optype.dart';
import '../operations.dart';
import '../encoder.dart';
import '../../models/models.dart';
import '../../core/core.dart';

class VestingBalanceWithdrawOperation extends Operation {
  AssetAmount fee;
  GrapheneId vestingBalance;
  GrapheneId owner;
  AssetAmount amount;

  VestingBalanceWithdrawOperation(this.vestingBalance, this.owner, this.amount, this.fee);

  @override
  OpType opType() {
    return OpType.VestingBalanceWithdrawOpType;
  }

  @override
  bool serialize(Encoder encoder) {
    encoder.encodeVarint(opType().index);
    this.fee.serialize(encoder);
    this.vestingBalance.serialize(encoder);
    this.owner.serialize(encoder);
    this.amount.serialize(encoder);

    return true;
  }

  @override
  dynamic toJson() {
    final val = <String, dynamic>{
      'vesting_balance': this.vestingBalance.toJson(),
      'owner': this.owner.toJson(),
      'amount': this.amount.toJson(),
      'fee': this.fee.toJson(),
    };

    return val;
  }
}