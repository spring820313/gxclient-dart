import '../operations.dart';
import '../encoder.dart';
import 'optype.dart';
import '../../models/models.dart';
import '../../core/core.dart';

class UpdateContractOperation extends Operation {
  AssetAmount fee;
  GrapheneId owner;
  GrapheneId newOwner;
  GrapheneId contract;
  String code;
  Abi abi;
  List<dynamic> extensions;

  UpdateContractOperation(this.owner, this.newOwner, this.contract, this.code, this.abi, this.fee);

  @override
  OpType opType() {
    return OpType.UpdateContractOpType;
  }

  @override
  bool serialize(Encoder encoder) {
    encoder.encodeVarint(opType().index);
    this.fee.serialize(encoder);
    this.owner.serialize(encoder);
    encoder.encodeBool(this.newOwner != null);
    if(this.newOwner != null)
      this.newOwner.serialize(encoder);
    this.contract.serialize(encoder);
    final codeBytes = hexToBytes(this.code);
    encoder.encodeVarint(codeBytes.length);
    encoder.encodeBytes(codeBytes);
    this.abi.serialize(encoder);

    //Extensions
    encoder.encodeVarint(0);

    return true;
  }

  @override
  dynamic toJson() {
    final val = <String, dynamic>{
      'owner': this.owner.toJson(),
      'contract': this.contract.toJson(),
      'code': this.code,
      'abi': this.abi.toJson(),
      'fee': this.fee.toJson(),
      'extensions' : [],
    };

    if(this.newOwner != null) {
      val['new_owner'] = this.newOwner.toJson();
    }

    return val;
  }
}