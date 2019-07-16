import '../core/serialization.dart';
import '../core/encoder.dart';
import 'types.dart';
import 'graphene_id.dart';
import 'authority.dart';

class NullExtension extends Serializable{
  NullExtension();

  factory NullExtension.fromJson(dynamic json) {
    return NullExtension();
  }

  @override
  bool serialize(Encoder encoder)  {
    encoder.encodeUint8(AccountCreateExtensionsType.AccountCreateExtensionsNullExt.index);
    return true;
  }

  @override
  dynamic toJson() {
    final dummy = Map();
    return dummy;
  }
}

class BuybackOptions extends Serializable{
  GrapheneId assetToBuy;
  GrapheneId assetToBuyIssuer;
  GrapheneIds markets;

  BuybackOptions(this.assetToBuy, this.assetToBuyIssuer, this.markets);

  factory BuybackOptions.fromJson(dynamic json) {
    if(!(json is Map)) {
      return null;
    }
    final assetToBuy = GrapheneId.fromJson(json['asset_to_buy']);
    final assetToBuyIssuer = GrapheneId.fromJson(json['asset_to_buy_issuer']);
    final markets = GrapheneIds.fromJson(json['markets']);
    return BuybackOptions(assetToBuy, assetToBuyIssuer, markets);
  }

  @override
  bool serialize(Encoder encoder)  {
    encoder.encodeUint8(AccountCreateExtensionsType.AccountCreateExtensionsBuyback.index);
    this.assetToBuy.serialize(encoder);
    this.assetToBuyIssuer.serialize(encoder);
    this.markets.serialize(encoder);
    return true;
  }

  @override
  dynamic toJson() {
    final val = <String, dynamic>{
      'asset_to_buy': this.assetToBuy.toJson(),
      'asset_to_buy_issuer': this.assetToBuyIssuer.toJson(),
      'markets': this.markets.toJson(),
    };

    return val;
  }
}

class AccountCreateExtensions extends Serializable{
  NullExtension nullExt;
  OwnerSpecialAuthority ownerSpecialAuthority;
  ActiveSpecialAuthority activeSpecialAuthority;
  BuybackOptions buybackOptions;

  AccountCreateExtensions(this.nullExt, this.ownerSpecialAuthority,
      this.activeSpecialAuthority, this.buybackOptions);

  factory AccountCreateExtensions.fromJson(dynamic json) {
    if(!(json is Map)) {
      return null;
    }
    final nullExt = json['null_ext'] == null ? null : NullExtension.fromJson(json['null_ext']);
    final ownerSpecialAuthority = json['owner_special_authority'] == null ? null : OwnerSpecialAuthority.fromJson(json['owner_special_authority']);
    final activeSpecialAuthority = json['active_special_authority'] == null ? null : ActiveSpecialAuthority.fromJson(json['active_special_authority']);
    final buybackOptions = json['buyback_options'] == null ? null : BuybackOptions.fromJson(json['buyback_options']);
    return AccountCreateExtensions(nullExt, ownerSpecialAuthority, activeSpecialAuthority, buybackOptions);
  }

  int length() {
    var fields = 0;
    if(this.nullExt != null) fields++;
    if(this.ownerSpecialAuthority != null) fields++;
    if(this.activeSpecialAuthority != null) fields++;
    if(this.buybackOptions != null) fields++;
    return fields;
  }

  @override
  bool serialize(Encoder encoder)  {
    encoder.encodeVarint(this.length());
    if(this.nullExt != null)
      this.nullExt.serialize(encoder);
    if(this.ownerSpecialAuthority != null)
      this.ownerSpecialAuthority.serialize(encoder);
    if(this.activeSpecialAuthority != null)
      this.activeSpecialAuthority.serialize(encoder);
    if(this.buybackOptions != null)
      this.buybackOptions.serialize(encoder);
    return true;
  }

  @override
  dynamic toJson() {
    final val = <String, dynamic>{
    };
    if(this.nullExt != null)
      val['null_ext'] = this.nullExt.toJson();
    if(this.ownerSpecialAuthority != null)
      val['owner_special_authority'] = this.ownerSpecialAuthority.toJson();
    if(this.activeSpecialAuthority != null)
      val['active_special_authority'] = this.activeSpecialAuthority.toJson();
    if(this.buybackOptions != null)
      val['buyback_options'] = this.buybackOptions.toJson();
    return val;
  }
}

class AccountUpdateExtensions extends Serializable{
  NullExtension nullExt;
  OwnerSpecialAuthority ownerSpecialAuthority;
  ActiveSpecialAuthority activeSpecialAuthority;

  AccountUpdateExtensions(this.nullExt, this.ownerSpecialAuthority,
      this.activeSpecialAuthority);

  factory AccountUpdateExtensions.fromJson(dynamic json) {
    if(!(json is Map)) {
      return null;
    }
    final nullExt = json['null_ext'] == null ? null : NullExtension.fromJson(json['null_ext']);
    final ownerSpecialAuthority = json['owner_special_authority'] == null ? null : OwnerSpecialAuthority.fromJson(json['owner_special_authority']);
    final activeSpecialAuthority = json['active_special_authority'] == null ? null : ActiveSpecialAuthority.fromJson(json['active_special_authority']);
    return AccountUpdateExtensions(nullExt, ownerSpecialAuthority, activeSpecialAuthority);
  }

  int length() {
    var fields = 0;
    if(this.nullExt != null) fields++;
    if(this.ownerSpecialAuthority != null) fields++;
    if(this.activeSpecialAuthority != null) fields++;
    return fields;
  }

  @override
  bool serialize(Encoder encoder)  {
    encoder.encodeVarint(this.length());
    if(this.nullExt != null)
      this.nullExt.serialize(encoder);
    if(this.ownerSpecialAuthority != null)
      this.ownerSpecialAuthority.serialize(encoder);
    if(this.activeSpecialAuthority != null)
      this.activeSpecialAuthority.serialize(encoder);
    return true;
  }

  @override
  dynamic toJson() {
    final val = <String, dynamic>{
    };
    if(this.nullExt != null)
      val['null_ext'] = this.nullExt.toJson();
    if(this.ownerSpecialAuthority != null)
      val['owner_special_authority'] = this.ownerSpecialAuthority.toJson();
    if(this.activeSpecialAuthority != null)
      val['active_special_authority'] = this.activeSpecialAuthority.toJson();
    return val;
  }
}