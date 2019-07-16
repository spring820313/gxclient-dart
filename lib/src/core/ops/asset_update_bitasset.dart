import '../operations.dart';
import '../encoder.dart';
import 'optype.dart';
import '../../models/models.dart';

class AssetUpdateBitassetOperation extends Operation {
  AssetAmount fee;
  GrapheneId issuer;
  GrapheneId assetToUpdate;
  BitassetOptions newOptions;
  List<dynamic> extensions;

  AssetUpdateBitassetOperation(this.issuer, this.assetToUpdate, this.newOptions, this.fee);

  @override
  OpType opType() {
    return OpType.AssetUpdateBitassetOpType;
  }

  @override
  bool serialize(Encoder encoder) {
    encoder.encodeVarint(opType().index);
    this.fee.serialize(encoder);
    this.issuer.serialize(encoder);
    this.assetToUpdate.serialize(encoder);
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

    return val;
  }
}