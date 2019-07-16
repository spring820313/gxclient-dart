import 'optype.dart';
import '../operations.dart';
import '../encoder.dart';
import '../../models/models.dart';

class AssetUpdateFeedProducersOperation extends Operation {
  AssetAmount fee;
  GrapheneId issuer;
  GrapheneId assetToUpdate;
  GrapheneIds newFeedProducers;
  List<dynamic> extensions;

  AssetUpdateFeedProducersOperation(this.issuer, this.assetToUpdate, this.newFeedProducers,
      this.fee);

  @override
  OpType opType() {
    return OpType.AssetUpdateFeedProducersOpType;
  }

  @override
  bool serialize(Encoder encoder) {
    encoder.encodeVarint(opType().index);
    this.fee.serialize(encoder);
    this.issuer.serialize(encoder);
    this.assetToUpdate.serialize(encoder);
    this.newFeedProducers.serialize(encoder);

    //Extensions
    encoder.encodeVarint(0);

    return true;
  }

  @override
  dynamic toJson() {
    final val = <String, dynamic>{
      'issuer': this.issuer.toJson(),
      'asset_to_update': this.assetToUpdate.toJson(),
      'new_feed_producers': this.newFeedProducers.toJson(),
      'fee': this.fee.toJson(),
      'extensions' : [],
    };

    return val;
  }
}