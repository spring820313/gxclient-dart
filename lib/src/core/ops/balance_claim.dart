import 'optype.dart';
import '../operations.dart';
import '../encoder.dart';
import '../../models/models.dart';

class BalanceClaimOperation extends Operation {
  AssetAmount fee;
  GrapheneId depositToAccount;
  GrapheneId balanceToClaim;
  String balanceOwnerKey;
  AssetAmount totalClaimed;

  BalanceClaimOperation(this.depositToAccount, this.balanceToClaim, this.balanceOwnerKey, this.totalClaimed,
      this.fee);

  @override
  OpType opType() {
    return OpType.BalanceClaimOpType;
  }

  @override
  bool serialize(Encoder encoder) {
    encoder.encodeVarint(opType().index);
    this.fee.serialize(encoder);
    this.depositToAccount.serialize(encoder);
    this.balanceToClaim.serialize(encoder);
    encoder.encodePubKey(this.balanceOwnerKey);
    this.totalClaimed.serialize(encoder);

    //Extensions
    encoder.encodeVarint(0);

    return true;
  }

  @override
  dynamic toJson() {
    final val = <String, dynamic>{
      'deposit_to_account': this.depositToAccount.toJson(),
      'balance_to_claim': this.balanceToClaim.toJson(),
      'balance_owner_key': this.balanceOwnerKey,
      'total_claimed': this.totalClaimed.toJson(),
      'fee': this.fee.toJson(),
      'extensions' : [],
    };

    return val;
  }
}