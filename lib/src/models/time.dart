import '../core/serialization.dart';
import '../core/encoder.dart';

class Time extends Serializable{
  final DateTime dt;

  Time(this.dt);

  factory Time.fromJson(dynamic json) {
    if(!(json is String)) {
      return null;
    }

    final jsonz = json + "Z";
    DateTime dt = DateTime.tryParse(jsonz);
    Time t = Time(dt);
    return t;
  }

  @override
  bool serialize(Encoder encoder)  {
    encoder.encodeUint32((this.dt.millisecondsSinceEpoch / 1000).round());
    return true;
  }

  @override
  dynamic toJson() {
    return this.dt.toIso8601String();
  }
}