import 'dart:typed_data';
import 'transaction.dart';
import 'formatting.dart';
import 'package:crypto/crypto.dart';
import '../ecc/ecc.dart';

class SignedTransaction {
  Transaction tx;

  SignedTransaction(this.tx);

  Uint8List digest(String chainId) {
    if(chainId == null || chainId.length <= 0) {
      throw 'Bad parameter';
    }
    var idBytes = hexToBytes(chainId);
    List<int> ret = List();
    ret.addAll(idBytes);

    var txBytes = tx.serialize();
    ret.addAll(txBytes);

    var a = Uint8List.fromList(ret);
    var s = bytesToHex(a);
    print(s);

    Digest d = sha256.convert(ret);
    var s2 = bytesToHex(d.bytes);
    print(s2);
    return d.bytes;
  }

  bool sign(List<String> wifs, String chainId) {
    if(wifs.length < 1) {
      return false;
    }

    var hash = this.digest(chainId);
    List<String> sigsHex = List();
    for(var wif in wifs) {
      var privateKey = GXCPrivateKey.fromString(wif);
      var signature = privateKey.signHash(hash);
      sigsHex.add(signature.toString());
    }
    this.tx.signatures = sigsHex;
    return true;
  }

}