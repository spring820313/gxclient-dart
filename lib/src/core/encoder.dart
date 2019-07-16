import 'dart:typed_data';

import 'data_stream.dart';

class Encoder {
  DataStream dataStream;
  Encoder(this.dataStream) {

  }
  
  void encodeVarint(int i) {
    i > 0 ? dataStream.pushVaruint32(i) : dataStream.pushVarint32(i);
  }

  void encodeUint64(int i) {
    dataStream.pushUint64(i);
  }

  void encodeUint32(int i) {
    dataStream.pushUint32(i);
  }

  void encodeUint16(int i) {
    dataStream.pushUint16(i);
  }

  void encodeUint8(int i) {
    dataStream.push([(i >> 0) & 0xff]);
  }

  void encodeBool(bool b) {
    encodeUint8(b ? 1 : 0);
  }

  void encodeStringSlice(List<String> v) {
    encodeVarint(v.length);
    for(var s in v) {
      encodeString(s);
    }
  }

  void encodeString(String s) {
    //encodeVarint(s.length);
    dataStream.pushString(s);
  }

  void encodeBytes(List<int> v) {
    dataStream.writeBytes(v);
  }

  void encodePubKey(String pubkey) {
    dataStream.pushPublicKey(pubkey);
  }

  void encodeName(String name) {
    dataStream.pushName(name);
  }

  Uint8List asBytes() {
    return dataStream.asUint8List();
  }

}