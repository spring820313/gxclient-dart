import '../core/serialization.dart';
import '../core/encoder.dart';
import 'graphene_id.dart';

class BitassetOptions extends Serializable{
  int feedLifetimeSec;
  int minimumFeeds;
  int forceSettlementDelaySec;
  int forceSettlementOffsetPercent;
  int maximumForceSettlementVolume;
  GrapheneId shortBackingAsset;
  List<dynamic> extensions = [];

  BitassetOptions(this.feedLifetimeSec, this.minimumFeeds, this.forceSettlementDelaySec,
      this.forceSettlementOffsetPercent, this.maximumForceSettlementVolume,
      this.shortBackingAsset);


  factory BitassetOptions.fromJson(dynamic json) {
    if (!(json is Map)) {
      return null;
    }

    int feedLifetimeSec = json['feed_lifetime_sec'];
    int minimumFeeds = json['minimum_feeds'];
    int forceSettlementDelaySec = json['force_settlement_delay_sec'];
    int forceSettlementOffsetPercent = json['force_settlement_offset_percent'];
    int maximumForceSettlementVolume = json['maximum_force_settlement_volume'];
    final shortBackingAsset = GrapheneId.fromJson(json['short_backing_asset']);
    return BitassetOptions(feedLifetimeSec, minimumFeeds, forceSettlementDelaySec,
        forceSettlementOffsetPercent, maximumForceSettlementVolume,
        shortBackingAsset);
  }

  @override
  bool serialize(Encoder encoder)  {
    encoder.encodeUint32(this.feedLifetimeSec);
    encoder.encodeUint8(this.minimumFeeds);
    encoder.encodeUint32(this.forceSettlementDelaySec);
    encoder.encodeUint16(this.forceSettlementOffsetPercent);
    encoder.encodeUint16(this.maximumForceSettlementVolume);
    this.shortBackingAsset.serialize(encoder);
    encoder.encodeVarint(0);
    return true;
  }

  @override
  dynamic toJson() {
    final val = <String, dynamic>{
      'feed_lifetime_sec': this.feedLifetimeSec,
      'minimum_feeds' : this.minimumFeeds,
      'force_settlement_delay_sec': this.forceSettlementDelaySec,
      'force_settlement_offset_percent' : this.forceSettlementOffsetPercent,
      'maximum_force_settlement_volume': this.maximumForceSettlementVolume,
      'short_backing_asset' : this.shortBackingAsset.toJson(),
      'extensions' : [],
    };

    return val;
  }
}