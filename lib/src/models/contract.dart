import '../core/serialization.dart';
import '../core/encoder.dart';
import 'graphene_id.dart';

class TypeDef extends Serializable{
  String newTypeName;
  String type;

  TypeDef(this.newTypeName, this.type);

  static List<TypeDef> toList(dynamic json) {
    List<TypeDef> fields = List();
    if(json != null) {
      final ts = json as List<dynamic>;
      for(final d in ts) {
        final f = TypeDef.fromJson(d);
        fields.add(f);
      }
    }
    return fields;
  }

  factory TypeDef.fromJson(dynamic json) {
    if (!(json is Map)) {
      return null;
    }

    String newTypeName = json['new_type_name'];
    String type = json['type'];
    return TypeDef(newTypeName, type);
  }

  @override
  bool serialize(Encoder encoder)  {
    encoder.encodeString(this.newTypeName);
    encoder.encodeString(this.type);
    return true;
  }

  @override
  dynamic toJson() {
    final val = <String, dynamic>{
      'new_type_name': this.newTypeName,
      'type' : this.type,
    };

    return val;
  }
}

class ErrorMessage extends Serializable{
  int errorCode;
  String errorMsg;

  ErrorMessage(this.errorCode, this.errorMsg);

  static List<ErrorMessage> toList(dynamic json) {
    List<ErrorMessage> fields = List();
    if(json != null) {
      final ts = json as List<dynamic>;
      for(final d in ts) {
        final f = ErrorMessage.fromJson(d);
        fields.add(f);
      }
    }
    return fields;
  }

  factory ErrorMessage.fromJson(dynamic json) {
    if (!(json is Map)) {
      return null;
    }

    int errorCode = json['error_code'] as int;
    String errorMsg = json['error_msg'];
    return ErrorMessage(errorCode, errorMsg);
  }

  @override
  bool serialize(Encoder encoder)  {
    encoder.encodeUint64(this.errorCode);
    encoder.encodeString(this.errorMsg);
    return true;
  }

  @override
  dynamic toJson() {
    final val = <String, dynamic>{
      'error_code': this.errorCode,
      'error_msg' : this.errorMsg,
    };

    return val;
  }
}

class Field extends Serializable{
  String name;
  String type;

  Field(this.name, this.type);

  static List<Field> toList(dynamic json) {
    List<Field> fields = List();
    if(json != null) {
      final ts = json as List<dynamic>;
      for(final d in ts) {
        final f = Field.fromJson(d);
        fields.add(f);
      }
    }
    return fields;
  }

  factory Field.fromJson(dynamic json) {
    if (!(json is Map)) {
      return null;
    }

    String name = json['name'];
    String type = json['type'];
    return Field(name, type);
  }

  @override
  bool serialize(Encoder encoder)  {
    encoder.encodeString(this.name);
    encoder.encodeString(this.type);
    return true;
  }

  @override
  dynamic toJson() {
    final val = <String, dynamic>{
      'name': this.name,
      'type' : this.type,
    };

    return val;
  }
}


class Struct extends Serializable{
  String name;
  String base;
  List<Field> fields;

  Struct(this.name, this.base, this.fields);

  static List<Struct> toList(dynamic json) {
    List<Struct> fields = List();
    if(json != null) {
      final ts = json as List<dynamic>;
      for(final d in ts) {
        final f = Struct.fromJson(d);
        fields.add(f);
      }
    }
    return fields;
  }

  factory Struct.fromJson(dynamic json) {
    if (!(json is Map)) {
      return null;
    }

    String name = json['name'];
    String base = json['base'];

    /*
    List<Field> fields = List();
    final fs = json['fields'];
    if(fs != null) {
      final ts = fs as List<dynamic>;
      for(final d in ts) {
        final f = Field.fromJson(d);
        fields.add(f);
      }
    }
     */
    final fields = Field.toList(json['fields']);

    return Struct(name, base, fields);
  }

  @override
  bool serialize(Encoder encoder)  {
    encoder.encodeString(this.name);
    encoder.encodeString(this.base);
    encoder.encodeVarint(fields.length);
    for(var f in this.fields) {
      f.serialize(encoder);
    }
    return true;
  }

  @override
  dynamic toJson() {
    final val = <String, dynamic>{
      'name': this.name,
      'base' : this.base,
    };

    /*
    List<dynamic> fs = List();
    for(var f in this.fields) {
      fs.add(f.toJson());
    }
     */
    val['fields'] = fromList<Field>(this.fields);

    return val;
  }
}

class Table extends Serializable{
  String name;
  String indexType;
  List<String> keyNames;
  List<String> keyTypes;
  String type;

  Table(this.name, this.indexType, this.keyNames, this.keyTypes, this.type);

