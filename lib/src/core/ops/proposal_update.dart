import 'optype.dart';
import '../operations.dart';
import '../encoder.dart';
import '../../models/models.dart';
import '../../core/core.dart';

class ProposalUpdateOperation extends Operation {
  AssetAmount fee;
  GrapheneId feePayingAccount;
  GrapheneId proposal;

  GrapheneIds activeApprovalsToAdd;
  GrapheneIds activeApprovalsToRemove;
  GrapheneIds ownerApprovalsToAdd;
  GrapheneIds ownerApprovalsToRemove;
  GrapheneIds keyApprovalsToAdd;
  GrapheneIds keyApprovalsToRemove;

  List<dynamic> extensions;

  ProposalUpdateOperation(this.feePayingAccount, this.proposal,
      this.activeApprovalsToAdd, this.activeApprovalsToRemove,
      this.ownerApprovalsToAdd, this.ownerApprovalsToRemove,
      this.keyApprovalsToAdd, this.keyApprovalsToRemove, this.fee);

  @override
  OpType opType() {
    return OpType.ProposalUpdateOpType;
  }

  @override
  bool serialize(Encoder encoder) {
    encoder.encodeVarint(opType().index);
    this.fee.serialize(encoder);
    this.feePayingAccount.serialize(encoder);
    this.proposal.serialize(encoder);

    this.activeApprovalsToAdd.serialize(encoder);
    this.activeApprovalsToRemove.serialize(encoder);
    this.ownerApprovalsToAdd.serialize(encoder);
    this.ownerApprovalsToRemove.serialize(encoder);
    this.keyApprovalsToAdd.serialize(encoder);
    this.keyApprovalsToRemove.serialize(encoder);

    encoder.encodeVarint(0);

    return true;
  }

  @override
  dynamic toJson() {
    final val = <String, dynamic>{
      'fee_paying_account': this.feePayingAccount.toJson(),
      'proposal': this.proposal.toJson(),
      'active_approvals_to_add': this.activeApprovalsToAdd.toJson(),
      'active_approvals_to_remove': this.activeApprovalsToRemove.toJson(),
      'owner_approvals_to_add': this.ownerApprovalsToAdd.toJson(),
      'owner_approvals_to_remove': this.ownerApprovalsToRemove.toJson(),
      'key_approvals_to_add': this.keyApprovalsToAdd.toJson(),
      'key_approvals_to_remove': this.keyApprovalsToRemove.toJson(),
      'fee': this.fee.toJson(),
      'extensions' : [],
    };

    return val;
  }
}