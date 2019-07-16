import 'optype.dart';
import '../operations.dart';
import '../encoder.dart';
import '../../models/models.dart';

class CommitteeMemberUpdateGlobalParametersOperation extends Operation {
  AssetAmount fee;
  ChainParameters newParameters;

  CommitteeMemberUpdateGlobalParametersOperation(this.newParameters, this.fee);

  @override
  OpType opType() {
    return OpType.CommitteeMemberUpdateGlobalParametersOpType;
  }

  @override
  bool serialize(Encoder encoder) {
    encoder.encodeVarint(opType().index);
    this.fee.serialize(encoder);
    this.newParameters.serialize(encoder);

    return true;
  }

  @override
  dynamic toJson() {
    final val = <String, dynamic>{
      'new_parameters': this.newParameters.toJson(),
      'fee': this.fee.toJson(),
    };

    return val;
  }
}