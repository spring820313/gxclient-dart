import '../core/serialization.dart';
import '../core/encoder.dart';
import '../ecc/ecc.dart';
import 'address.dart';
import 'graphene_id.dart';
import 'types.dart';

class Authority extends Serializable{
  int weightThreshold;
  AccountAuthsMap accountAuths;
  KeyAuthsMap keyAuths;
  AddressAuthsMap addressAuths;
  List<dynamic> extensions;
  Authority(this.weightThreshold, this.accountAuths, this.keyAuths,
      this.addressAuths);

  factory Authority.fromJson(dynamic json) {
    if(!(json is Map)) {
      return null;
    }
    final weightThreshold = json['weight_threshold'] as int;
    final accountAuths = AccountAuthsMap.fromJson(json['account_auths']);
    final keyAuths = KeyAuthsMap.fromJson(json['key_auths']);
    final addressAuths = AddressAuthsMap.fromJson(json['address_auths']);
    final a =   Authority(weightThreshold, accountAuths, keyAuths,
        addressAuths);
    a.extensions = List();
    return a;
  }

  @override
  bool serialize(Encoder encoder)  {
    encoder.encodeUint32(this.weightThreshold);
    this.accountAuths.serialize(encoder);
    this.keyAuths.serialize(encoder);
    this.addressAuths.serialize(encoder);
    encoder.encodeVarint(0);
    return true;
  }

  @override
  dynamic toJson() {
    final val = <String, dynamic>{
      'weight_threshold': this.weightThreshold,
      'account_auths': this.addressAuths.toJson(),
      'key_auths': this.keyAuths.toJson(),
      'address_auths': this.addressAuths.toJson(),
      'extensions' : [],
    };

    return val;
  }
}

class KeyAuthsMap extends Serializable{
  Map<GXCPublicKey, int> auth;

  KeyAuthsMap(this.auth);

  factory KeyAuthsMap.fromJson(dynamic json) {
    if(!(json is List)) {
      return null;
    }
    Map<GXCPublicKey, int> auths = Map();
    for(var a in json) {
      if(!(a is List)) {
        continue;
      }
      final item = a as List;
      if(item.length != 2) {
        continue;
      }
      if(!(item[0] is String)) {
        continue;
      }

      if(!(item[1] is int)) {
        continue;
      }

      final key = GXCPublicKey.fromString(item[0] as String);
      final value = item[1] as int;
      auths[key] = value;
    }

    final keyAuthsMap = KeyAuthsMap(auths);
    return keyAuthsMap;
  }

  @override
  bool serialize(Encoder encoder)  {
    encoder.encodeVarint(auth.length);
    var keys = auth.keys.toList();
    keys.sort((a, b) {
      final addr1 = Address.fromPublicKey("GXC", a).toString();
      final addr2 = Address.fromPublicKey("GXC", b).toString();
      return addr1.compareTo(addr2);
    });

    for(var k in keys) {
      final s = k.toString();
      encoder.encodePubKey(s);
      encoder.encodeUint16(auth[k]);
    }
    return true;
  }

  @override
  dynamic toJson() {
    List<dynamic> val = List();
    auth.forEach((k, v) {
      final a = List<dynamic>.from([k.toString(), v]);
      val.add(a);
    });
    return val;
  }
}

class AddressAuthsMap extends Serializable{
  Map<Address, int> addrAuth;

  AddressAuthsMap(this.addrAuth);

  factory AddressAuthsMap.fromJson(dynamic json) {
    if(!(json is List)) {
      return null;
    }
    Map<Address, int> auths = Map();
    for(var a in json) {
      if(!(a is List)) {
        continue;
      }
      final item = a as List;
      if(item.length != 2) {
        continue;
      }
      if(!(item[0] is String)) {
        continue;
      }

      if(!(item[1] is int)) {
        continue;
      }

      final key = Address.fromString("GXC", item[0] as String);
      final value = item[1] as int;
      auths[key] = value;
    }

    final addressAuthsMap = AddressAuthsMap(auths);
    return addressAuthsMap;
  }

  @override
  bool serialize(Encoder encoder)  {
    encoder.encodeVarint(addrAuth.length);
    addrAuth.forEach((k, v) {
      k.serialize(encoder);
      encoder.encodeUint16(v);
    });
    return true;
  }

  @override
  dynamic toJson() {
    List<dynamic> val = List();
    addrAuth.forEach((k, v) {
      final a = List<dynamic>.from([k.toString(), v]);
      val.add(a);
    });
    return val;
  }
}

class AccountAuthsMap extends Serializable{
  Map<GrapheneId, int> AccountAuth;

  AccountAuthsMap(this.AccountAuth);

