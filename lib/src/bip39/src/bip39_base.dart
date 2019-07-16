import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:hex/hex.dart';
import 'package:pointycastle/pointycastle.dart';
import 'package:unorm_dart/unorm_dart.dart';

import 'wordlists/english.dart';

// https://github.com/bitcoin/bips/blob/master/bip-0039.mediawiki
// https://github.com/bitcoin/bips/tree/master/bip-0039
// https://github.com/bitcoinjs/bip39/blob/master/index.js

enum Wordlist {
  CHINESE_SIMPLIFIED,
  CHINESE_TRADITIONAL,
  ENGLISH,
  FRENCH,
  ITALIAN,
  JAPANESE,
  KOREAN,
  SPANISH,
}

final _wordlistCache = Map<Wordlist, List<dynamic>>();

const Wordlist _DEFAULT_WORDLIST = Wordlist.ENGLISH;

const int _SIZE_8BITS = 255;
const String _INVALID_ENTROPY = 'Invalid entroy';
const String _INVALID_MNEMONIC = 'Invalid mnemonic';
const String _INVALID_CHECKSUM = 'Invalid checksum';

String _getWordlistName(Wordlist wordlist) {
  switch (wordlist) {
    case Wordlist.CHINESE_SIMPLIFIED:
      return 'chinese_simplified';
    case Wordlist.CHINESE_TRADITIONAL:
      return 'chinese_traditional';
    case Wordlist.ENGLISH:
      return 'english';
    case Wordlist.FRENCH:
      return 'french';
    case Wordlist.ITALIAN:
      return 'italian';
    case Wordlist.JAPANESE:
      return 'japanese';
    case Wordlist.KOREAN:
      return 'korean';
    case Wordlist.SPANISH:
      return 'spanish';
    default:
      return 'english';
  }
}

int _binaryToByte(String binary) {
  return int.parse(binary, radix: 2);
}

String _bytesToBinary(Uint8List bytes) {
  return bytes.map((byte) => byte.toRadixString(2).padLeft(8, '0')).join('');
}

String _salt(String password) {
  return 'mnemonic${password ?? ""}';
}

String _deriveChecksumBits(Uint8List entropy) {
  final ENT = entropy.length * 8;
  final CS = ENT ~/ 32;

  final hash = sha256.newInstance().convert(entropy);
  return _bytesToBinary(Uint8List.fromList(hash.bytes)).substring(0, CS);
}

typedef Uint8List RandomBytes(int size);

Uint8List _nextBytes(int size) {
  final rnd = Random.secure();
  final bytes = Uint8List(size);
  for (var i = 0; i < size; i++) {
    bytes[i] = rnd.nextInt(_SIZE_8BITS);
  }
  return bytes;
}

/// Converts [mnemonic] code to seed.
///
/// Returns Uint8List.
Uint8List mnemonicToSeed(String mnemonic, [String password = ""]) {
  final mnemonicBuffer = utf8.encode(nfkd(mnemonic));
  final saltBuffer = utf8.encode(_salt(nfkd(password)));
  final pbkdf2 = KeyDerivator('SHA-512/HMAC/PBKDF2');

  pbkdf2.init(Pbkdf2Parameters(saltBuffer, 2048, 64));
  return pbkdf2.process(mnemonicBuffer);
}

/// Converts [mnemonic] code to seed, as hex string.
///
/// Returns hex string.
String mnemonicToSeedHex(String mnemonic, [String password = ""]) {
  return mnemonicToSeed(mnemonic, password).map((byte) {
    return byte.toRadixString(16).padLeft(2, '0');
  }).join('');
}

