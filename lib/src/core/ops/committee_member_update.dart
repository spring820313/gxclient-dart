import 'optype.dart';
import '../operations.dart';
import '../encoder.dart';
import '../../models/models.dart';

class CommitteeMemberUpdateOperation extends Operation {
  AssetAmount fee;
  GrapheneId committeeMember;
  GrapheneId committeeMemberAccount;
  String newURL;

  CommitteeMemberUpdateOperation(this.committeeMember, this.committeeMemberAccount, this.fee, [this.newURL]);

  @override
  OpType opType() {
    return OpType.CommitteeMemberUpdateOpType;
  }

  @override
  bool serialize(Encoder encoder) {
    encoder.encodeVarint(opType().index);
    this.fee.serialize(encoder);
    this.committeeMember.serialize(encoder);
    this.committeeMemberAccount.serialize(encoder);
    encoder.encodeBool(this.newURL != null);
    if(this.newURL != null)
      encoder.encodeString(this.newURL);

    return true;
  }

  @override
  dynamic toJson() {
    final val = <String, dynamic>{
      'committee_member': this.committeeMember.toJson(),
      'committee_member_account': this.committeeMemberAccount.toJson(),
      'fee': this.fee.toJson(),
    };

    if(this.newURL != null) {
      val['new_url'] = this.newURL;
    }

    return val;
  }
}