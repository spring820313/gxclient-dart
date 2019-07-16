import 'dart:typed_data';
import 'dart:convert' as convert;
import 'package:encrypt/encrypt.dart' as encrypt;
import '../ecc/ecc.dart';
import 'formatting.dart';
import 'package:crypto/crypto.dart';
import 'package:pointycastle/digests/sha512.dart';

class GhAes {
  static Uint8List cbcEncrypt(Uint8List srcData, Uint8List key, Uint8List iv) {
    encrypt.Key k = encrypt.Key(key);
    encrypt.IV v = encrypt.IV(iv);
    final encrypter = encrypt.Encrypter(encrypt.AES(k, mode: encrypt.AESMode.cbc));
    final encrypted =  encrypter.encryptBytes(srcData, iv: v);
    return encrypted.bytes;
  }

  static Uint8List pushArray(Uint8List ret, Uint8List v) {
    var t = ret.toList();
    t.addAll(v);
    return Uint8List.fromList(t);
  }

  static String cbcDecrypt(Uint8List encryptedData, Uint8List key, Uint8List iv) {
    encrypt.Key k = encrypt.Key(key);
    encrypt.IV v = encrypt.IV(iv);
    final encrypter = encrypt.Encrypter(encrypt.AES(k, mode: encrypt.AESMode.cbc));
    final decrypted =  encrypter.decrypt(encrypt.Encrypted(encryptedData), iv: v);
    var s = decrypted.length;
    return decrypted;
  }

  static Uint8List encryptWithChecksum(String privateKey, String pubkey, String nonce, String message) {
    var priKey = GXCPrivateKey.fromString(privateKey);
    var pubKey = GXCPublicKey.fromString(pubkey);
    var sharedSecret = priKey.sharedSecret(pubKey);

    var hexShared = bytesToHex(sharedSecret);

    var result = Uint8List(0);

    result = pushArray(result, convert.utf8.encode(nonce));
    result = pushArray(result, convert.utf8.encode(hexShared));

    SHA512Digest sha512 = SHA512Digest();
    final out = sha512.process(result);

    //var test = bytesToHex(out);

    var key = out.sublist(0, 32);
    var iv = out.sublist(32, 48);

    //var siv = bytesToHex(iv);

    var hd = sha256.convert(convert.utf8.encode(message));
    var checksum = hd.bytes.sublist(0, 4);
    checksum = pushArray(checksum, convert.utf8.encode(message));
    int len = checksum.length;
    if(len % 16 != 0) {
        var pad = 16 - len % 16;
        var nPad = List.filled(pad, pad);
        checksum = pushArray(checksum, Uint8List.fromList(nPad));
    }

    //var c = bytesToHex(checksum);

    //var b = convert.utf8.decode(checksum, allowMalformed: true);

    var ret = cbcEncrypt(checksum, key, iv);
    //var d = bytesToHex(ret);
    return ret;
  }

  static String decryptWithChecksum(String privateKey, String pubkey, String nonce, String encryptedMessage) {
    var priKey = GXCPrivateKey.fromString(privateKey);
    var pubKey = GXCPublicKey.fromString(pubkey);
    var sharedSecret = priKey.sharedSecret(pubKey);

    var hexShared = bytesToHex(sharedSecret);

    var result = Uint8List(0);
    result = pushArray(result, convert.utf8.encode(nonce));
    result = pushArray(result, convert.utf8.encode(hexShared));

    SHA512Digest sha512 = SHA512Digest();
    final out = sha512.process(result);

    var key = out.sublist(0, 32);
    var iv = out.sublist(32, 48);
    var encryptedData = hexToBytes(encryptedMessage);
    var ret = cbcDecrypt(encryptedData, key, iv);

    var checksum = ret.substring(0, 4);
    var msgData = ret.substring(4);

    return msgData;
  }

}