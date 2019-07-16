import 'optype.dart';
import '../operations.dart';
import '../encoder.dart';
import '../../models/models.dart';

class CommitteeMemberCreateOperation extends Operation {
  AssetAmount fee;
  GrapheneId committeeMemberAccount;
  String url;

  CommitteeMemberCreateOperation(this.committeeMemberAccount, this.url, this.fee);

  @override
  OpType opType() {
    return OpType.CommitteeMemberCreateOpType;
  }

  @override
  bool serialize(Encoder encoder) {
    encoder.encodeVarint(opType().index);
    this.fee.serialize(encoder);
    this.committeeMemberAccount.serialize(encoder);
    encoder.encodeString(this.url);

    return true;
  }

  @override
  dynamic toJson() {
    final val = <String, dynamic>{
      'committee_member_account': this.committeeMemberAccount.toJson(),
      'url': this.url,
      'fee': this.fee.toJson(),
    };

    return val;
  }
}