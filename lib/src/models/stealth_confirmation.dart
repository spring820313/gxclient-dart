import '../core/core.dart';

class StealthConfirmation extends Serializable{
  String oneTimeKey;
  String to;
  String encryptedMemo;

  StealthConfirmation(this.oneTimeKey, this.encryptedMemo, [this.to]);

  factory StealthConfirmation.fromJson(dynamic json) {
    if (!(json is Map)) {
      return null;
    }

    String oneTimeKey = json['one_time_key'];
    String encryptedMemo = json['encrypted_memo'];
    String to = json['to'];
    return StealthConfirmation(oneTimeKey, encryptedMemo, to);
  }

  @override
  bool serialize(Encoder encoder)  {
    encoder.encodePubKey(this.oneTimeKey);
    encoder.encodeBool(this.to != null);
    if(this.to != null) {
      encoder.encodePubKey(this.to);
    }
    final codeHex = hexToBytes(this.encryptedMemo);
    encoder.encodeVarint(codeHex.length);
    encoder.encodeBytes(codeHex);
    return true;
  }

  @override
  dynamic toJson() {
    final val = <String, dynamic>{
      'one_time_key': this.oneTimeKey,
      'encrypted_memo' : this.encryptedMemo,
    };

    if(this.to != null) {
      val['to'] = this.to;
    }

    return val;
  }
}