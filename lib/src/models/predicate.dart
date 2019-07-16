import 'dart:typed_data';

import '../core/core.dart';
import 'graphene_id.dart';
import 'types.dart';

class AccountNameEqLitPredicate extends Serializable{
  GrapheneId accountId;
  String name;

  AccountNameEqLitPredicate(this.accountId, this.name);

  factory AccountNameEqLitPredicate.fromJson(dynamic json) {
    if (!(json is Map)) {
      return null;
    }

    final accountId = GrapheneId.fromJson(json['account_id']);
    String name = json['name'];
    return AccountNameEqLitPredicate(accountId, name);
  }

  @override
  bool serialize(Encoder encoder)  {
    encoder.encodeUint8(PredicateType.PredicateAccountNameEqLit.index);
    this.accountId.serialize(encoder);
    encoder.encodeString(this.name);
    return true;
  }

  @override
  dynamic toJson() {
    final val = <String, dynamic>{
      'account_id': this.accountId.toJson(),
      'name' : this.name,
    };

    return val;
  }
}

class AssetSymbolEqLitPredicate extends Serializable{
  GrapheneId assetId;
  String symbol;

  AssetSymbolEqLitPredicate(this.assetId, this.symbol);

  factory AssetSymbolEqLitPredicate.fromJson(dynamic json) {
    if (!(json is Map)) {
      return null;
    }

    final assetId = GrapheneId.fromJson(json['asset_id']);
    String symbol = json['symbol'];
    return AssetSymbolEqLitPredicate(assetId, symbol);
  }

  @override
  bool serialize(Encoder encoder)  {
    encoder.encodeUint8(PredicateType.PredicateAssetSymbolEqLit.index);
    this.assetId.serialize(encoder);
    encoder.encodeString(this.symbol);
    return true;
  }

  @override
  dynamic toJson() {
    final val = <String, dynamic>{
      'asset_id': this.assetId.toJson(),
      'symbol' : this.symbol,
    };

    return val;
  }
}

class BlockIdPredicate extends Serializable{
  Uint8List id;

  BlockIdPredicate(this.id);

  factory BlockIdPredicate.fromJson(dynamic json) {
    if (!(json is Map)) {
      return null;
    }

    final id = hexToBytes(json['id']);
    return BlockIdPredicate(id);
  }

  @override
  bool serialize(Encoder encoder)  {
    encoder.encodeUint8(PredicateType.PredicateBlockId.index);
    encoder.encodeVarint(this.id.length);
    encoder.encodeBytes(this.id);
    return true;
  }

  @override
  dynamic toJson() {
    final val = <String, dynamic>{
      'id': bytesToHex(this.id),
    };

    return val;
  }
}

class Predicate extends Serializable{
  PredicateType type;
  dynamic pre;

  Predicate(this.type, this.pre);

  static List<Predicate> toList(dynamic json) {
    List<Predicate> fields = List();
    if(json != null) {
      final ts = json as List<dynamic>;
      for(final d in ts) {
        final f = Predicate.fromJson(d);
        fields.add(f);
      }
    }
    return fields;
  }

  factory Predicate.fromJson(dynamic json) {
    if(!(json is List)) {
      return null;
    }

    final lst = json as List;
    if(lst.length != 2) {
      return null;
    }

    return Predicate(PredicateType.values[lst[0] as int], lst[1]);
  }

  @override
  bool serialize(Encoder encoder)  {
    //encoder.encodeUint8(this.type.index);
    switch(this.type) {
      case PredicateType.PredicateAccountNameEqLit:
        final accountNameEqLitPredicate = this.pre as AccountNameEqLitPredicate;
        accountNameEqLitPredicate.serialize(encoder);
        break;
      case PredicateType.PredicateAssetSymbolEqLit:
        final predicateAssetSymbolEqLit = this.pre as AssetSymbolEqLitPredicate;
        predicateAssetSymbolEqLit.serialize(encoder);
        break;
      case PredicateType.PredicateBlockId:
        final blockIdPredicate = this.pre as BlockIdPredicate;
        blockIdPredicate.serialize(encoder);
        break;
    }
  }

  @override
  dynamic toJson() {
    return List<dynamic>.from([type.index, pre]);
  }
}
