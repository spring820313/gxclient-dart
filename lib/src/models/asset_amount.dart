import 'graphene_id.dart';
import '../core/serialization.dart';
import '../core/encoder.dart';

class AssetAmount extends Serializable{
  int amount;
  GrapheneId assetID;

  AssetAmount(this.amount, this.assetID);

  static List<AssetAmount> toList(dynamic json) {
    List<AssetAmount> fields = List();
    if(json != null) {
      final ts = json as List<dynamic>;
      for(final d in ts) {
        final f = AssetAmount.fromJson(d);
        fields.add(f);
      }
    }
    return fields;
  }

  factory AssetAmount.fromJson(Map<String, dynamic> json) {
    String assetId = json['asset_id'] as String;
    GrapheneId id = GrapheneId(assetId);
    return AssetAmount(json['amount'] as int, id);
  }

  @override
  bool serialize(Encoder encoder)  {
    encoder.encodeUint64(amount);
    this.assetID.serialize(encoder);
    return true;
  }

  @override
  dynamic toJson() {
    final val = <String, dynamic>{
      'amount': this.amount,
      'asset_id' : this.assetID.toJson(),
    };

    return val;
  }

  @override
  String toString() => this.toJson().toString();
}