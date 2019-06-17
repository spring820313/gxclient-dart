import 'dart:typed_data';

import 'operations.dart';
import 'data_stream.dart';
import 'encoder.dart';

class Transaction extends Object{
  int refBlockNum = 0;
  int refBlockPrefix = 0;
  DateTime expiration;
  Operations operations;
  List<String> signatures;

  Transaction.Default();

  Transaction(this.refBlockNum,
      this.refBlockPrefix,
      this.expiration,
      this.operations,
      this.signatures);

  Uint8List serialize() {
    var data = Uint8List(0);
    DataStream ds = DataStream(data);

    Encoder encoder = Encoder(ds);
    encoder.encodeUint16(this.refBlockNum);
    encoder.encodeUint32(this.refBlockPrefix);
    encoder.encodeUint32((this.expiration.millisecondsSinceEpoch / 1000).round());
    this.operations.serialize(encoder);
    encoder.encodeVarint(0);

    return encoder.asBytes();
  }

  Map<String, dynamic> toJson() {
    final val = <String, dynamic>{
      'ref_block_num': this.refBlockNum,
      'ref_block_prefix' : this.refBlockPrefix,
      'expiration' : this.expiration.toIso8601String().substring(0, this.expiration.toIso8601String().length - 5),
      'operations' : this.operations.toJson(),
      'signatures' : this.signatures,
      'extensions' : [],
    };

    return val;
  }

  @override
  String toString() => this.toJson().toString();
}