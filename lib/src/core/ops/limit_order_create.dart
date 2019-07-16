import 'optype.dart';
import '../operations.dart';
import '../encoder.dart';
import '../../models/models.dart';

class LimitOrderCreateOperation extends Operation {
  AssetAmount fee;
  GrapheneId seller;
  AssetAmount amountToSell;
  AssetAmount minToReceive;
  Time expiration;
  bool fillOrKill;
  List<dynamic> extensions;

  LimitOrderCreateOperation(this.seller, this.amountToSell, this.minToReceive,
      this.expiration, this.fillOrKill, this.fee);

  @override
  OpType opType() {
    return OpType.LimitOrderCreateOpType;
  }

  @override
  bool serialize(Encoder encoder) {
    encoder.encodeVarint(opType().index);
    this.fee.serialize(encoder);
    this.seller.serialize(encoder);
    this.amountToSell.serialize(encoder);
    this.minToReceive.serialize(encoder);
    this.expiration.serialize(encoder);
    encoder.encodeBool(this.fillOrKill);
    encoder.encodeVarint(0);

    return true;
  }

  @override
  dynamic toJson() {
    final val = <String, dynamic>{
      'seller': this.seller.toJson(),
      'amount_to_sell': this.amountToSell.toJson(),
      'min_to_receive': this.minToReceive.toJson(),
      'expiration': this.expiration.toJson(),
      'fill_or_kill': this.fillOrKill,
      'fee': this.fee.toJson(),
      'extensions' : [],
    };

    return val;
  }
}