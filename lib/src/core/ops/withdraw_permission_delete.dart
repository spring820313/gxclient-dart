import 'optype.dart';
import '../operations.dart';
import '../encoder.dart';
import '../../models/models.dart';
import '../../core/core.dart';

class WithdrawPermissionDeleteOperation extends Operation {
  AssetAmount fee;
  GrapheneId withdrawFromAccount;
  GrapheneId authorizedAccount;
  GrapheneId withdrawPermission;

  WithdrawPermissionDeleteOperation(this.withdrawPermission, this.withdrawFromAccount,
      this.authorizedAccount, this.fee);

  @override
  OpType opType() {
    return OpType.WithdrawPermissionDeleteOpType;
  }

  @override
  bool serialize(Encoder encoder) {
    encoder.encodeVarint(opType().index);
    this.fee.serialize(encoder);
    this.withdrawFromAccount.serialize(encoder);
    this.authorizedAccount.serialize(encoder);
    this.withdrawPermission.serialize(encoder);

    return true;
  }

  @override
  dynamic toJson() {
    final val = <String, dynamic>{
      'withdraw_from_account': this.withdrawFromAccount.toJson(),
      'authorized_account': this.authorizedAccount.toJson(),
      'withdraw_permission': this.withdrawPermission.toJson(),
      'fee': this.fee.toJson(),
    };

    return val;
  }
}