import '../operations.dart';
import '../encoder.dart';
import 'optype.dart';
import '../../models/models.dart';

class AccountUpgradeOperation extends Operation {
  AssetAmount fee;
  GrapheneId accountToUpgrade;
  bool upgradeToLifetimeMember;
  List<dynamic> extensions;

  AccountUpgradeOperation(this.accountToUpgrade, this.upgradeToLifetimeMember, this.fee);

  @override
  OpType opType() {
    return OpType.AccountUpgradeOpType;
  }

  @override
  bool serialize(Encoder encoder) {
    encoder.encodeVarint(opType().index);
    this.fee.serialize(encoder);
    this.accountToUpgrade.serialize(encoder);
    encoder.encodeBool(this.upgradeToLifetimeMember);

    //Extensions
    encoder.encodeVarint(0);

    return true;
  }

  @override
  dynamic toJson() {
    final val = <String, dynamic>{
      'account_to_upgrade': this.accountToUpgrade.toJson(),
      'upgrade_to_lifetime_member': this.upgradeToLifetimeMember,
      'fee': this.fee.toJson(),
      'extensions' : [],
    };

    return val;
  }
}