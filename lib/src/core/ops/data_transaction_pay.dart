import '../operations.dart';
import '../encoder.dart';
import 'optype.dart';
import '../../models/models.dart';

class DataTransactionPayOperation extends Operation {
  AssetAmount fee;
  GrapheneId from;
  GrapheneId to;
  AssetAmount amount;
  String requestId;
  List<dynamic> extensions;

  DataTransactionPayOperation(this.requestId, this.fee, this.from, this.to,
      this.amount);

  @override
  OpType opType() {
    return OpType.DataTransactionPayOpType;
  }

  @override
  bool serialize(Encoder encoder) {
    encoder.encodeVarint(opType().index);
    this.fee.serialize(encoder);
    this.from.serialize(encoder);
    this.to.serialize(encoder);
    this.amount.serialize(encoder);
    encoder.encodeString(this.requestId);

    //Extensions
    encoder.encodeVarint(0);

    return true;
  }

  @override
  dynamic toJson() {
    final val = <String, dynamic>{
      'request_id': this.requestId,
      'fee': this.fee.toJson(),
      'from':   this.from.toJson(),
      'to': this.to.toJson(),
      'amount': this.amount.toJson(),
      'extensions' : [],
    };

    return val;
  }
}