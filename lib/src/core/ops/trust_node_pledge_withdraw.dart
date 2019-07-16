import 'optype.dart';
import '../operations.dart';
import '../encoder.dart';
import '../../models/models.dart';
import '../../core/core.dart';

class TrustNodePledgeWithdrawOperation extends Operation {
  AssetAmount fee;
  GrapheneId witnessAccount;

  TrustNodePledgeWithdrawOperation(this.witnessAccount, this.fee);

  @override
  OpType opType() {
    return OpType.TrustNodePledgeWithdrawOpType;
  }

  @override
  bool serialize(Encoder encoder) {
    encoder.encodeVarint(opType().index);
    this.fee.serialize(encoder);
    this.witnessAccount.serialize(encoder);

    return true;
  }

  @override
  dynamic toJson() {
    final val = <String, dynamic>{
      'witness_account': this.witnessAccount.toJson(),
      'fee': this.fee.toJson(),
    };

    return val;
  }
}