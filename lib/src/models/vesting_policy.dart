import '../core/core.dart';
import 'types.dart';
import 'time.dart';

class CCDVestingPolicy extends Serializable{
  Time startClaim;
  Time coinSecondsEarnedLastUpdate;
  int vestingSeconds;
  int coinSecondsEarned;

  CCDVestingPolicy(this.startClaim, this.coinSecondsEarnedLastUpdate, this.vestingSeconds, this.coinSecondsEarned);

  factory CCDVestingPolicy.fromJson(dynamic json) {
    if (!(json is Map)) {
      return null;
    }
    final startClaim = Time.fromJson(json['pay_vesting_period_days']);
    final coinSecondsEarnedLastUpdate = Time.fromJson(json['pay_vesting_period_days']);
    int vestingSeconds = json['vesting_seconds'];
    int coinSecondsEarned = json['coin_seconds_earned'];
    return CCDVestingPolicy(startClaim, coinSecondsEarnedLastUpdate, vestingSeconds, coinSecondsEarned);
  }

  @override
  bool serialize(Encoder encoder)  {
    this.startClaim.serialize(encoder);
    this.coinSecondsEarnedLastUpdate.serialize(encoder);
    encoder.encodeUint32(this.vestingSeconds);
    encoder.encodeUint64(this.coinSecondsEarned);
    return true;
  }

  @override
  dynamic toJson() {
    final val = <String, dynamic>{
      'start_claim': this.startClaim.toJson(),
      'coin_seconds_earned_last_update': this.coinSecondsEarnedLastUpdate.toJson(),
      'vesting_seconds': this.vestingSeconds,
      'coin_seconds_earned': this.coinSecondsEarned,
    };

    return val;
  }
}

class LinearVestingPolicy extends Serializable{
  Time beginTimestamp;
  int vestingCliffSeconds;
  int vestingDurationSeconds;

  LinearVestingPolicy(this.beginTimestamp, this.vestingCliffSeconds, this.vestingDurationSeconds);

  factory LinearVestingPolicy.fromJson(dynamic json) {
    if (!(json is Map)) {
      return null;
    }

    final beginTimestamp = Time.fromJson(json['begin_timestamp']);
    int vestingCliffSeconds = json['vesting_cliff_seconds'];
    int vestingDurationSeconds = json['vesting_duration_seconds'];
    return LinearVestingPolicy(beginTimestamp, vestingCliffSeconds, vestingDurationSeconds);
  }

  @override
  bool serialize(Encoder encoder)  {
    this.beginTimestamp.serialize(encoder);
    encoder.encodeUint32(this.vestingCliffSeconds);
    encoder.encodeUint32(this.vestingDurationSeconds);
    return true;
  }

  @override
  dynamic toJson() {
    final val = <String, dynamic>{
      'begin_timestamp': this.beginTimestamp.toJson(),
      'vesting_cliff_seconds': this.vestingCliffSeconds,
      'vesting_duration_seconds': this.vestingDurationSeconds,
    };

    return val;
  }
}

class VestingPolicy extends Serializable{
  VestingPolicyType type;
  dynamic data;

  VestingPolicy(this.type, this.data);

  static List<VestingPolicy> toList(dynamic json) {
    List<VestingPolicy> fields = List();
    if(json != null) {
      final ts = json as List<dynamic>;
      for(final d in ts) {
        final f = VestingPolicy.fromJson(d);
        fields.add(f);
      }
    }
    return fields;
  }

  factory VestingPolicy.fromJson(dynamic json) {
    if(!(json is List)) {
      return null;
    }

    final lst = json as List;
    if(lst.length != 2) {
      return null;
    }

    return VestingPolicy(VestingPolicyType.values[lst[0] as int], lst[1]);
  }

  @override
  bool serialize(Encoder encoder)  {
    encoder.encodeUint8(this.type.index);
    switch(this.type) {
      case VestingPolicyType.VestingPolicyTypeLinear:
        final linearVestingPolicy = this.data as LinearVestingPolicy;
        linearVestingPolicy.serialize(encoder);
        break;
      case VestingPolicyType.VestingPolicyTypeCCD:
        final ccdVestingPolicy = this.data as CCDVestingPolicy;
        ccdVestingPolicy.serialize(encoder);
        break;
    }
  }

  @override
  dynamic toJson() {
    return List<dynamic>.from([type.index, data]);
  }
}
