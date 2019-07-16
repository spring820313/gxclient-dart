import '../operations.dart';
import '../encoder.dart';
import 'optype.dart';
import '../../models/models.dart';

class DataTransactionUpdateOperation extends Operation {
  String requestId;
  int newStatus;
  AssetAmount fee;
  GrapheneId newRequester;
  String memo;
  List<dynamic> extensions;

  DataTransactionUpdateOperation(this.requestId, this.fee, this.newStatus, this.newRequester, this.memo);

  @override
  OpType opType() {
    return OpType.DataTransactionUpdateOpType;
  }

  @override
  bool serialize(Encoder encoder) {
    encoder.encodeVarint(opType().index);
    encoder.encodeString(this.requestId);
    encoder.encodeUint8(this.newStatus);
    this.fee.serialize(encoder);
    this.newRequester.serialize(encoder);
    encoder.encodeString(this.memo);

    //Extensions
    encoder.encodeVarint(0);

    return true;
  }

  @override
  dynamic toJson() {
    final val = <String, dynamic>{
      'request_id': this.requestId,
      'fee': this.fee.toJson(),
      'new_status':   this.newStatus,
      'new_requester': this.newRequester.toJson(),
      'memo':   this.memo,
      'extensions' : [],
    };

    return val;
  }
}