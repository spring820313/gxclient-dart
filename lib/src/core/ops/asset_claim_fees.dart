import '../operations.dart';
import '../encoder.dart';
import 'optype.dart';
import '../../models/models.dart';
import '../../core/core.dart';

class AssetClaimFeesOperation extends Operation {
  AssetAmount fee;
  GrapheneId issuer;
  AssetAmount amountToClaim;
  List<dynamic> extensions;

  AssetClaimFeesOperation(this.issuer, this.amountToClaim, this.fee);

  @override
  OpType opType() {
    return OpType.AssetClaimFeesOpType;
  }

  @override
  bool serialize(Encoder encoder) {
    encoder.encodeVarint(opType().index);
    this.fee.serialize(encoder);
    this.issuer.serialize(encoder);
    this.amountToClaim.serialize(encoder);

    //Extensions
    encoder.encodeVarint(0);

    return true;
  }

  @override
  dynamic toJson() {
    final val = <String, dynamic>{
      'issuer': this.issuer.toJson(),
      'amount_to_claim': this.amountToClaim.toJson(),
      'fee': this.fee.toJson(),
      'extensions' : [],
    };

    return val;
  }
}