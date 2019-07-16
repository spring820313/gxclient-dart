import 'dart:typed_data';

import '../operations.dart';
import '../encoder.dart';
import 'optype.dart';
import '../../models/models.dart';
import '../../core/core.dart';
import 'package:crypto/crypto.dart';
import '../../ecc/ecc.dart';

class SignedProxyTransferParams extends Serializable{
  GrapheneId from;
  GrapheneId to;
  GrapheneId proxyAccount;
  AssetAmount amount;
  int percentage;
  String memo;
  Time expiration;
  List<String> signatures = List();

  SignedProxyTransferParams(this.from, this.to, this.proxyAccount,
      this.amount, this.percentage, this.memo, this.expiration);

  Uint8List toUnsignBytes(bool signed) {
    var data = Uint8List(0);
    DataStream ds = DataStream(data);

    Encoder encoder = Encoder(ds);
    this.from.serialize(encoder);
    this.to.serialize(encoder);
    this.proxyAccount.serialize(encoder);
    this.amount.serialize(encoder);
    encoder.encodeUint16(this.percentage);
    encoder.encodeString(this.memo);
    this.expiration.serialize(encoder);
    if(signed == false)
      encoder.encodeVarint(0);

    return encoder.asBytes();
  }

  void sign(String key) {
    final msgBytes = toUnsignBytes(false);
    Digest d = sha256.convert(msgBytes);

    var privateKey = GXCPrivateKey.fromString(key);
    var signature = privateKey.signHash(d.bytes);
    this.signatures.add(signature.toString());
  }

  @override
  bool serialize(Encoder encoder) {
    final unsigned = toUnsignBytes(true);
    encoder.encodeBytes(unsigned);

    final sigSize = this.signatures.length;
    encoder.encodeVarint(sigSize);
    for(var s in this.signatures) {
      final sig = hexToBytes(s);
      encoder.encodeBytes(sig);
    }

    return true;
  }

  @override
  dynamic toJson() {
    final val = <String, dynamic>{
      'from': this.from.toJson(),
      'to': this.to.toJson(),
      'proxy_account':   this.proxyAccount.toJson(),
      'amount': this.amount.toJson(),
      'percentage': this.percentage,
      'memo': this.memo,
      'expiration': this.expiration.dt.toIso8601String().substring(0, this.expiration.dt.toIso8601String().length - 5),
      'signatures' : this.signatures,
    };

    return val;
  }
}

class ProxyTransferOperation extends Operation {
  AssetAmount fee;
  String proxyMemo;
  SignedProxyTransferParams requestParams;
  List<dynamic> extensions;

  ProxyTransferOperation(this.proxyMemo, this.requestParams, this.fee);

  @override
  OpType opType() {
    return OpType.ProxyTransferOpType;
  }

  @override
  bool serialize(Encoder encoder) {
    encoder.encodeVarint(opType().index);
    encoder.encodeString(this.proxyMemo);
    this.fee.serialize(encoder);
    this.requestParams.serialize(encoder);

    //Extensions
    encoder.encodeVarint(0);

    return true;
  }

  @override
  dynamic toJson() {
    final val = <String, dynamic>{
      'proxy_memo': this.proxyMemo,
      'request_params': this.requestParams.toJson(),
      'fee': this.fee.toJson(),
      'extensions' : [],
    };

    return val;
  }
}