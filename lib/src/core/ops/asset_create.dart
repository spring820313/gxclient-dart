import 'optype.dart';
import '../operations.dart';
import '../encoder.dart';
import '../../models/models.dart';

class AssetCreateOperation extends Operation {
  AssetAmount fee;
  GrapheneId issuer;
  String symbol;
  int precision;
  AssetOptions commonOptions;
  BitassetOptions bitassetOptions;
  bool isPredictionMarket;
  List<dynamic> extensions;

  AssetCreateOperation(this.issuer, this.symbol, this.precision,
      this.commonOptions, this.isPredictionMarket, this.fee, [this.bitassetOptions]);

  @override
  OpType opType() {
    return OpType.AssetCreateOpType;
  }

  @override
  bool serialize(Encoder encoder) {
    encoder.encodeVarint(opType().index);
    this.fee.serialize(encoder);
    this.issuer.serialize(encoder);
    encoder.encodeString(this.symbol);
    encoder.encodeUint8(this.precision);
    this.commonOptions.serialize(encoder);
    encoder.encodeBool(this.bitassetOptions != null);
    if(this.bitassetOptions != null) {
      this.bitassetOptions.serialize(encoder);
    }
    encoder.encodeBool(this.isPredictionMarket);

    //Extensions
    encoder.encodeVarint(0);

    return true;
  }

  @override
  dynamic toJson() {
    final val = <String, dynamic>{
      'issuer': this.issuer.toJson(),
      'symbol': this.symbol,
      'precision': this.precision,
      'common_options': this.commonOptions.toJson(),
      'is_prediction_market': this.isPredictionMarket,
      'fee': this.fee.toJson(),
      'extensions' : [],
    };

    if(this.bitassetOptions != null) {
      val['bitasset_opts'] = this.bitassetOptions.toJson();
    }

    return val;
  }
}