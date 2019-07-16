import 'asset_amount.dart';
import '../core/serialization.dart';
import '../core/encoder.dart';

class Price extends Serializable{
  AssetAmount base;
  AssetAmount quote;

  Price(this.base, this.quote);

  factory Price.fromJson(dynamic json) {
    if(!(json is Map)) {
      return null;
    }
    final base = AssetAmount.fromJson(json['base']);
    final quote = AssetAmount.fromJson(json['quote']);
    return Price(base, quote);
  }

  @override
  bool serialize(Encoder encoder)  {
    this.base.serialize(encoder);
    this.quote.serialize(encoder);
    return true;
  }

  @override
  dynamic toJson() {
    final val = <String, dynamic>{
      'base': this.base.toJson(),
      'quote' : this.quote.toJson(),
    };

    return val;
  }
}