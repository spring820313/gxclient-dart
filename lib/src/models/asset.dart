import 'graphene_id.dart';
import '../core/serialization.dart';
import '../core/encoder.dart';

class Asset extends Serializable{
  GrapheneId id;
  String symbol;
  int precision;
  String issuer;
  String dynamicAssetDataID;

  Asset(this.id, this.symbol, this.precision, this.issuer, this.dynamicAssetDataID);

  factory Asset.fromJson(dynamic json) {
    if(!(json is Map)) {
      return null;
    }
    GrapheneId id = GrapheneId.fromJson(json['id']);
    String symbol = json['symbol'];
    int precision = json['precision'] as int;
    String issuer = json['issuer'];
    String dynamicAssetDataID = json['dynamic_asset_data_id'];
    return Asset(id, symbol, precision, issuer, dynamicAssetDataID);
  }

  @override
  bool serialize(Encoder encoder)  {
    return true;
  }

  @override
  dynamic toJson() {
    final val = <String, dynamic>{
      'id': this.id.toJson(),
      'symbol' : this.symbol,
      'precision' : this.precision,
      'issuer' : this.issuer,
      'dynamic_asset_data_id' : this.dynamicAssetDataID,
    };

    return val;
  }
}