import 'price_feed.dart';
import 'graphene_id.dart';
import 'time.dart';
import '../core/serialization.dart';
import '../core/encoder.dart';

class AssetFeed extends Serializable{
  GrapheneId providerID;
  Time dateTime;
  PriceFeed feedInfo;

  AssetFeed(this.providerID, this.dateTime,
      this.feedInfo);

  static List<AssetFeed> toList(dynamic json) {
    List<AssetFeed> fields = List();
    if(json != null) {
      final ts = json as List<dynamic>;
      for(final d in ts) {
        final f = AssetFeed.fromJson(d);
        fields.add(f);
      }
    }
    return fields;
  }

  factory AssetFeed.fromJson(dynamic json) {
    if(!(json is List)) {
      return null;
    }

    List<dynamic> raw = List();
    final ts = json as List<dynamic>;
    for(final d in ts) {
      raw.add(d);
    }

    if(raw.length != 2) {
      return null;
    }

    final providerID = GrapheneId.fromJson(raw[0]);

    List<dynamic> feedData = List();
    final ts2 = raw[1] as List<dynamic>;
    for(final d in ts2) {
      feedData.add(d);
    }

    if(feedData.length != 2) {
      return null;
    }

    final dateTime = Time.fromJson(feedData[0]);
    final feedInfo = PriceFeed.fromJson(feedData[1]);

    return AssetFeed(providerID, dateTime, feedInfo);
  }

  @override
  bool serialize(Encoder encoder)  {
    return true;
  }

  @override
  dynamic toJson() {
  List<dynamic> data = List();
  data.add(this.dateTime.toJson());
  data.add(this.feedInfo.toJson());

  List<dynamic> ret = List();
  ret.add(this.providerID.toJson());
  ret.add(data);
  return ret;
  }
}