  static List<Table> toList(dynamic json) {
    List<Table> fields = List();
    if(json != null) {
      final ts = json as List<dynamic>;
      for(final d in ts) {
        final f = Table.fromJson(d);
        fields.add(f);
      }
    }
    return fields;
  }

  factory Table.fromJson(dynamic json) {
    if (!(json is Map)) {
      return null;
    }

    String name = json['name'];
    String indexType = json['index_type'];
    String type = json['type'];

    List<String> keyNames = strsToList(json['key_names']);
    List<String> keyTypes = strsToList(json['key_types']);

    return Table(name, indexType, keyNames, keyTypes, type);
  }

  @override
  bool serialize(Encoder encoder)  {
    encoder.encodeName(this.name);
    encoder.encodeString(this.indexType);
    encoder.encodeVarint(keyNames.length);
    for(var n in this.keyNames) {
      encoder.encodeString(n);
    }
    encoder.encodeVarint(keyTypes.length);
    for(var t in this.keyTypes) {
      encoder.encodeString(t);
    }
    encoder.encodeString(this.type);
    return true;
  }

  @override
  dynamic toJson() {
    final val = <String, dynamic>{
      'name': this.name,
      'index_type' : this.indexType,
      'type' : this.type,
      'key_names' : this.keyNames,
      'key_types' : this.keyTypes,
    };

    return val;
  }
}

class Action extends Serializable{
  String name;
  String type;
  bool payable;

  Action(this.name, this.type, this.payable);

  static List<Action> toList(dynamic json) {
    List<Action> fields = List();
    if(json != null) {
      final ts = json as List<dynamic>;
      for(final d in ts) {
        final f = Action.fromJson(d);
        fields.add(f);
      }
    }
    return fields;
  }

  factory Action.fromJson(dynamic json) {
    if (!(json is Map)) {
      return null;
    }

    String name = json['name'];
    String type = json['type'];
    bool payable = json['payable'] as bool;

    return Action(name, type, payable);
  }

  @override
  bool serialize(Encoder encoder)  {
    encoder.encodeName(this.name);
    encoder.encodeString(this.type);
    encoder.encodeBool(this.payable);
    return true;
  }

  @override
  dynamic toJson() {
    final val = <String, dynamic>{
      'name': this.name,
      'type' : this.type,
      'payable' : this.payable,
    };

    return val;
  }
}

class Abi extends Serializable{
  String version;
  List<TypeDef> types;
  List<Struct> structs;
  List<Action> actions;
  List<Table> tables;
  List<ErrorMessage> errorMessages;
  List<dynamic> abiExtensions;

  Abi(this.version, this.types, this.structs, this.actions, this.tables, this.errorMessages, this.abiExtensions);

  static List<Abi> toList(dynamic json) {
    List<Abi> fields = List();
    if(json != null) {
      final ts = json as List<dynamic>;
      for(final d in ts) {
        final f = Abi.fromJson(d);
        fields.add(f);
      }
    }
    return fields;
  }

  factory Abi.fromJson(dynamic json) {
    if (!(json is Map)) {
      return null;
    }

    String version = json['version'];
    final types = TypeDef.toList(json['types']);
    final structs = Struct.toList(json['structs']);
    final actions = Action.toList(json['actions']);
    final tables = Table.toList(json['tables']);
    final errorMessages = ErrorMessage.toList(json['error_messages']);
    List<dynamic> abiExtensions = [];

    return Abi(version, types, structs, actions, tables, errorMessages, abiExtensions);
  }

  @override
  bool serialize(Encoder encoder)  {
    encoder.encodeString(this.version);
    encoder.encodeVarint(types.length);
    for(var t in this.types) {
      t.serialize(encoder);
    }

    encoder.encodeVarint(structs.length);
    for(var s in this.structs) {
      s.serialize(encoder);
    }

    encoder.encodeVarint(actions.length);
    for(var a in this.actions) {
      a.serialize(encoder);
    }

    encoder.encodeVarint(tables.length);
    for(var ta in this.tables) {
      ta.serialize(encoder);
    }

    encoder.encodeVarint(errorMessages.length);
    for(var e in this.errorMessages) {
      e.serialize(encoder);
    }

    encoder.encodeVarint(0);
    return true;
  }

