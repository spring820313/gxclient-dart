import '../operations.dart';
import '../encoder.dart';
import 'optype.dart';
import '../../models/models.dart';

class CallContractOperation extends Operation {
  AssetAmount fee;
  GrapheneId account;
  GrapheneId contractId;
  AssetAmount amount;
  String methodName;
  String data;
  List<dynamic> extensions;

  CallContractOperation(this.account, this.contractId, this.amount, this.fee, this.methodName, this.data);

  @override
  OpType opType() {
    return OpType.CallContractOpType;
  }

  @override
  bool serialize(Encoder encoder) {
    encoder.encodeVarint(opType().index);
    this.fee.serialize(encoder);
    this.account.serialize(encoder);
    this.contractId.serialize(encoder);
    encoder.encodeBool(this.amount != null);
    if(this.amount != null)
      this.amount.serialize(encoder);

    encoder.encodeName(this.methodName);
    encoder.encodeString(this.data);

    //Extensions
    encoder.encodeVarint(0);

    return true;
  }

  @override
  dynamic toJson() {
    final val = <String, dynamic>{
      'account': this.account.toJson(),
      'contract_id':   this.contractId.toJson(),
      'method_name': this.methodName,
      'data': this.data,
      'fee': this.fee.toJson(),
      'extensions' : [],
    };

    if(this.amount != null) {
      val['amount'] = this.amount.toJson();
    }
    return val;
  }
}