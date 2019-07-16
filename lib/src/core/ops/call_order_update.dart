import 'optype.dart';
import '../operations.dart';
import '../encoder.dart';
import '../../models/models.dart';

class CallOrderUpdateOperation extends Operation {
  AssetAmount fee;
  GrapheneId fundingAccount;
  AssetAmount deltaCollateral;
  AssetAmount deltaDebt;
  List<dynamic> extensions;

  CallOrderUpdateOperation(this.fundingAccount, this.deltaCollateral, this.deltaDebt, this.fee);

  @override
  OpType opType() {
    return OpType.CallOrderUpdateOpType;
  }

  @override
  bool serialize(Encoder encoder) {
    encoder.encodeVarint(opType().index);
    this.fee.serialize(encoder);
    this.fundingAccount.serialize(encoder);
    this.deltaCollateral.serialize(encoder);
    this.deltaDebt.serialize(encoder);

    //Extensions
    encoder.encodeVarint(0);

    return true;
  }

  @override
  dynamic toJson() {
    final val = <String, dynamic>{
      'funding_account': this.fundingAccount.toJson(),
      'delta_collateral': this.deltaCollateral.toJson(),
      'delta_debt': this.deltaDebt.toJson(),
      'fee': this.fee.toJson(),
      'extensions' : [],
    };

    return val;
  }
}