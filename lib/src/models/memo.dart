import 'dart:math';
import '../core/serialization.dart';
import '../core/encoder.dart';
import '../core/formatting.dart';
import '../core/aes.dart';
import '../ecc/ecc.dart';

class Memo extends Serializable{
  String from;
  String to;
  int nonce;
  String message = '';

  Memo(String fromPrivKey, this.to, String utf8Msg) {
    var privKey = GXCPrivateKey.fromString(fromPrivKey);
    var fromPubKey = privKey.toGXCPublicKey().toString();

    this.from = fromPubKey;
    this.nonce = randNonce();
    if(utf8Msg != null && utf8Msg.length > 0) {
      var encryptedData = GhAes.encryptWithChecksum(fromPrivKey, to, nonce.toString(), utf8Msg);
      this.message = bytesToHex(encryptedData);
    }
  }

  int randNonce() {
    final int randomLimit = 1 << 31;
    Random randomGenerator;
    try {
      randomGenerator = Random.secure();
    } catch (e) {
      randomGenerator = new Random();
    }

    int randomInt = randomGenerator.nextInt(randomLimit);
    return randomInt;
  }

  @override
  bool serialize(Encoder encoder)  {
    encoder.encodePubKey(from);
    encoder.encodePubKey(to);
    encoder.encodeUint64(nonce);
    var msgData = hexToBytes(message);
    encoder.encodeVarint(msgData.length);
    if(msgData.length > 0) {
      encoder.encodeBytes(msgData);
    }

    return true;
  }

  @override
  dynamic toJson() {
    final val = <String, dynamic>{
      'from': this.from,
      'to':   this.to,
      'nonce': this.nonce,
      'message': this.message,
    };

    return val;
  }
}