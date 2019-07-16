import 'optype.dart';
import '../operations.dart';
import '../encoder.dart';
import '../../models/models.dart';

class BalanceLockOperation extends Operation {
  AssetAmount fee;
  GrapheneId account;
  Time createDateTime;
  String programId;
  AssetAmount amount;
  int lockDays;
  int interestRate;
  Memo memo;
  List<dynamic> extensions;

  BalanceLockOperation(this.account, this.createDateTime, this.programId, this.amount,
      this.lockDays, this.interestRate, this.memo, this.fee);

  @override
  OpType opType() {
    return OpType.BalanceLockOpType;
  }

  @override
  bool serialize(Encoder encoder) {
    encoder.encodeVarint(opType().index);
    this.fee.serialize(encoder);
    this.account.serialize(encoder);
    this.createDateTime.serialize(encoder);
    encoder.encodeString(this.programId);
    this.amount.serialize(encoder);
    encoder.encodeUint32(this.lockDays);
    encoder.encodeUint32(this.interestRate);
    this.memo.serialize(encoder);

    //Extensions
    encoder.encodeVarint(0);

    return true;
  }

  @override
  dynamic toJson() {
    final val = <String, dynamic>{
      'account': this.account.toJson(),
      'create_date_time': this.createDateTime.toJson(),
      'program_id': this.programId,
      'amount': this.amount.toJson(),
      'lock_days': this.lockDays,
      'interest_rate': this.interestRate,
      'memo': this.memo.toJson(),
      'fee': this.fee.toJson(),
      'extensions' : [],
    };

    return val;
  }
}