/// Converts [mnemonic] code to entropy.
Future<Uint8List> mnemonicToEntropy(String mnemonic,
    [Wordlist wordlist = _DEFAULT_WORDLIST]) async {
  final wordRes = await _loadWordlist(wordlist);
  final words = nfkd(mnemonic).split(' ');

  if (words.length % 3 != 0) {
    throw new ArgumentError(_INVALID_MNEMONIC);
  }

  // convert word indices to 11bit binary strings
  final bits = words.map((word) {
    final index = wordRes.indexOf(word);
    if (index == -1) {
      throw ArgumentError(_INVALID_MNEMONIC);
    }

    return index.toRadixString(2).padLeft(11, '0');
  }).join('');

  // split the binary string into ENT/CS
  final dividerIndex = (bits.length / 33).floor() * 32;
  final entropyBits = bits.substring(0, dividerIndex);
  final checksumBits = bits.substring(dividerIndex);

  final regex = RegExp(r".{1,8}");

  final entropyBytes = Uint8List.fromList(regex
      .allMatches(entropyBits)
      .map((match) => _binaryToByte(match.group(0)))
      .toList(growable: false));
  if (entropyBytes.length < 16) {
    throw StateError(_INVALID_ENTROPY);
  }
  if (entropyBytes.length > 32) {
    throw StateError(_INVALID_ENTROPY);
  }
  if (entropyBytes.length % 4 != 0) {
    throw StateError(_INVALID_ENTROPY);
  }

  final newCheckSum = _deriveChecksumBits(entropyBytes);
  if (newCheckSum != checksumBits) {
    throw StateError(_INVALID_CHECKSUM);
  }

  return entropyBytes;
}

/// Converts [entropy] to mnemonic code.
Future<String> entropyToMnemonic(Uint8List entropy,
    [Wordlist wordlist = _DEFAULT_WORDLIST]) async {
  if (entropy.length < 16) {
    throw ArgumentError(_INVALID_ENTROPY);
  }
  if (entropy.length > 32) {
    throw ArgumentError(_INVALID_ENTROPY);
  }
  if (entropy.length % 4 != 0) {
    throw ArgumentError(_INVALID_ENTROPY);
  }

  final entroypyBits = _bytesToBinary(entropy);
  final checksumBits = _deriveChecksumBits(entropy);

  final bits = entroypyBits + checksumBits;

  final regex = new RegExp(r".{1,11}", caseSensitive: false, multiLine: false);
  final chunks = regex
      .allMatches(bits)
      .map((match) => match.group(0))
      .toList(growable: false);

  final wordRes = await _loadWordlist(wordlist);

  return chunks
      .map((binary) => wordRes[_binaryToByte(binary)])
      .join(wordlist == Wordlist.JAPANESE ? '\u3000' : ' ');
}

/// Converts HEX string [entropy] to mnemonic code
Future<String> entropyHexToMnemonic(String entropy,
    [Wordlist wordlist = _DEFAULT_WORDLIST]) {
  return entropyToMnemonic(HEX.decode(entropy), wordlist);
}

/// Generates a random mnemonic.
///
/// Defaults to 128-bits of entropy.
/// By default it uses [Random.secure()] under the food to get random bytes,
/// but you can swap RNG by providing [randomBytes].
/// Default wordlist is English, but you can use different wordlist by providing [wordlist].
Future<String> generateMnemonic({
  int strength = 128,
  RandomBytes randomBytes = _nextBytes,
  Wordlist wordlist = _DEFAULT_WORDLIST,
}) async {
  assert(strength % 32 == 0);

  final entropy = randomBytes(strength ~/ 8);

  return await entropyToMnemonic(entropy, wordlist);
}

/// Check if [mnemonic] code is valid.
Future<bool> validateMnemonic(String mnemonic,
    [Wordlist wordlist = _DEFAULT_WORDLIST]) async {
  try {
    await mnemonicToEntropy(mnemonic, wordlist);
  } catch (e) {
    return false;
  }
  return true;
}

Future<List<String>> _loadWordlist(Wordlist wordlist) async {
  if (_wordlistCache.containsKey(wordlist)) {
    return _wordlistCache[wordlist];
  } else {
    _wordlistCache[wordlist] = wordlist_english;
    return wordlist_english;
  }
}
