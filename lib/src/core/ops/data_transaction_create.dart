import '../operations.dart';
import '../encoder.dart';
import 'optype.dart';
import '../../models/models.dart';

class DataTransactionCreateOperation extends Operation {
  String requestId;
  GrapheneId productId;
  String version;
  String params;
  AssetAmount fee;
  GrapheneId requester;
  Time createDateTime;
  GrapheneId leagueId;
  List<dynamic> extensions;

  DataTransactionCreateOperation(this.requestId, this.productId, this.version, this.fee,
      this.params, this.requester, this.createDateTime, [this.leagueId]);

  @override
  OpType opType() {
    return OpType.DataTransactionCreateOpType;
  }

  @override
  bool serialize(Encoder encoder) {
    encoder.encodeVarint(opType().index);
    encoder.encodeString(this.requestId);
    this.productId.serialize(encoder);
    encoder.encodeString(this.version);
    encoder.encodeString(this.params);
    this.fee.serialize(encoder);
    this.requester.serialize(encoder);
    this.createDateTime.serialize(encoder);
    encoder.encodeBool(this.leagueId != null);
    if(this.leagueId != null)
      this.leagueId.serialize(encoder);

    //Extensions
    encoder.encodeVarint(0);

    return true;
  }

  @override
  dynamic toJson() {
    final val = <String, dynamic>{
      'request_id': this.requestId,
      'product_id':   this.productId.toJson(),
      'version': this.version,
      'params': this.params,
      'fee': this.fee.toJson(),
      'requester':   this.requester.toJson(),
      'create_date_time': this.createDateTime.dt.toIso8601String().substring(0, this.createDateTime.dt.toIso8601String().length - 5),
      'extensions' : [],
    };

    if(this.leagueId != null) {
      val['league_id'] = this.leagueId.toJson();
    }
    return val;
  }
}