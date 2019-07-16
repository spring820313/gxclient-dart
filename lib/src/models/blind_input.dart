import '../core/core.dart';
import 'authority.dart';

class BlindInput extends Serializable{
  String commitment;
  Authority owner;

  BlindInput(this.commitment, this.owner);

  static List<BlindInput> toList(dynamic json) {
    List<BlindInput> fields = List();
    if(json != null) {
      final ts = json as List<dynamic>;
      for(final d in ts) {
        final f = BlindInput.fromJson(d);
        fields.add(f);
      }
    }
    return fields;
  }

  factory BlindInput.fromJson(dynamic json) {
    if (!(json is Map)) {
      return null;
    }

    String commitment = json['commitment'];
    final owner = Authority.fromJson(json['owner']);
    return BlindInput(commitment, owner);
  }

  @override
  bool serialize(Encoder encoder)  {
    final codeHex = hexToBytes(this.commitment);
    encoder.encodeVarint(codeHex.length);
    encoder.encodeBytes(codeHex);
    this.owner.serialize(encoder);
    return true;
  }

  @override
  dynamic toJson() {
    final val = <String, dynamic>{
      'commitment': this.commitment,
      'owner' : this.owner.toJson(),
    };

    return val;
  }
}