import 'dart:typed_data';
import 'package:bs58check/bs58check.dart';
import 'package:pointycastle/digests/ripemd160.dart';
import 'package:pointycastle/src/utils.dart';
import '../core/serialization.dart';
import '../core/encoder.dart';
import '../ecc/ecc.dart';

class Address extends Serializable{
  final String prefix;
  Uint8List data;
  Uint8List checksum;

  Address(this.prefix, this.data, this.checksum);

  Address.fromPublicKey(this.prefix, GXCPublicKey pub) {
    this.data = pub.toBuffer();
    this.checksum = RIPEMD160Digest().process(this.data).sublist(0, 4);
  }

  Address.fromString(this.prefix, String address) {
    if(!address.startsWith(this.prefix)) {
      return;
    }
    String stripped = address.substring(this.prefix.length);
    var b58 = base58.decode(stripped);
    var len = b58.length;
    if(len < 5) {
      return;
    }
    var chk1 = b58.sublist(len - 4);
    var data1 = b58.sublist(0, len - 4);
    var chk2 = RIPEMD160Digest().process(data1).sublist(0, 4);

    if (decodeBigInt(chk1) != decodeBigInt(chk2)) {
      throw InvalidKey("checksum error");
    }

    this.data = data1;
    this.checksum = chk1;
  }

  @override
  bool serialize(Encoder encoder)  {
    encoder.encodeBytes(this.data);
    return true;
  }

  @override
  dynamic toJson() {
    return toString();
  }

  @override
  String toString() {
    return prefix + base58.encode(data);
  }
}