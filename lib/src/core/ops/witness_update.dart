import 'optype.dart';
import '../operations.dart';
import '../encoder.dart';
import '../../models/models.dart';
import '../../core/core.dart';

class WitnessUpdateOperation extends Operation {
  AssetAmount fee;
  GrapheneId witness;
  GrapheneId witnessAccount;
  String newURL;
  String newSigningKey;

  WitnessUpdateOperation(this.witnessAccount, this.witness, this.fee, [this.newURL, this.newSigningKey]);

  @override
  OpType opType() {
    return OpType.WitnessUpdateOpType;
  }

  @override
  bool serialize(Encoder encoder) {
    encoder.encodeVarint(opType().index);
    this.fee.serialize(encoder);
    this.witness.serialize(encoder);
    this.witnessAccount.serialize(encoder);
    encoder.encodeBool(this.newURL != null);
    if(this.newURL != null)
      encoder.encodeString(this.newURL);
    encoder.encodeBool(this.newSigningKey != null);
    if(this.newSigningKey != null)
      encoder.encodePubKey(this.newSigningKey);

    return true;
  }

  @override
  dynamic toJson() {
    final val = <String, dynamic>{
      'witness': this.witness.toJson(),
      'witness_account': this.witnessAccount.toJson(),
      'fee': this.fee.toJson(),
    };

    if(this.newURL != null) {
      val['new_url'] = this.newURL;
    }

    if(this.newSigningKey != null) {
      val['new_signing_key'] = this.newSigningKey;
    }

    return val;
  }
}