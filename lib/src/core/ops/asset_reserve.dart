import 'optype.dart';
import '../operations.dart';
import '../encoder.dart';
import '../../models/models.dart';

class AssetReserveOperation extends Operation {
  AssetAmount fee;
  GrapheneId payer;
  AssetAmount amountToReserve;
  List<dynamic> extensions;

  AssetReserveOperation(this.payer, this.amountToReserve,
      this.fee);

  @override
  OpType opType() {
    return OpType.AssetReserveOpType;
  }

  @override
  bool serialize(Encoder encoder) {
    encoder.encodeVarint(opType().index);
    this.fee.serialize(encoder);
    this.payer.serialize(encoder);
    this.amountToReserve.serialize(encoder);

    //Extensions
    encoder.encodeVarint(0);

    return true;
  }

  @override
  dynamic toJson() {
    final val = <String, dynamic>{
      'payer': this.payer.toJson(),
      'amount_to_reserve': this.amountToReserve.toJson(),
      'fee': this.fee.toJson(),
      'extensions' : [],
    };

    return val;
  }
}