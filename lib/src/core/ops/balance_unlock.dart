import 'optype.dart';
import '../operations.dart';
import '../encoder.dart';
import '../../models/models.dart';

class BalanceUnlockOperation extends Operation {
  AssetAmount fee;
  GrapheneId account;
  GrapheneId lockId;
  List<dynamic> extensions;

  BalanceUnlockOperation(this.account, this.lockId, this.fee);

  @override
  OpType opType() {
    return OpType.BalanceUnlockOpType;
  }

  @override
  bool serialize(Encoder encoder) {
    encoder.encodeVarint(opType().index);
    this.fee.serialize(encoder);
    this.account.serialize(encoder);
    this.lockId.serialize(encoder);

    //Extensions
    encoder.encodeVarint(0);

    return true;
  }

  @override
  dynamic toJson() {
    final val = <String, dynamic>{
      'account': this.account.toJson(),
      'lock_id': this.lockId.toJson(),
      'fee': this.fee.toJson(),
      'extensions' : [],
    };

    return val;
  }
}