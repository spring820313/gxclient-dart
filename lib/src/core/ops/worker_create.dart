import 'optype.dart';
import '../operations.dart';
import '../encoder.dart';
import '../../models/models.dart';
import '../../core/core.dart';

class WorkerCreateOperation extends Operation {
  AssetAmount fee;
  GrapheneId owner;
  Time workBeginDate;
  Time workEndDate;
  int dailyPay;
  String name;
  String url;
  WorkerInitializer initializer;

  WorkerCreateOperation(this.owner, this.workBeginDate, this.workEndDate,
      this.dailyPay, this.name, this.url, this.initializer, this.fee);

  @override
  OpType opType() {
    return OpType.WorkerCreateOpType;
  }

  @override
  bool serialize(Encoder encoder) {
    encoder.encodeVarint(opType().index);
    this.fee.serialize(encoder);
    this.owner.serialize(encoder);
    this.workBeginDate.serialize(encoder);
    this.workEndDate.serialize(encoder);
    encoder.encodeUint64(this.dailyPay);
    encoder.encodeString(this.name);
    encoder.encodeString(this.url);
    this.initializer.serialize(encoder);

    return true;
  }

  @override
  dynamic toJson() {
    final val = <String, dynamic>{
      'owner': this.owner.toJson(),
      'work_begin_date': this.workBeginDate.toJson(),
      'work_end_date': this.workEndDate.toJson(),
      'daily_pay': this.dailyPay,
      'name': this.name,
      'url': this.url,
      'initializer': this.initializer.toJson(),
      'fee': this.fee.toJson(),
    };

    return val;
  }
}