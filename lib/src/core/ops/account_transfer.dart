import '../operations.dart';
import '../encoder.dart';
import 'optype.dart';
import '../../models/models.dart';

class AccountTransferOperation extends Operation {
  AssetAmount fee;
  GrapheneId accountId;
  GrapheneId newOwner;
  List<dynamic> extensions;

  AccountTransferOperation(this.accountId, this.newOwner, this.fee);

  @override
  OpType opType() {
    return OpType.AccountTransferOpType;
  }

  @override
  bool serialize(Encoder encoder) {
    encoder.encodeVarint(opType().index);
    this.fee.serialize(encoder);
    this.accountId.serialize(encoder);
    this.newOwner.serialize(encoder);

    //Extensions
    encoder.encodeVarint(0);

    return true;
  }

  @override
  dynamic toJson() {
    final val = <String, dynamic>{
      'account_id': this.accountId.toJson(),
      'new_owner': this.newOwner.toJson(),
      'fee': this.fee.toJson(),
      'extensions' : [],
    };

    return val;
  }
}