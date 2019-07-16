import 'dart:typed_data';

import 'optype.dart';
import '../operations.dart';
import '../encoder.dart';
import '../../models/models.dart';
import '../formatting.dart';

class CustomOperation extends Operation {
  AssetAmount fee;
  GrapheneId payer;
  GrapheneIds requiredAuths;
  int id;
  Uint8List data;

  CustomOperation(this.payer, this.requiredAuths, this.id, this.data, this.fee);

  @override
  OpType opType() {
    return OpType.CustomOpType;
  }

  @override
  bool serialize(Encoder encoder) {
    encoder.encodeVarint(opType().index);
    this.fee.serialize(encoder);
    this.payer.serialize(encoder);
    this.requiredAuths.serialize(encoder);
    encoder.encodeUint16(this.id);
    if(this.data == null) {
      encoder.encodeVarint(0);
    } else {
      encoder.encodeVarint(this.data.length);
      encoder.encodeBytes(this.data);
    }

    return true;
  }

  @override
  dynamic toJson() {
    final val = <String, dynamic>{
      'payer': this.payer.toJson(),
      'required_auths': this.requiredAuths.toJson(),
      'id': this.id,
      'fee': this.fee.toJson(),
    };

    if(this.data == null) {
      val['data'] = '';
    } else {
      val['data'] = bytesToHex(this.data);
    }

    return val;
  }
}