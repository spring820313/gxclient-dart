import '../core/encoder.dart';

class TableRowsParams {
  int lowerBound;
  int upperBound;
  int indexPosition;
  int limit;
  bool reverse;

  TableRowsParams(this.lowerBound, this.upperBound, this.indexPosition, this.limit, this.reverse);

  TableRowsParams.Default() : this(0, -1, 1, 10, false );

  factory TableRowsParams.fromJson(dynamic json) {
    if (!(json is Map)) {
      return null;
    }

    int lowerBound = json['lower_bound'];
    int upperBound = json['upper_bound'];
    int indexPosition = json['index_position'];
    int limit = json['limit'];
    bool reverse = json['reverse'] as bool;
    return TableRowsParams(lowerBound, upperBound, indexPosition, limit, reverse);
  }

  @override
  bool serialize(Encoder encoder)  {
    return true;
  }

  @override
  dynamic toJson() {
    final val = <String, dynamic>{
      'lower_bound': this.lowerBound,
      'upper_bound' : this.upperBound,
      'index_position': this.indexPosition,
      'limit' : this.limit,
      'reverse' : this.reverse,
    };

    return val;
  }
}