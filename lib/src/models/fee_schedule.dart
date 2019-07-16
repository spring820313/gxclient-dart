import '../core/core.dart';
import 'fee_parameters.dart';

class FeeSchedule extends Serializable{
  List<FeeParameters> parameters;
  int scale;

  FeeSchedule(this.parameters, this.scale);

  factory FeeSchedule.fromJson(dynamic json) {
    if(!(json is Map)) {
      return null;
    }

    final parameters = FeeParameters.toList(json['parameters']);
    int scale = json['scale'];
    return FeeSchedule(parameters, scale);
  }

  @override
  bool serialize(Encoder encoder)  {
    encoder.encodeVarint(this.parameters.length);
    for(var p in this.parameters) {
      p.serialize(encoder);
    }
    encoder.encodeUint32(this.scale);
    return true;
  }

  @override
  dynamic toJson() {
    final val = <String, dynamic>{
      'parameters': fromList(this.parameters),
      'scale': this.scale,
    };

    return val;
  }
}