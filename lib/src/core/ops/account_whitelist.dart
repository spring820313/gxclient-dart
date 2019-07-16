import '../operations.dart';
import '../encoder.dart';
import 'optype.dart';
import '../../models/models.dart';

class AccountWhitelistOperation extends Operation {
  AssetAmount fee;
  GrapheneId accountToList;
  GrapheneId authorizingAccount;
  int newListing;
  List<dynamic> extensions;

  AccountWhitelistOperation(this.accountToList, this.authorizingAccount, this.newListing, this.fee);

  @override
  OpType opType() {
    return OpType.AccountWhitelistOpType;
  }

  @override
  bool serialize(Encoder encoder) {
    encoder.encodeVarint(opType().index);
    this.fee.serialize(encoder);
    this.accountToList.serialize(encoder);
    this.authorizingAccount.serialize(encoder);
    encoder.encodeUint8(this.newListing);

    //Extensions
    encoder.encodeVarint(0);

    return true;
  }

  @override
  dynamic toJson() {
    final val = <String, dynamic>{
      'account_to_list': this.accountToList.toJson(),
      'authorizing_account': this.authorizingAccount.toJson(),
      'new_listing': this.newListing,
      'fee': this.fee.toJson(),
      'extensions' : [],
    };

    return val;
  }
}