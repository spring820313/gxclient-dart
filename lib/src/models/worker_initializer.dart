import '../core/core.dart';
import 'types.dart';

class RefundWorkerInitializer extends Serializable{

  RefundWorkerInitializer();

  factory RefundWorkerInitializer.fromJson(dynamic json) {
    if (!(json is Map)) {
      return null;
    }
    return RefundWorkerInitializer();
  }

  @override
  bool serialize(Encoder encoder)  {
    encoder.encodeUint8(WorkerInitializerType.WorkerInitializerTypeRefund.index);
    return true;
  }

  @override
  dynamic toJson() {
    final val = <String, dynamic>{
    };

    return val;
  }
}

class VestingBalanceWorkerInitializer extends Serializable{
  int payVestingPeriodDays;

  VestingBalanceWorkerInitializer(this.payVestingPeriodDays);

  factory VestingBalanceWorkerInitializer.fromJson(dynamic json) {
    if (!(json is Map)) {
      return null;
    }

    int payVestingPeriodDays = json['pay_vesting_period_days'];
    return VestingBalanceWorkerInitializer(payVestingPeriodDays);
  }

  @override
  bool serialize(Encoder encoder)  {
    encoder.encodeUint8(WorkerInitializerType.WorkerInitializerTypeRefund.index);
    encoder.encodeUint16(this.payVestingPeriodDays);
    return true;
  }

  @override
  dynamic toJson() {
    final val = <String, dynamic>{
      'pay_vesting_period_days': this.payVestingPeriodDays,
    };

    return val;
  }
}

class BurnWorkerInitializer extends Serializable{

  BurnWorkerInitializer();

  factory BurnWorkerInitializer.fromJson(dynamic json) {
    if (!(json is Map)) {
      return null;
    }
    return BurnWorkerInitializer();
  }

  @override
  bool serialize(Encoder encoder)  {
    encoder.encodeUint8(WorkerInitializerType.WorkerInitializerTypeBurn.index);
    return true;
  }

  @override
  dynamic toJson() {
    final val = <String, dynamic>{
    };

    return val;
  }
}

class WorkerInitializer extends Serializable{
  WorkerInitializerType type;
  dynamic initializer;

  WorkerInitializer(this.type, this.initializer);

  static List<WorkerInitializer> toList(dynamic json) {
    List<WorkerInitializer> fields = List();
    if(json != null) {
      final ts = json as List<dynamic>;
      for(final d in ts) {
        final f = WorkerInitializer.fromJson(d);
        fields.add(f);
      }
    }
    return fields;
  }

  factory WorkerInitializer.fromJson(dynamic json) {
    if(!(json is List)) {
      return null;
    }

    final lst = json as List;
    if(lst.length != 2) {
      return null;
    }

    return WorkerInitializer(WorkerInitializerType.values[lst[0] as int], lst[1]);
  }

  @override
  bool serialize(Encoder encoder)  {
    //encoder.encodeUint8(this.type.index);
    switch(this.type) {
      case WorkerInitializerType.WorkerInitializerTypeRefund:
        final refundWorkerInitializer = this.initializer as RefundWorkerInitializer;
        refundWorkerInitializer.serialize(encoder);
        break;
      case WorkerInitializerType.WorkerInitializerTypeVestingBalance:
        final vestingBalanceWorkerInitializer = this.initializer as VestingBalanceWorkerInitializer;
        vestingBalanceWorkerInitializer.serialize(encoder);
        break;
      case WorkerInitializerType.WorkerInitializerTypeBurn:
        final burnWorkerInitializer = this.initializer as BurnWorkerInitializer;
        burnWorkerInitializer.serialize(encoder);
        break;
    }
  }

  @override
  dynamic toJson() {
    return List<dynamic>.from([type.index, initializer]);
  }
}
