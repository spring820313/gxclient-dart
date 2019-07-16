import 'optype.dart';
import '../operations.dart';
import '../encoder.dart';
import '../../models/models.dart';
import '../../core/core.dart';

class WithdrawPermissionClaimOperation extends Operation {
  AssetAmount fee;
  GrapheneId withdrawPermission;
  GrapheneId withdrawFromAccount;
  GrapheneId withdrawToAccount;
  AssetAmount amountToWithdraw;
  Memo memo;

  WithdrawPermissionClaimOperation(this.withdrawPermission, this.withdrawFromAccount,
      this.withdrawToAccount, this.amountToWithdraw, this.fee, [this.memo]);

  @override
  OpType opType() {
    return OpType.WithdrawPermissionClaimOpType;
  }

  @override
  bool serialize(Encoder encoder) {
    encoder.encodeVarint(opType().index);
    this.fee.serialize(encoder);
    this.withdrawPermission.serialize(encoder);
    this.withdrawFromAccount.serialize(encoder);
    this.withdrawToAccount.serialize(encoder);
    this.amountToWithdraw.serialize(encoder);

    if(this.memo != null && this.memo.message.length > 0) {
      encoder.encodeVarint(1);
      this.memo.serialize(encoder);
    } else {
      //Memo?
      encoder.encodeVarint(0);
    }

    return true;
  }

  @override
  dynamic toJson() {
    final val = <String, dynamic>{
      'withdraw_permission': this.withdrawPermission.toJson(),
      'withdraw_from_account': this.withdrawFromAccount.toJson(),
      'withdraw_to_account': this.withdrawToAccount.toJson(),
      'amount_to_withdraw': this.amountToWithdraw.toJson(),
      'fee': this.fee.toJson(),
    };

    if(this.memo != null) {
      val['memo'] = this.memo.toJson();
    }

    return val;
  }
}