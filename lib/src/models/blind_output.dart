import '../core/core.dart';
import 'stealth_confirmation.dart';
import 'authority.dart';

class BlindOutput extends Serializable{
  String commitment;
  String rangeProof;
  Authority owner;
  StealthConfirmation stealthMemo;

  BlindOutput(this.commitment, this.rangeProof, this.owner, [this.stealthMemo]);

  static List<BlindOutput> toList(dynamic json) {
    List<BlindOutput> fields = List();
    if(json != null) {
      final ts = json as List<dynamic>;
      for(final d in ts) {
        final f = BlindOutput.fromJson(d);
        fields.add(f);
      }
    }
    return fields;
  }

  factory BlindOutput.fromJson(dynamic json) {
    if (!(json is Map)) {
      return null;
    }

    String commitment = json['commitment'];
    String rangeProof = json['range_proof'];
    final owner = Authority.fromJson(json['owner']);
    StealthConfirmation stealthMemo = null;
    if(json['stealth_memo'] != null) {
      stealthMemo = StealthConfirmation.fromJson(json['stealth_memo']);
    }
    return BlindOutput(commitment, rangeProof, owner, stealthMemo);
  }

  @override
  bool serialize(Encoder encoder)  {
    var codeHex = hexToBytes(this.commitment);
    encoder.encodeVarint(codeHex.length);
    encoder.encodeBytes(codeHex);

    codeHex = hexToBytes(this.rangeProof);
    encoder.encodeVarint(codeHex.length);
    encoder.encodeBytes(codeHex);

    this.owner.serialize(encoder);
    encoder.encodeBool(this.stealthMemo != null);
    if(this.stealthMemo != null) {
      this.stealthMemo.serialize(encoder);
    }
    return true;
  }

  @override
  dynamic toJson() {
    final val = <String, dynamic>{
      'commitment': this.commitment,
      'range_proof': this.rangeProof,
      'owner' : this.owner.toJson(),
    };

    if(this.stealthMemo != null) {
      val['stealth_memo'] = this.stealthMemo.toJson();
    }

    return val;
  }
}