  @override
  dynamic toJson() {
    final val = <String, dynamic>{
      'version': this.version,
      'abi_extensions' : [],
    };

    List<dynamic> ts = List();
    for(var f in this.types) {
      ts.add(f.toJson());
    }
    val['types'] = ts;

    List<dynamic> ss = List();
    for(var s in this.structs) {
      ss.add(s.toJson());
    }
    val['structs'] = ss;

    List<dynamic> as = List();
    for(var a in this.actions) {
      as.add(a.toJson());
    }
    val['actions'] = as;

    List<dynamic> tas = List();
    for(var t in this.tables) {
      tas.add(t.toJson());
    }
    val['tables'] = tas;

    List<dynamic> es = List();
    for(var e in this.errorMessages) {
      es.add(e.toJson());
    }
    val['error_messages'] = es;

    return val;
  }
}

class ContractAccountProperties extends Serializable {
  GrapheneId id;
  String membershipExpirationDate;
  String registrar;
  String referrer;
  String lifetimeReferrer;
  int networkFeePercentage;
  int lifetimeReferrerFeePercentage;
  int referrerRewardsPercentage;
  String name;
  String statistics;
  List<String> whitelistingAccounts;
  List<String> blacklistingAccounts;
  List<String> whitelistedAccounts;
  List<String> blacklistedAccounts;
  Abi abi;
  String vmType;
  String vmVersion;
  String code;
  String codeVersion;

  ContractAccountProperties();

  factory ContractAccountProperties.fromJson(dynamic json) {
    if (!(json is Map)) {
      return null;
    }

    var contractAccountProperties = ContractAccountProperties();
    GrapheneId id = GrapheneId.fromJson(json['id']);
    contractAccountProperties.id = id;
    String membershipExpirationDate = json['membership_expiration_date'];
    contractAccountProperties.membershipExpirationDate = membershipExpirationDate;
    String registrar = json['registrar'];
    contractAccountProperties.registrar = registrar;
    String referrer = json['referrer'];
    contractAccountProperties.referrer = referrer;
    String lifetimeReferrer = json['lifetime_referrer'];
    contractAccountProperties.lifetimeReferrer= lifetimeReferrer;
    int networkFeePercentage = json['network_fee_percentage'];
    contractAccountProperties.networkFeePercentage = networkFeePercentage;
    int lifetimeReferrerFeePercentage = json['lifetime_referrer_fee_percentage'];
    contractAccountProperties.lifetimeReferrerFeePercentage = lifetimeReferrerFeePercentage;
    int referrerRewardsPercentage = json['referrer_rewards_percentage'];
    contractAccountProperties.referrerRewardsPercentage = referrerRewardsPercentage;
    String name = json['name'];
    contractAccountProperties.name = name;
    String statistics = json['statistics'];
    contractAccountProperties.statistics = statistics;

    List<String> whitelistingAccounts = strsToList(json['whitelisting_accounts']);
    contractAccountProperties.whitelistingAccounts = whitelistingAccounts;
    List<String> blacklistingAccounts = strsToList(json['blacklisting_accounts']);
    contractAccountProperties.blacklistingAccounts = blacklistingAccounts;
    List<String> whitelistedAccounts = strsToList(json['whitelisted_accounts']);
    contractAccountProperties.whitelistedAccounts = whitelistedAccounts;
    List<String> blacklistedAccounts = strsToList(json['blacklisted_accounts']);
    contractAccountProperties.blacklistedAccounts = blacklistedAccounts;
    Abi abi = Abi.fromJson(json['abi']);
    contractAccountProperties.abi = abi;

    String vmType = json['vm_type'];
    contractAccountProperties.vmType = vmType;
    String vmVersion = json['vm_version'];
    contractAccountProperties.vmVersion = vmVersion;
    String code = json['code'];
    contractAccountProperties.code = code;
    String codeVersion = json['code_version'];
    contractAccountProperties.codeVersion = codeVersion;

    return contractAccountProperties;
  }

  @override
  bool serialize(Encoder encoder)  {
    return true;
  }

  @override
  dynamic toJson() {
    final val = <String, dynamic>{
      'id': this.id.toJson(),
      'membership_expiration_date' : this.membershipExpirationDate,
      'registrar' : this.registrar,
      'referrer' : this.referrer,
      'lifetime_referrer' : this.lifetimeReferrer,

      'network_fee_percentage' : this.networkFeePercentage,
      'lifetime_referrer_fee_percentage' : this.lifetimeReferrerFeePercentage,
      'referrer_rewards_percentage' : this.referrerRewardsPercentage,

      'name' : this.name,
      'statistics' : this.statistics,

      'whitelisting_accounts' : this.whitelistingAccounts,
      'blacklisting_accounts' : this.blacklistingAccounts,
      'whitelisted_accounts' : this.whitelistedAccounts,
      'blacklisted_accounts' : this.blacklistedAccounts,

      'abi' : this.abi.toJson(),
      'vm_type' : this.vmType,
      'vm_version' : this.vmVersion,
      'code' : this.code,
      'code_version' : this.codeVersion,
    };

    return val;
  }
}