  factory AccountAuthsMap.fromJson(dynamic json) {
    if(!(json is List)) {
      return null;
    }
    Map<GrapheneId, int> auths = Map();
    for(var a in json) {
      if(!(a is List)) {
        continue;
      }
      final item = a as List;
      if(item.length != 2) {
        continue;
      }
      if(!(item[0] is String)) {
        continue;
      }

      if(!(item[1] is int)) {
        continue;
      }

      final key = GrapheneId.fromJson(item[0] as String);
      final value = item[1] as int;
      auths[key] = value;
    }

    final accountAuthsMap = AccountAuthsMap(auths);
    return accountAuthsMap;
  }

  @override
  bool serialize(Encoder encoder)  {
    encoder.encodeVarint(AccountAuth.length);
    AccountAuth.forEach((k, v) {
      k.serialize(encoder);
      encoder.encodeUint16(v);
    });
    return true;
  }

  @override
  dynamic toJson() {
    List<dynamic> val = List();
    AccountAuth.forEach((k, v) {
      final a = List<dynamic>.from([k.toString(), v]);
      val.add(a);
    });
    return val;
  }
}

class NoSpecialAuthority extends Serializable{
  NoSpecialAuthority();

  factory NoSpecialAuthority.fromJson(dynamic json) {
    return NoSpecialAuthority();
  }

  @override
  bool serialize(Encoder encoder)  {

  }

  @override
  dynamic toJson() {
    final dummy = Map();
    return dummy;
  }
}

class TopHoldersSpecialAuthority {
  GrapheneId asset;
  int numTopHolders;

  TopHoldersSpecialAuthority(this.asset, this.numTopHolders);

  factory TopHoldersSpecialAuthority.fromJson(dynamic json) {
    if(!(json is Map)) {
      return null;
    }
    GrapheneId asset = GrapheneId(json['asset']);
    final numTopHolders = json['num_top_holders'] as int;
    return TopHoldersSpecialAuthority(asset, numTopHolders);
  }

  @override
  bool serialize(Encoder encoder)  {
    this.asset.serialize(encoder);
    encoder.encodeUint8(numTopHolders);
  }

  @override
  dynamic toJson() {
    final val = <String, dynamic>{
      'asset': this.asset.toJson(),
      'num_top_holders' : this.numTopHolders,
    };
    return val;
  }
}

class SpecialAuth extends Serializable{
  SpecialAuthorityType type;
  dynamic auth;

  SpecialAuth(this.type, this.auth);

  factory SpecialAuth.fromJson(dynamic json) {
    if(!(json is List)) {
      return null;
    }

    final lst = json as List;
    if(lst.length != 2) {
      return null;
    }

    return SpecialAuth(SpecialAuthorityType.values[lst[0] as int], lst[1]);
  }

  @override
  bool serialize(Encoder encoder)  {
    //encoder.encodeUint8(this.type.index);
    switch(this.type) {
      case SpecialAuthorityType.SpecialAuthorityTypeNoSpecial:
        final noSpecialAuthority = this.auth as NoSpecialAuthority;
        noSpecialAuthority.serialize(encoder);
        break;
      case SpecialAuthorityType.SpecialAuthorityTypeTopHolders:
        final topHoldersSpecialAuthority = this.auth as TopHoldersSpecialAuthority;
        topHoldersSpecialAuthority.serialize(encoder);
        break;
    }
  }

  @override
  dynamic toJson() {
    return List<dynamic>.from([type.index, auth]);
  }
}

class OwnerSpecialAuthority extends Serializable {
  SpecialAuth specialAuth;

  OwnerSpecialAuthority(this.specialAuth);

  factory OwnerSpecialAuthority.fromJson(dynamic json) {
    final specialAuth = SpecialAuth.fromJson(json);
    return OwnerSpecialAuthority(specialAuth);
  }

  @override
  bool serialize(Encoder encoder)  {
    encoder.encodeUint8(AccountCreateExtensionsType.AccountCreateExtensionsOwnerSpecial.index);
    this.specialAuth.serialize(encoder);
    return true;
  }

  @override
  dynamic toJson() {
    return this.specialAuth.toJson();
  }
}

class ActiveSpecialAuthority extends Serializable{
  SpecialAuth specialAuth;

  ActiveSpecialAuthority(this.specialAuth);

  factory ActiveSpecialAuthority.fromJson(dynamic json) {
    final specialAuth = SpecialAuth.fromJson(json);
    return ActiveSpecialAuthority(specialAuth);
  }

  @override
  bool serialize(Encoder encoder)  {
    encoder.encodeUint8(AccountCreateExtensionsType.AccountCreateExtensionsActiveSpecial.index);
    this.specialAuth.serialize(encoder);
    return true;
  }

  @override
  dynamic toJson() {
    return this.specialAuth.toJson();
  }
}