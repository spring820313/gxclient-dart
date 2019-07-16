import 'optype.dart';
import '../operations.dart';
import '../encoder.dart';
import '../../models/models.dart';

class AssetIssueOperation extends Operation {
  AssetAmount fee;
  GrapheneId issuer;
  AssetAmount assetToIssue;
  GrapheneId issueToAccount;
  Memo memo;
  List<dynamic> extensions;

  AssetIssueOperation(this.issuer, this.assetToIssue, this.issueToAccount,
      this.fee, [this.memo]);

  @override
  OpType opType() {
    return OpType.AssetIssueOpType;
  }

  @override
  bool serialize(Encoder encoder) {
    encoder.encodeVarint(opType().index);
    this.fee.serialize(encoder);
    this.issuer.serialize(encoder);
    this.assetToIssue.serialize(encoder);
    this.issueToAccount.serialize(encoder);
    encoder.encodeBool(this.memo != null);
    if(this.memo != null) {
      this.memo.serialize(encoder);
    }

    //Extensions
    encoder.encodeVarint(0);

    return true;
  }

  @override
  dynamic toJson() {
    final val = <String, dynamic>{
      'issuer': this.issuer.toJson(),
      'asset_to_issue': this.assetToIssue.toJson(),
      'issue_to_account': this.issueToAccount.toJson(),
      'fee': this.fee.toJson(),
      'extensions' : [],
    };

    if(this.memo != null) {
      val['memo'] = this.memo.toJson();
    }

    return val;
  }
}