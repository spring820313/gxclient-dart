import 'optype.dart';
import '../operations.dart';
import '../encoder.dart';
import '../../models/models.dart';

class AssetGlobalSettleOperation extends Operation {
  AssetAmount fee;
  GrapheneId issuer;
  GrapheneId assetToSettle;
  Price settlePrice;
  List<dynamic> extensions;

  AssetGlobalSettleOperation(this.issuer, this.assetToSettle, this.settlePrice,
      this.fee);

  @override
  OpType opType() {
    return OpType.AssetGlobalSettleOpType;
  }

  @override
  bool serialize(Encoder encoder) {
    encoder.encodeVarint(opType().index);
    this.fee.serialize(encoder);
    this.issuer.serialize(encoder);
    this.assetToSettle.serialize(encoder);
    this.settlePrice.serialize(encoder);

    //Extensions
    encoder.encodeVarint(0);

    return true;
  }

  @override
  dynamic toJson() {
    final val = <String, dynamic>{
      'issuer': this.issuer.toJson(),
      'asset_to_settle': this.assetToSettle.toJson(),
      'settle_price': this.settlePrice.toJson(),
      'fee': this.fee.toJson(),
      'extensions' : [],
    };

    return val;
  }
}