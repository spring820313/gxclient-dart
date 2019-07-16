import 'optype.dart';
import '../operations.dart';
import '../encoder.dart';
import '../../models/models.dart';
import '../../core/core.dart';

class WitnessCreateOperation extends Operation {
  AssetAmount fee;
  GrapheneId witnessAccount;
  String url;
  String blockSigningKey;

  WitnessCreateOperation(this.witnessAccount, this.url, this.blockSigningKey, this.fee);

  @override
  OpType opType() {
    return OpType.WitnessCreateOpType;
  }

  @override
  bool serialize(Encoder encoder) {
    encoder.encodeVarint(opType().index);
    this.fee.serialize(encoder);
    this.witnessAccount.serialize(encoder);
    encoder.encodeString(this.url);
    encoder.encodePubKey(this.blockSigningKey);

    return true;
  }

  @override
  dynamic toJson() {
    final val = <String, dynamic>{
      'witness_account': this.witnessAccount.toJson(),
      'url': this.url,
      'block_signing_key': this.blockSigningKey,
      'fee': this.fee.toJson(),
    };

    return val;
  }
}