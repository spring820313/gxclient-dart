import 'graphene_id.dart';
import 'price.dart';
import '../core/core.dart';

class AssetOptions extends Serializable{
  int maxSupply;
  int maxMarketFee;
  int marketFeePercent;
  int flags;
  String description;
  Price coreExchangeRate;
  int issuerPermissions;
  GrapheneIds blacklistAuthorities;
  GrapheneIds whitelistAuthorities;
  GrapheneIds blacklistMarkets;
  GrapheneIds whitelistMarkets;
  List<dynamic> extensions = [];

  AssetOptions(this.maxSupply, this.maxMarketFee, this.marketFeePercent,
      this.flags, this.description, this.coreExchangeRate, this.issuerPermissions,
      this.blacklistAuthorities, this.whitelistAuthorities, this.blacklistMarkets,
      this.whitelistMarkets);

  factory AssetOptions.fromJson(Map<String, dynamic> json) {
    int maxSupply = json['max_supply'];
    int maxMarketFee = json['max_market_fee'];
    int marketFeePercent = json['market_fee_percent'];
    int flags = json['flags'];
    String description = json['description'];

    final coreExchangeRate = Price.fromJson(json['core_exchange_rate']);
    int issuerPermissions = json['issuer_permissions'];
    final blacklistAuthorities = GrapheneIds.fromJson(json['blacklist_authorities']);
    final whitelistAuthorities = GrapheneIds.fromJson(json['whitelist_authorities']);
    final blacklistMarkets = GrapheneIds.fromJson(json['blacklist_markets']);
    final whitelistMarkets = GrapheneIds.fromJson(json['whitelist_markets']);

    return AssetOptions(maxSupply, maxMarketFee, marketFeePercent,
        flags, description, coreExchangeRate, issuerPermissions,
        blacklistAuthorities, whitelistAuthorities, blacklistMarkets,
        whitelistMarkets);
  }

  @override
  bool serialize(Encoder encoder)  {
    encoder.encodeUint64(this.maxSupply);
    encoder.encodeUint64(this.maxMarketFee);
    encoder.encodeUint16(this.marketFeePercent);
    encoder.encodeUint16(this.flags);
    encoder.encodeString(this.description);
    this.coreExchangeRate.serialize(encoder);
    encoder.encodeUint16(this.issuerPermissions);
    this.blacklistAuthorities.serialize(encoder);
    this.whitelistAuthorities.serialize(encoder);
    this.blacklistMarkets.serialize(encoder);
    this.whitelistMarkets.serialize(encoder);

    encoder.encodeVarint(0);
    return true;
  }

  @override
  dynamic toJson() {
    final val = <String, dynamic>{
      'max_supply': this.maxSupply,
      'max_market_fee' : this.maxMarketFee,
      'market_fee_percent': this.marketFeePercent,
      'flags' : this.flags,
      'description': this.description,
      'core_exchange_rate' : this.coreExchangeRate.toJson(),
      'issuer_permissions': this.issuerPermissions,
      'blacklist_authorities' : this.blacklistAuthorities.toJson(),
      'whitelist_authorities': this.whitelistAuthorities.toJson(),
      'blacklist_markets' : this.blacklistMarkets.toJson(),
      'whitelist_markets': this.whitelistMarkets.toJson(),
      'extensions' : [],
    };

    return val;
  }

}