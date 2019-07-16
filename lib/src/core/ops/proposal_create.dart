import 'optype.dart';
import '../operations.dart';
import '../encoder.dart';
import '../../models/models.dart';
import '../../core/core.dart';

class ProposalCreateOperation extends Operation {
  AssetAmount fee;
  GrapheneId feePayingAccount;
  Time expirationTime;
  List<OperationEnvelopeHolder> proposedOps;
  int reviewPeriodSeconds;
  List<dynamic> extensions;

  ProposalCreateOperation(this.feePayingAccount, this.expirationTime,
      this.proposedOps, this.fee, [this.reviewPeriodSeconds]);

  @override
  OpType opType() {
    return OpType.ProposalCreateOpType;
  }

  @override
  bool serialize(Encoder encoder) {
    encoder.encodeVarint(opType().index);
    this.fee.serialize(encoder);
    this.feePayingAccount.serialize(encoder);
    this.expirationTime.serialize(encoder);
    encoder.encodeVarint(this.proposedOps.length);
    for(var p in this.proposedOps) {
      p.serialize(encoder);
    }
    encoder.encodeBool(this.reviewPeriodSeconds != null);
    if(this.reviewPeriodSeconds != null)
      encoder.encodeUint32(this.reviewPeriodSeconds);
    encoder.encodeVarint(0);

    return true;
  }

  @override
  dynamic toJson() {
    final val = <String, dynamic>{
      'fee_paying_account': this.feePayingAccount.toJson(),
      'expiration_time': this.expirationTime.toJson(),
      'proposed_ops': fromList(this.proposedOps),
      'fee': this.fee.toJson(),
      'extensions' : [],
    };

    if(this.reviewPeriodSeconds != null) {
      val['review_period_seconds'] = this.reviewPeriodSeconds;
    }

    return val;
  }
}