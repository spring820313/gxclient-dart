import '../operations.dart';
import '../encoder.dart';
import 'optype.dart';
import '../../models/models.dart';
import '../../core/core.dart';

class AssertOperation extends Operation {
  AssetAmount fee;
  GrapheneId feePayingAccount;
  List<Predicate> predicates;
  List<GrapheneId> requiredAuths;
  List<dynamic> extensions;

  AssertOperation(this.feePayingAccount, this.predicates, this.requiredAuths, this.fee);

  @override
  OpType opType() {
    return OpType.AssertOpType;
  }

  @override
  bool serialize(Encoder encoder) {
    encoder.encodeVarint(opType().index);
    this.fee.serialize(encoder);
    this.feePayingAccount.serialize(encoder);
    encoder.encodeVarint(this.predicates.length);
    for(var p in this.predicates) {
      p.serialize(encoder);
    }
    encoder.encodeVarint(this.requiredAuths.length);
    for(var r in this.requiredAuths) {
      r.serialize(encoder);
    }

    //Extensions
    encoder.encodeVarint(0);

    return true;
  }

  @override
  dynamic toJson() {
    final val = <String, dynamic>{
      'fee_paying_account': this.feePayingAccount.toJson(),
      'predicates': fromList(this.predicates),
      'required_auths': fromList(this.requiredAuths),
      'fee': this.fee.toJson(),
      'extensions' : [],
    };

    return val;
  }
}