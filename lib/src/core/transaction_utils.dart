import 'formatting.dart';
import 'utils.dart';

class TransactionUtils {
  static int refBlockNum(int blockNumber) {
    final low =  (blockNumber >> 0) & 0xff;
    final hi =   (blockNumber >> 8) & 0xff;

    var v = 0;
    v |= low << 0;
    v |= hi << 8;

    return v;
  }

  static int refBlockPrefix(String blockID) {
    final bytes = hexToBytes(blockID);
    if(bytes.length < 8) {
      throw 'Bad parameter';
    }
    final rawPrefix = bytes.sublist(4, 8);
    return bytesToUintLE(rawPrefix, 4);
  }

}