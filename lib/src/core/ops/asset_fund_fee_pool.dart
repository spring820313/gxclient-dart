import 'optype.dart';
import '../operations.dart';
import '../encoder.dart';
import '../../models/models.dart';

class AssetFundFeePoolOperation extends Operation {
  AssetAmount fee;
  GrapheneId fromAccount;
  GrapheneId assetID;
  int amount;
  List<dynamic> extensions;

  AssetFundFeePoolOperation(this.fromAccount, this.assetID, this.amount,
      this.fee);

  @override
  OpType opType() {
    return OpType.AssetFundFeePoolOpType;
  }

  @override
  bool serialize(Encoder encoder) {
    encoder.encodeVarint(opType().index);
    this.fee.serialize(encoder);
    this.fromAccount.serialize(encoder);
    this.assetID.serialize(encoder);
    encoder.encodeUint64(this.amount);

    //Extensions
    encoder.encodeVarint(0);

    return true;
  }

  @override
  dynamic toJson() {
    final val = <String, dynamic>{
      'from_account': this.fromAccount.toJson(),
      'asset_id': this.assetID.toJson(),
      'amount': this.amount,
      'fee': this.fee.toJson(),
      'extensions' : [],
    };

    return val;
  }
}