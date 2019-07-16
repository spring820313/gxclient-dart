import 'optype.dart';
import '../operations.dart';
import '../encoder.dart';
import '../../models/models.dart';
import '../../core/core.dart';

class ProposalDeleteOperation extends Operation {
  AssetAmount fee;
  GrapheneId feePayingAccount;
  bool usingOwnerAuthority;
  GrapheneId proposal;
  List<dynamic> extensions;

  ProposalDeleteOperation(this.feePayingAccount, this.usingOwnerAuthority,
      this.proposal, this.fee);

  @override
  OpType opType() {
    return OpType.ProposalDeleteOpType;
  }

  @override
  bool serialize(Encoder encoder) {
    encoder.encodeVarint(opType().index);
    this.fee.serialize(encoder);
    this.feePayingAccount.serialize(encoder);
    encoder.encodeBool(this.usingOwnerAuthority);
    this.proposal.serialize(encoder);
    encoder.encodeVarint(0);

    return true;
  }

  @override
  dynamic toJson() {
    final val = <String, dynamic>{
      'fee_paying_account': this.feePayingAccount.toJson(),
      'using_owner_authority': this.usingOwnerAuthority,
      'proposal': this.proposal.toJson(),
      'fee': this.fee.toJson(),
      'extensions' : [],
    };

    return val;
  }
}