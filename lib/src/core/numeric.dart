import 'dart:typed_data';

/// @module Numeric
/// Public key data size, excluding type field
var publicKeyDataSize = 33;

/// Private key data size, excluding type field
var privateKeyDataSize = 32;

/// Signature data size, excluding type field
var signatureDataSize = 65;

var base58Chars = '123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz';
var base64Chars =
    'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/';

List<int> create_base58_map() {
  var base58M = List.filled(256, -1);
  for (var i = 0; i < base58Chars.length; ++i) {
    base58M[base58Chars.codeUnitAt(i)] = i;
  }
  return base58M;
}

final base58Map = create_base58_map();

List<int> create_base64_map() {
  var base64M = List.filled(256, -1);
  for (var i = 0; i < base64Chars.length; ++i) {
    base64M[base64Chars.codeUnitAt(i)] = i;
  }
  base64M['='.codeUnitAt(0)] = 0;
  return base64M;
}

final base64Map = create_base64_map();

/// Is `bignum` a negative number?
bool isNegative(Uint8List bignum) {
  return (bignum[bignum.length - 1] & 0x80) != 0;
}

/// Negate `bignum`
void negate(Uint8List bignum) {
  var carry = 1;
  for (var i = 0; i < bignum.length; ++i) {
    var x = (~bignum[i] & 0xff) + carry;
    bignum[i] = x;
    carry = x >> 8;
  }
}

/// Convert an unsigned decimal number in `s` to a bignum
/// @param size bignum size (bytes)
Uint8List decimalToBinary(int size, String s) {
  var result = Uint8List(size);
  for (var i = 0; i < s.length; ++i) {
    var srcDigit = s.codeUnitAt(i);
    if (srcDigit < '0'.codeUnitAt(0) || srcDigit > '9'.codeUnitAt(0)) {
      throw 'invalid number';
    }
    var carry = srcDigit - '0'.codeUnitAt(0);
    for (var j = 0; j < size; ++j) {
      var x = result[j] * 10 + carry;
      result[j] = x;
      carry = x >> 8;
    }
    if (carry != 0) {
      throw 'number is out of range';
    }
  }
  return result;
}

/// Convert a signed decimal number in `s` to a bignum
/// @param size bignum size (bytes)
Uint8List signedDecimalToBinary(int size, String s) {
  var negative = s[0] == '-';
  if (negative) {
    s = s.substring(1);
  }
  var result = decimalToBinary(size, s);
  if (negative) {
    negate(result);
    if (!isNegative(result)) {
      throw 'number is out of range';
    }
  } else if (isNegative(result)) {
    throw 'number is out of range';
  }
  return result;
}

/// Convert `bignum` to an unsigned decimal number
/// @param minDigits 0-pad result to this many digits
String binaryToDecimal(Uint8List bignum, {minDigits = 1}) {
  var result = List.filled(minDigits, '0'.codeUnitAt(0));
  for (var i = bignum.length - 1; i >= 0; --i) {
    var carry = bignum[i];
    for (var j = 0; j < result.length; ++j) {
      var x = ((result[j] - '0'.codeUnitAt(0)) << 8) + carry;
      result[j] = '0'.codeUnitAt(0) + x % 10;
      carry = (x ~/ 10) | 0;
    }
    while (carry != 0) {
      result.add('0'.codeUnitAt(0) + carry % 10);
      carry = (carry ~/ 10) | 0;
    }
  }
  return String.fromCharCodes(result.reversed.toList());
}

/// Convert `bignum` to a signed decimal number
/// @param minDigits 0-pad result to this many digits
String signedBinaryToDecimal(Uint8List bignum, {int minDigits = 1}) {
  if (isNegative(bignum)) {
    var x = bignum.getRange(0, 0) as Uint8List;
    negate(x);
    return '-' + binaryToDecimal(x, minDigits: minDigits);
  }
  return binaryToDecimal(bignum, minDigits: minDigits);
}

/// Convert an unsigned base-58 number in `s` to a bignum
/// @param size bignum size (bytes)
Uint8List base58ToBinary(int size, String s) {
  var result = new Uint8List(size);
  for (var i = 0; i < s.length; ++i) {
    var carry = base58Map[s.codeUnitAt(i)];
    if (carry < 0) {
      throw 'invalid base-58 value';
    }
    for (var j = 0; j < size; ++j) {
      var x = result[j] * 58 + carry;
      result[j] = x;
      carry = x >> 8;
    }
    if (carry != 0) {
      throw 'base-58 value is out of range';
    }
  }
  return Uint8List.fromList(result.reversed.toList());
}

/// Convert `bignum` to a base-58 number
/// @param minDigits 0-pad result to this many digits
String binaryToBase58(Uint8List bignum, {minDigits = 1}) {
  var result = List<int>();
  for (var byte in bignum) {
    var carry = byte;
    for (var j = 0; j < result.length; ++j) {
      var x = (base58Map[result[j]] << 8) + carry;
      result[j] = base58Chars.codeUnitAt(x % 58);
      carry = (x ~/ 58) | 0;
    }
    while (carry != 0) {
      result.add(base58Chars.codeUnitAt(carry % 58));
      carry = (carry ~/ 58) | 0;
    }
  }
  for (var byte in bignum) {
    if (byte != 0) {
      break;
    } else {
      result.add('1'.codeUnitAt(0));
    }
  }
  return String.fromCharCodes(result.reversed.toList());
}

/// Convert an unsigned base-64 number in `s` to a bignum
Uint8List base64ToBinary(String s) {
  var len = s.length;
  if ((len & 3) == 1 && s[len - 1] == '=') {
    len -= 1;
  } // fc appends an extra '='
  if ((len & 3) != 0) {
    throw 'base-64 value is not padded correctly';
  }
  var groups = len >> 2;
  var bytes = groups * 3;
  if (len > 0 && s[len - 1] == '=') {
    if (s[len - 2] == '=') {
      bytes -= 2;
    } else {
      bytes -= 1;
    }
  }
  var result = new Uint8List(bytes);

  for (var group = 0; group < groups; ++group) {
    var digit0 = base64Map[s.codeUnitAt(group * 4 + 0)];
    var digit1 = base64Map[s.codeUnitAt(group * 4 + 1)];
    var digit2 = base64Map[s.codeUnitAt(group * 4 + 2)];
    var digit3 = base64Map[s.codeUnitAt(group * 4 + 3)];
    result[group * 3 + 0] = (digit0 << 2) | (digit1 >> 4);
    if (group * 3 + 1 < bytes) {
      result[group * 3 + 1] = ((digit1 & 15) << 4) | (digit2 >> 2);
    }
    if (group * 3 + 2 < bytes) {
      result[group * 3 + 2] = ((digit2 & 3) << 6) | digit3;
    }
  }
  return result;
}

