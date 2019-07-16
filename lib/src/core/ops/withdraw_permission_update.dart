import 'optype.dart';
import '../operations.dart';
import '../encoder.dart';
import '../../models/models.dart';
import '../../core/core.dart';

class WithdrawPermissionUpdateOperation extends Operation {
  AssetAmount fee;
  GrapheneId withdrawFromAccount;
  GrapheneId authorizedAccount;
  GrapheneId permissionToUpdate;
  AssetAmount withdrawalLimit;
  int withdrawalPeriodSec;
  Time periodStartTime;
  int periodsUntilExpiration;

  WithdrawPermissionUpdateOperation(this.authorizedAccount, this.withdrawFromAccount,
      this.withdrawalLimit, this.withdrawalPeriodSec, this.permissionToUpdate,
      this.periodsUntilExpiration, this.periodStartTime, this.fee);

  @override
  OpType opType() {
    return OpType.WithdrawPermissionUpdateOpType;
  }

  @override
  bool serialize(Encoder encoder) {
    encoder.encodeVarint(opType().index);
    this.fee.serialize(encoder);
    this.withdrawFromAccount.serialize(encoder);
    this.authorizedAccount.serialize(encoder);
    this.permissionToUpdate.serialize(encoder);
    this.withdrawalLimit.serialize(encoder);
    encoder.encodeUint32(this.withdrawalPeriodSec);
    this.periodStartTime.serialize(encoder);
    encoder.encodeUint32(this.periodsUntilExpiration);

    return true;
  }

  @override
  dynamic toJson() {
    final val = <String, dynamic>{
      'withdraw_from_account': this.withdrawFromAccount.toJson(),
      'authorized_account': this.authorizedAccount.toJson(),
      'permission_to_update': this.permissionToUpdate.toJson(),
      'withdrawal_limit': this.withdrawalLimit.toJson(),
      'withdrawal_period_sec': this.withdrawalPeriodSec,
      'periods_until_expiration': this.periodsUntilExpiration,
      'period_start_time': this.periodStartTime.toJson(),
      'fee': this.fee.toJson(),
    };

    return val;
  }
}