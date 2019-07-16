import '../operations.dart';
import '../encoder.dart';
import 'optype.dart';
import '../../models/models.dart';

class AccountCreateOperation extends Operation {
  AssetAmount fee;
  GrapheneId registrar;
  GrapheneId referrer;
  int referrerPercent;
  Authority owner;
  Authority active;
  String name;
  AccountOptions options;
  List<dynamic> extensions;

  AccountCreateOperation(this.registrar, this.referrer, this.referrerPercent,
      this.owner, this.active, this.name, this.options, this.fee);

  @override
  OpType opType() {
    return OpType.AccountCreateOpType;
  }

  @override
  bool serialize(Encoder encoder) {
    encoder.encodeVarint(opType().index);
    this.fee.serialize(encoder);
    this.registrar.serialize(encoder);
    this.referrer.serialize(encoder);
    encoder.encodeUint16(this.referrerPercent);
    this.owner.serialize(encoder);
    this.active.serialize(encoder);
    encoder.encodeString(this.name);
    this.options.serialize(encoder);

    //Extensions
    encoder.encodeVarint(0);

    return true;
  }

  @override
  dynamic toJson() {
    final val = <String, dynamic>{
      'registrar': this.registrar.toJson(),
      'referrer': this.referrer.toJson(),
      'fee': this.fee.toJson(),
      'referrer_percent': this.referrerPercent,
      'owner':   this.owner.toJson(),
      'active': this.active.toJson(),
      'name': this.name,
      'options': this.options.toJson(),
      'extensions' : [],
    };

    return val;
  }
}