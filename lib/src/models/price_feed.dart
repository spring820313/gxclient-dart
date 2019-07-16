import 'price.dart';
import '../core/serialization.dart';
import '../core/encoder.dart';

class PriceFeed extends Serializable{
  int maintenanceCollateralRatio;
  int maximumShortSqueezeRatio;
  Price settlementPrice;
  Price coreExchangeRate;

  PriceFeed(this.maintenanceCollateralRatio, this.maximumShortSqueezeRatio,
      this.settlementPrice, this.coreExchangeRate);

  factory PriceFeed.fromJson(dynamic json) {
    if(!(json is Map)) {
      return null;
    }
    final maintenanceCollateralRatio = json['maintenance_collateral_ratio'];
    final maximumShortSqueezeRatio = json['maximum_short_squeeze_ratio'];
    final settlementPrice = Price.fromJson(json['settlement_price']);
    final coreExchangeRate = Price.fromJson(json['core_exchange_rate']);
    return PriceFeed(maintenanceCollateralRatio, maximumShortSqueezeRatio, settlementPrice, coreExchangeRate);
  }

  @override
  bool serialize(Encoder encoder)  {
    encoder.encodeUint16(this.maintenanceCollateralRatio);
    encoder.encodeUint16(this.maximumShortSqueezeRatio);
    this.settlementPrice.serialize(encoder);
    this.coreExchangeRate.serialize(encoder);
    return true;
  }

  @override
  dynamic toJson() {
    final val = <String, dynamic>{
      'maintenance_collateral_ratio': this.maintenanceCollateralRatio,
      'maximum_short_squeeze_ratio' : this.maximumShortSqueezeRatio,
      'settlement_price': this.settlementPrice.toJson(),
      'core_exchange_rate' : this.coreExchangeRate.toJson(),
    };

    return val;
  }
}