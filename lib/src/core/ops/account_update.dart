import '../operations.dart';
import '../encoder.dart';
import 'optype.dart';
import '../../models/models.dart';

class AccountUpdateOperation extends Operation {
  AssetAmount fee;
  GrapheneId account;
  Authority active;
  AccountOptions newOptions;
  Authority owner;
  List<AccountUpdateExtensions> extensions;

  AccountUpdateOperation(this.account, this.active, this.newOptions, this.owner, this.fee);

  @override
  OpType opType() {
    return OpType.AccountUpdateOpType;
  }

  @override
  bool serialize(Encoder encoder) {
    encoder.encodeVarint(opType().index);
    this.fee.serialize(encoder);
    this.account.serialize(encoder);
    encoder.encodeBool(this.owner != null);
    if(this.owner != null)
      this.owner.serialize(encoder);

    encoder.encodeBool(this.active != null);
    if(this.active != null)
      this.active.serialize(encoder);

    encoder.encodeBool(this.newOptions != null);
    if(this.newOptions != null)
      this.newOptions.serialize(encoder);

    //Extensions
    encoder.encodeVarint(0);

    return true;
  }

  @override
  dynamic toJson() {
    final val = <String, dynamic>{
      'account': this.account.toJson(),
      'fee': this.fee.toJson(),
      'extensions' : [],
    };

    if(this.owner != null) {
      val['owner'] = this.owner.toJson();
    }

    if(this.active != null) {
      val['active'] = this.active.toJson();
    }

    if(this.newOptions != null) {
      val['new_options'] = this.newOptions.toJson();
    }

    return val;
  }
}