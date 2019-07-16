import 'optype.dart';
import '../operations.dart';
import '../encoder.dart';
import '../../models/models.dart';

class FbaDistributeOperation extends Operation {
  AssetAmount fee;
  List<dynamic> extensions;

  FbaDistributeOperation(this.fee);

  @override
  OpType opType() {
    return OpType.FbaDistributeOperationOpType;
  }

  @override
  bool serialize(Encoder encoder) {
    encoder.encodeVarint(opType().index);
    this.fee.serialize(encoder);
    encoder.encodeVarint(0);

    return true;
  }

  @override
  dynamic toJson() {
    final val = <String, dynamic>{
      'fee': this.fee.toJson(),
      'extensions' : [],
    };

    return val;
  }
}