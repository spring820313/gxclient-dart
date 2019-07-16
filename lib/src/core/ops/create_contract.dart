import '../operations.dart';
import '../encoder.dart';
import 'optype.dart';
import '../../models/models.dart';
import '../../core/core.dart';

class CreateContractOperation extends Operation {
  AssetAmount fee;
  String name;
  GrapheneId account;
  String vmType;
  String vmVersion;
  String code;
  Abi abi;
  List<dynamic> extensions;

  CreateContractOperation(this.account, this.name, this.vmType, this.vmVersion, this.code, this.abi, this.fee);

  @override
  OpType opType() {
    return OpType.CreateContractOpType;
  }

  @override
  bool serialize(Encoder encoder) {
    encoder.encodeVarint(opType().index);
    this.fee.serialize(encoder);
    encoder.encodeString(this.name);
    this.account.serialize(encoder);
    encoder.encodeString(this.vmType);
    encoder.encodeString(this.vmVersion);
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
      'name': this.name,
      'account': this.account.toJson(),
      'vm_type':   this.vmType,
      'vm_version': this.vmVersion,
      'code': this.code,
      'abi': this.abi.toJson(),
      'fee': this.fee.toJson(),
      'extensions' : [],
    };

    return val;
  }
}