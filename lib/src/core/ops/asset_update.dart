import 'optype.dart';
import '../operations.dart';
import '../encoder.dart';
import '../../models/models.dart';

class AssetUpdateOperation extends Operation {
  AssetAmount fee;
  GrapheneId issuer;
  GrapheneId assetToUpdate;
  GrapheneId newIssuer;
  AssetOptions newOptions;
  List<dynamic> extensions;

  AssetUpdateOperation(this.issuer, this.assetToUpdate, this.newOptions,
      this.fee, [this.newIssuer]);

  @override
  OpType opType() {
    return OpType.AssetUpdateOpType;
  }

  @override
  bool serialize(Encoder encoder) {
    encoder.encodeVarint(opType().index);
    this.fee.serialize(encoder);
    this.issuer.serialize(encoder);
    this.assetToUpdate.serialize(encoder);
    encoder.encodeBool(this.newIssuer != null);
    if(this.newIssuer != null)
      this.newIssuer.serialize(encoder);
    this.newOptions.serialize(encoder);

    //Extensions
    encoder.encodeVarint(0);

    return true;
  }

  @override
  dynamic toJson() {
    final val = <String, dynamic>{
      'issuer': this.issuer.toJson(),
      'asset_to_update': this.assetToUpdate.toJson(),
      'new_options': this.newOptions.toJson(),
      'fee': this.fee.toJson(),
      'extensions' : [],
    };

    if(this.newIssuer != null) {
      val['new_issuer'] = this.newIssuer.toJson();
    }

    return val;
  }
}