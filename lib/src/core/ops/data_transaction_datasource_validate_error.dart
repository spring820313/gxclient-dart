import '../operations.dart';
import '../encoder.dart';
import 'optype.dart';
import '../../models/models.dart';

class DataTransactionDatasourceValidateErrorOperation extends Operation {
  String requestId;
  GrapheneId datasource;
  AssetAmount fee;
  List<dynamic> extensions;

  DataTransactionDatasourceValidateErrorOperation(this.requestId, this.fee, this.datasource);

  @override
  OpType opType() {
    return OpType.DataTransactionDatasourceValidateErrorOpType;
  }

  @override
  bool serialize(Encoder encoder) {
    encoder.encodeVarint(opType().index);
    encoder.encodeString(this.requestId);
    this.datasource.serialize(encoder);
    this.fee.serialize(encoder);

    //Extensions
    encoder.encodeVarint(0);

    return true;
  }

  @override
  dynamic toJson() {
    final val = <String, dynamic>{
      'request_id': this.requestId,
      'fee': this.fee.toJson(),
      'datasource': this.datasource.toJson(),
      'extensions' : [],
    };

    return val;
  }
}