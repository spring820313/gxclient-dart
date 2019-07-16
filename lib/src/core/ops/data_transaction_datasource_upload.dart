import '../operations.dart';
import '../encoder.dart';
import 'optype.dart';
import '../../models/models.dart';

class DataTransactionDatasourceUploadOperation extends Operation {
  String requestId;
  GrapheneId requester;
  GrapheneId datasource;
  AssetAmount fee;
  List<dynamic> extensions;

  DataTransactionDatasourceUploadOperation(this.requestId, this.fee, this.requester, this.datasource);

  @override
  OpType opType() {
    return OpType.DataTransactionDatasourceUploadOpType;
  }

  @override
  bool serialize(Encoder encoder) {
    encoder.encodeVarint(opType().index);
    encoder.encodeString(this.requestId);
    this.requester.serialize(encoder);
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
      'requester':   this.requester.toJson(),
      'datasource': this.datasource.toJson(),
      'extensions' : [],
    };

    return val;
  }
}