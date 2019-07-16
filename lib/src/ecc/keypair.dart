import '../core/core.dart' as core;
import '../bip39/bip39.dart' as bip39;
import '../ecc/ecc.dart' as ecc;

class KeyPair {
  String publicKey;
  String privateKey;
  String brainKey;

  KeyPair(this.brainKey, this.privateKey, this.publicKey);

  static Future<KeyPair> fromSeed([String seed]) async {
    String brainKey;
    if(seed == null) {
      brainKey = await bip39.generateMnemonic();
    } else {
      brainKey = seed;
    }

    final brainKeyBytes = core.utf8Encode(brainKey);
    final privateKeyBytes = ecc.singleDigest(brainKeyBytes);
    final privateKey = ecc.GXCPrivateKey.fromBuffer(privateKeyBytes);
    final wif = privateKey.toString();
    final pub = privateKey.toGXCPublicKey().toString();
    return KeyPair(brainKey, wif, pub);
  }
}