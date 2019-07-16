import 'optype.dart';
import '../operations.dart';
import '../encoder.dart';
import '../../models/models.dart';

class AssetPublishFeedOperation extends Operation {
  AssetAmount fee;
  GrapheneId publisher;
  GrapheneId assetID;
  PriceFeed feed;
  List<dynamic> extensions;

  AssetPublishFeedOperation(this.publisher, this.assetID, this.feed,
      this.fee);

  @override
  OpType opType() {
    return OpType.AssetPublishFeedOpType;
  }

  @override
  bool serialize(Encoder encoder) {
    encoder.encodeVarint(opType().index);
    this.fee.serialize(encoder);
    this.publisher.serialize(encoder);
    this.assetID.serialize(encoder);
    this.feed.serialize(encoder);

    //Extensions
    encoder.encodeVarint(0);

    return true;
  }

  @override
  dynamic toJson() {
    final val = <String, dynamic>{
      'publisher': this.publisher.toJson(),
      'asset_id': this.assetID.toJson(),
      'feed': this.feed.toJson(),
      'fee': this.fee.toJson(),
      'extensions' : [],
    };

    return val;
  }
}