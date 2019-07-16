import 'optype.dart';
import '../operations.dart';
import '../encoder.dart';
import '../../models/models.dart';

class InterContractCallOperation extends Operation {
  AssetAmount fee;
  GrapheneId senderContract;
  GrapheneId contractId;
  AssetAmount amount;
  String methodName;
  String data;
  List<dynamic> extensions;

  InterContractCallOperation(this.senderContract, this.contractId, this.amount,
      this.methodName, this.data, this.fee);

  @override
  OpType opType() {
    return OpType.InterContractCallOpType;
  }

  @override
  bool serialize(Encoder encoder) {
    encoder.encodeVarint(opType().index);
    this.fee.serialize(encoder);
    this.senderContract.serialize(encoder);
    this.contractId.serialize(encoder);
    this.amount.serialize(encoder);
    encoder.encodeString(this.methodName);
    encoder.encodeString(this.data);
    encoder.encodeVarint(0);

    return true;
  }

  @override
  dynamic toJson() {
    final val = <String, dynamic>{
      'sender_contract': this.senderContract.toJson(),
      'contract_id': this.contractId.toJson(),
      'amount': this.amount.toJson(),
      'method_name': this.methodName,
      'data': this.data,
      'fee': this.fee.toJson(),
      'extensions' : [],
    };

    return val;
  }
}