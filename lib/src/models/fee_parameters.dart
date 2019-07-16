import '../core/core.dart';
import 'types.dart';

class TransferOperationFeeParameters extends Serializable{
  int fee;
  int pricePerKbyte;

  TransferOperationFeeParameters(this.fee, this.pricePerKbyte);

  factory TransferOperationFeeParameters.fromJson(dynamic json) {
    if (!(json is Map)) {
      return null;
    }

    int fee = json['fee'];
    int pricePerKbyte = json['price_per_kbyte'];
    return TransferOperationFeeParameters(fee, pricePerKbyte);
  }

  @override
  bool serialize(Encoder encoder)  {
    encoder.encodeUint8(FeeParametersType.FeeParametersTypeTransfer.index);
    encoder.encodeUint64(this.fee);
    encoder.encodeUint32(this.pricePerKbyte);
    return true;
  }

  @override
  dynamic toJson() {
    final val = <String, dynamic>{
      'fee': this.fee,
      'price_per_kbyte' : this.pricePerKbyte,
    };

    return val;
  }
}

class LimitOrderCreateOperationFeeParameters extends Serializable{
  int fee;

  LimitOrderCreateOperationFeeParameters(this.fee);

  factory LimitOrderCreateOperationFeeParameters.fromJson(dynamic json) {
    if (!(json is Map)) {
      return null;
    }

    int fee = json['fee'];
    return LimitOrderCreateOperationFeeParameters(fee);
  }

  @override
  bool serialize(Encoder encoder)  {
    encoder.encodeUint8(FeeParametersType.FeeParametersTypeLimitOrderCreate.index);
    encoder.encodeUint64(this.fee);
    return true;
  }

  @override
  dynamic toJson() {
    final val = <String, dynamic>{
      'fee': this.fee,
    };

    return val;
  }
}

class LimitOrderCancelOperationFeeParameters extends Serializable{
  int fee;

  LimitOrderCancelOperationFeeParameters(this.fee);

  factory LimitOrderCancelOperationFeeParameters.fromJson(dynamic json) {
    if (!(json is Map)) {
      return null;
    }

    int fee = json['fee'];
    return LimitOrderCancelOperationFeeParameters(fee);
  }

  @override
  bool serialize(Encoder encoder)  {
    encoder.encodeUint8(FeeParametersType.FeeParametersTypeLimitOrderCancel.index);
    encoder.encodeUint64(this.fee);
    return true;
  }

  @override
  dynamic toJson() {
    final val = <String, dynamic>{
      'fee': this.fee,
    };

    return val;
  }
}

class CallOrderUpdateOperationFeeParameters extends Serializable{
  int fee;

  CallOrderUpdateOperationFeeParameters(this.fee);

  factory CallOrderUpdateOperationFeeParameters.fromJson(dynamic json) {
    if (!(json is Map)) {
      return null;
    }

    int fee = json['fee'];
    return CallOrderUpdateOperationFeeParameters(fee);
  }

  @override
  bool serialize(Encoder encoder)  {
    encoder.encodeUint8(FeeParametersType.FeeParametersTypeCallOrderUpdate.index);
    encoder.encodeUint64(this.fee);
    return true;
  }

  @override
  dynamic toJson() {
    final val = <String, dynamic>{
      'fee': this.fee,
    };

    return val;
  }
}

class FillOrderOperationFeeParameters extends Serializable{

  FillOrderOperationFeeParameters();

  factory FillOrderOperationFeeParameters.fromJson(dynamic json) {
    if (!(json is Map)) {
      return null;
    }

    return FillOrderOperationFeeParameters();
  }

  @override
  bool serialize(Encoder encoder)  {
    encoder.encodeUint8(FeeParametersType.FeeParametersTypeFillOrder.index);
    return true;
  }

  @override
  dynamic toJson() {
    final val = <String, dynamic>{
    };

    return val;
  }
}

class AccountCreateOperationFeeParameters extends Serializable{
  int basicFee;
  int premiumFee;
  int pricePerKbyte;

  AccountCreateOperationFeeParameters(this.basicFee, this.premiumFee, this.pricePerKbyte);

  factory AccountCreateOperationFeeParameters.fromJson(dynamic json) {
    if (!(json is Map)) {
      return null;
    }

    int basicFee = json['basic_fee'];
    int premiumFee = json['premium_fee'];
    int pricePerKbyte = json['price_per_kbyte'];
    return AccountCreateOperationFeeParameters(basicFee, premiumFee, pricePerKbyte);
  }

  @override
  bool serialize(Encoder encoder)  {
    encoder.encodeUint8(FeeParametersType.FeeParametersTypeAccountCreate.index);
    encoder.encodeUint64(this.basicFee);
    encoder.encodeUint64(this.premiumFee);
    encoder.encodeUint32(this.pricePerKbyte);
    return true;
  }

  @override
  dynamic toJson() {
    final val = <String, dynamic>{
      'basic_fee': this.basicFee,
      'premium_fee': this.premiumFee,
      'price_per_kbyte' : this.pricePerKbyte,
    };

    return val;
  }
}

class AccountUpdateOperationFeeParameters extends Serializable{
  int fee;
  int pricePerKbyte;

  AccountUpdateOperationFeeParameters(this.fee, this.pricePerKbyte);

  factory AccountUpdateOperationFeeParameters.fromJson(dynamic json) {
    if (!(json is Map)) {
      return null;
    }

    int fee = json['fee'];
    int pricePerKbyte = json['price_per_kbyte'];
    return AccountUpdateOperationFeeParameters(fee, pricePerKbyte);
  }

  @override
  bool serialize(Encoder encoder)  {
    encoder.encodeUint8(FeeParametersType.FeeParametersTypeAccountUpdate.index);
    encoder.encodeUint64(this.fee);
    encoder.encodeUint32(this.pricePerKbyte);
    return true;
  }

  @override
  dynamic toJson() {
    final val = <String, dynamic>{
      'fee': this.fee,
      'price_per_kbyte' : this.pricePerKbyte,
    };

    return val;
  }
}

class AccountWhitelistOperationFeeParameters extends Serializable{
  int fee;

  AccountWhitelistOperationFeeParameters(this.fee);

  factory AccountWhitelistOperationFeeParameters.fromJson(dynamic json) {
    if (!(json is Map)) {
      return null;
    }

    int fee = json['fee'];
    return AccountWhitelistOperationFeeParameters(fee);
  }

  @override
  bool serialize(Encoder encoder)  {
    encoder.encodeUint8(FeeParametersType.FeeParametersTypeAccountWhitelist.index);
    encoder.encodeUint64(this.fee);
    return true;
  }

  @override
  dynamic toJson() {
    final val = <String, dynamic>{
      'fee': this.fee,
    };

    return val;
  }
}

class AccountUpgradeOperationFeeParameters extends Serializable{
  int membershipAnnualFee;
  int membershipLifetimeFee;

  AccountUpgradeOperationFeeParameters(this.membershipAnnualFee, this.membershipLifetimeFee);

  factory AccountUpgradeOperationFeeParameters.fromJson(dynamic json) {
    if (!(json is Map)) {
      return null;
    }

    int membershipAnnualFee = json['membership_annual_fee'];
    int membershipLifetimeFee = json['membership_lifetime_fee'];
    return AccountUpgradeOperationFeeParameters(membershipAnnualFee, membershipLifetimeFee);
  }

  @override
  bool serialize(Encoder encoder)  {
    encoder.encodeUint8(FeeParametersType.FeeParametersTypeAccountUpgrade.index);
    encoder.encodeUint64(this.membershipAnnualFee);
    encoder.encodeUint64(this.membershipLifetimeFee);
    return true;
  }

  @override
  dynamic toJson() {
    final val = <String, dynamic>{
      'membership_annual_fee': this.membershipAnnualFee,
      'membership_lifetime_fee' : this.membershipLifetimeFee,
    };

    return val;
  }
}

class AccountTransferOperationFeeParameters extends Serializable{
  int fee;

  AccountTransferOperationFeeParameters(this.fee);

  factory AccountTransferOperationFeeParameters.fromJson(dynamic json) {
    if (!(json is Map)) {
      return null;
    }

    int fee = json['fee'];
    return AccountTransferOperationFeeParameters(fee);
  }

  @override
  bool serialize(Encoder encoder)  {
    encoder.encodeUint8(FeeParametersType.FeeParametersTypeAccountTransfer.index);
    encoder.encodeUint64(this.fee);
    return true;
  }

  @override
  dynamic toJson() {
    final val = <String, dynamic>{
      'fee': this.fee,
    };

    return val;
  }
}

class AssetCreateOperationFeeParameters extends Serializable{
  int symbol3;
  int symbol4;
  int longSymbol;
  int pricePerKbyte;

  AssetCreateOperationFeeParameters(this.symbol3, this.symbol4, this.longSymbol, this.pricePerKbyte);

  factory AssetCreateOperationFeeParameters.fromJson(dynamic json) {
    if (!(json is Map)) {
      return null;
    }

    int symbol3 = json['symbol3'];
    int symbol4 = json['symbol4'];
    int longSymbol = json['long_symbol'];
    int pricePerKbyte = json['price_per_kbyte'];
    return AssetCreateOperationFeeParameters(symbol3, symbol4, longSymbol, pricePerKbyte);
  }

  @override
  bool serialize(Encoder encoder)  {
    encoder.encodeUint8(FeeParametersType.FeeParametersTypeAssetCreate.index);
    encoder.encodeUint64(this.symbol3);
    encoder.encodeUint64(this.symbol4);
    encoder.encodeUint64(this.longSymbol);
    encoder.encodeUint32(this.pricePerKbyte);
    return true;
  }

  @override
  dynamic toJson() {
    final val = <String, dynamic>{
      'symbol3': this.symbol3,
      'symbol4': this.symbol4,
      'long_symbol': this.longSymbol,
      'price_per_kbyte' : this.pricePerKbyte,
    };

    return val;
  }
}

class AssetUpdateOperationFeeParameters extends Serializable{
  int fee;
  int pricePerKbyte;

  AssetUpdateOperationFeeParameters(this.fee, this.pricePerKbyte);

  factory AssetUpdateOperationFeeParameters.fromJson(dynamic json) {
    if (!(json is Map)) {
      return null;
    }

    int fee = json['fee'];
    int pricePerKbyte = json['price_per_kbyte'];
    return AssetUpdateOperationFeeParameters(fee, pricePerKbyte);
  }

  @override
  bool serialize(Encoder encoder)  {
    encoder.encodeUint8(FeeParametersType.FeeParametersTypeAssetUpdate.index);
    encoder.encodeUint64(this.fee);
    encoder.encodeUint32(this.pricePerKbyte);
    return true;
  }

  @override
  dynamic toJson() {
    final val = <String, dynamic>{
      'fee': this.fee,
      'price_per_kbyte' : this.pricePerKbyte,
    };

    return val;
  }
}

class AssetUpdateBitassetOperationFeeParameters extends Serializable{
  int fee;

  AssetUpdateBitassetOperationFeeParameters(this.fee);

  factory AssetUpdateBitassetOperationFeeParameters.fromJson(dynamic json) {
    if (!(json is Map)) {
      return null;
    }

    int fee = json['fee'];
    return AssetUpdateBitassetOperationFeeParameters(fee);
  }

  @override
  bool serialize(Encoder encoder)  {
    encoder.encodeUint8(FeeParametersType.FeeParametersTypeAssetUpdateBitasset.index);
    encoder.encodeUint64(this.fee);
    return true;
  }

  @override
  dynamic toJson() {
    final val = <String, dynamic>{
      'fee': this.fee,
    };

    return val;
  }
}

class AssetUpdateFeedProducersOperationFeeParameters extends Serializable{
  int fee;

  AssetUpdateFeedProducersOperationFeeParameters(this.fee);

  factory AssetUpdateFeedProducersOperationFeeParameters.fromJson(dynamic json) {
    if (!(json is Map)) {
      return null;
    }

    int fee = json['fee'];
    return AssetUpdateFeedProducersOperationFeeParameters(fee);
  }

  @override
  bool serialize(Encoder encoder)  {
    encoder.encodeUint8(FeeParametersType.FeeParametersTypeAssetUpdateFeedProducers.index);
    encoder.encodeUint64(this.fee);
    return true;
  }

  @override
  dynamic toJson() {
    final val = <String, dynamic>{
      'fee': this.fee,
    };

    return val;
  }
}

class AssetIssueOperationFeeParameters extends Serializable{
  int fee;
  int pricePerKbyte;

  AssetIssueOperationFeeParameters(this.fee, this.pricePerKbyte);

  factory AssetIssueOperationFeeParameters.fromJson(dynamic json) {
    if (!(json is Map)) {
      return null;
    }

    int fee = json['fee'];
    int pricePerKbyte = json['price_per_kbyte'];
    return AssetIssueOperationFeeParameters(fee, pricePerKbyte);
  }

  @override
  bool serialize(Encoder encoder)  {
    encoder.encodeUint8(FeeParametersType.FeeParametersTypeAssetIssue.index);
    encoder.encodeUint64(this.fee);
    encoder.encodeUint32(this.pricePerKbyte);
    return true;
  }

  @override
  dynamic toJson() {
    final val = <String, dynamic>{
      'fee': this.fee,
      'price_per_kbyte' : this.pricePerKbyte,
    };

    return val;
  }
}

class AssetReserveOperationFeeParameters extends Serializable{
  int fee;

  AssetReserveOperationFeeParameters(this.fee);

  factory AssetReserveOperationFeeParameters.fromJson(dynamic json) {
    if (!(json is Map)) {
      return null;
    }

    int fee = json['fee'];
    return AssetReserveOperationFeeParameters(fee);
  }

  @override
  bool serialize(Encoder encoder)  {
    encoder.encodeUint8(FeeParametersType.FeeParametersTypeAssetReserve.index);
    encoder.encodeUint64(this.fee);
    return true;
  }

  @override
  dynamic toJson() {
    final val = <String, dynamic>{
      'fee': this.fee,
    };

    return val;
  }
}

class AssetFundFeePoolOperationFeeParameters extends Serializable{
  int fee;

  AssetFundFeePoolOperationFeeParameters(this.fee);

  factory AssetFundFeePoolOperationFeeParameters.fromJson(dynamic json) {
    if (!(json is Map)) {
      return null;
    }

    int fee = json['fee'];
    return AssetFundFeePoolOperationFeeParameters(fee);
  }

  @override
  bool serialize(Encoder encoder)  {
    encoder.encodeUint8(FeeParametersType.FeeParametersTypeAssetFundFeePool.index);
    encoder.encodeUint64(this.fee);
    return true;
  }

  @override
  dynamic toJson() {
    final val = <String, dynamic>{
      'fee': this.fee,
    };

    return val;
  }
}

class AssetSettleOperationFeeParameters extends Serializable{
  int fee;

  AssetSettleOperationFeeParameters(this.fee);

  factory AssetSettleOperationFeeParameters.fromJson(dynamic json) {
    if (!(json is Map)) {
      return null;
    }

    int fee = json['fee'];
    return AssetSettleOperationFeeParameters(fee);
  }

  @override
  bool serialize(Encoder encoder)  {
    encoder.encodeUint8(FeeParametersType.FeeParametersTypeAssetSettle.index);
    encoder.encodeUint64(this.fee);
    return true;
  }

  @override
  dynamic toJson() {
    final val = <String, dynamic>{
      'fee': this.fee,
    };

    return val;
  }
}

class AssetGlobalSettleOperationFeeParameters extends Serializable{
  int fee;

  AssetGlobalSettleOperationFeeParameters(this.fee);

  factory AssetGlobalSettleOperationFeeParameters.fromJson(dynamic json) {
    if (!(json is Map)) {
      return null;
    }

    int fee = json['fee'];
    return AssetGlobalSettleOperationFeeParameters(fee);
  }

  @override
  bool serialize(Encoder encoder)  {
    encoder.encodeUint8(FeeParametersType.FeeParametersTypeAssetGlobalSettle.index);
    encoder.encodeUint64(this.fee);
    return true;
  }

  @override
  dynamic toJson() {
    final val = <String, dynamic>{
      'fee': this.fee,
    };

    return val;
  }
}

class AssetPublishFeedOperationFeeParameters extends Serializable{
  int fee;

  AssetPublishFeedOperationFeeParameters(this.fee);

  factory AssetPublishFeedOperationFeeParameters.fromJson(dynamic json) {
    if (!(json is Map)) {
      return null;
    }

    int fee = json['fee'];
    return AssetPublishFeedOperationFeeParameters(fee);
  }

  @override
  bool serialize(Encoder encoder)  {
    encoder.encodeUint8(FeeParametersType.FeeParametersTypeAssetPublishFeed.index);
    encoder.encodeUint64(this.fee);
    return true;
  }

  @override
  dynamic toJson() {
    final val = <String, dynamic>{
      'fee': this.fee,
    };

    return val;
  }
}

class WitnessCreateOperationFeeParameters extends Serializable{
  int fee;

  WitnessCreateOperationFeeParameters(this.fee);

  factory WitnessCreateOperationFeeParameters.fromJson(dynamic json) {
    if (!(json is Map)) {
      return null;
    }

    int fee = json['fee'];
    return WitnessCreateOperationFeeParameters(fee);
  }

  @override
  bool serialize(Encoder encoder)  {
    encoder.encodeUint8(FeeParametersType.FeeParametersTypeWitnessCreate.index);
    encoder.encodeUint64(this.fee);
    return true;
  }

  @override
  dynamic toJson() {
    final val = <String, dynamic>{
      'fee': this.fee,
    };

    return val;
  }
}

class WitnessUpdateOperationFeeParameters extends Serializable{
  int fee;

  WitnessUpdateOperationFeeParameters(this.fee);

  factory WitnessUpdateOperationFeeParameters.fromJson(dynamic json) {
    if (!(json is Map)) {
      return null;
    }

    int fee = json['fee'];
    return WitnessUpdateOperationFeeParameters(fee);
  }

  @override
  bool serialize(Encoder encoder)  {
    encoder.encodeUint8(FeeParametersType.FeeParametersTypeWitnessUpdate.index);
    encoder.encodeUint64(this.fee);
    return true;
  }

  @override
  dynamic toJson() {
    final val = <String, dynamic>{
      'fee': this.fee,
    };

    return val;
  }
}

class ProposalCreateOperationFeeParameters extends Serializable{
  int fee;
  int pricePerKbyte;

  ProposalCreateOperationFeeParameters(this.fee, this.pricePerKbyte);

  factory ProposalCreateOperationFeeParameters.fromJson(dynamic json) {
    if (!(json is Map)) {
      return null;
    }

    int fee = json['fee'];
    int pricePerKbyte = json['price_per_kbyte'];
    return ProposalCreateOperationFeeParameters(fee, pricePerKbyte);
  }

  @override
  bool serialize(Encoder encoder)  {
    encoder.encodeUint8(FeeParametersType.FeeParametersTypeProposalCreate.index);
    encoder.encodeUint64(this.fee);
    encoder.encodeUint32(this.pricePerKbyte);
    return true;
  }

  @override
  dynamic toJson() {
    final val = <String, dynamic>{
      'fee': this.fee,
      'price_per_kbyte' : this.pricePerKbyte,
    };

    return val;
  }
}

class ProposalUpdateOperationFeeParameters extends Serializable{
  int fee;
  int pricePerKbyte;

  ProposalUpdateOperationFeeParameters(this.fee, this.pricePerKbyte);

  factory ProposalUpdateOperationFeeParameters.fromJson(dynamic json) {
    if (!(json is Map)) {
      return null;
    }

    int fee = json['fee'];
    int pricePerKbyte = json['price_per_kbyte'];
    return ProposalUpdateOperationFeeParameters(fee, pricePerKbyte);
  }

  @override
  bool serialize(Encoder encoder)  {
    encoder.encodeUint8(FeeParametersType.FeeParametersTypeProposalUpdate.index);
    encoder.encodeUint64(this.fee);
    encoder.encodeUint32(this.pricePerKbyte);
    return true;
  }

  @override
  dynamic toJson() {
    final val = <String, dynamic>{
      'fee': this.fee,
      'price_per_kbyte' : this.pricePerKbyte,
    };

    return val;
  }
}

class ProposalDeleteOperationFeeParameters extends Serializable{
  int fee;

  ProposalDeleteOperationFeeParameters(this.fee);

  factory ProposalDeleteOperationFeeParameters.fromJson(dynamic json) {
    if (!(json is Map)) {
      return null;
    }

    int fee = json['fee'];
    return ProposalDeleteOperationFeeParameters(fee);
  }

  @override
  bool serialize(Encoder encoder)  {
    encoder.encodeUint8(FeeParametersType.FeeParametersTypeProposalDelete.index);
    encoder.encodeUint64(this.fee);
    return true;
  }

  @override
  dynamic toJson() {
    final val = <String, dynamic>{
      'fee': this.fee,
    };

    return val;
  }
}

class WithdrawPermissionCreateOperationFeeParameters extends Serializable{
  int fee;

  WithdrawPermissionCreateOperationFeeParameters(this.fee);

  factory WithdrawPermissionCreateOperationFeeParameters.fromJson(dynamic json) {
    if (!(json is Map)) {
      return null;
    }

    int fee = json['fee'];
    return WithdrawPermissionCreateOperationFeeParameters(fee);
  }

  @override
  bool serialize(Encoder encoder)  {
    encoder.encodeUint8(FeeParametersType.FeeParametersTypeWithdrawPermissionCreate.index);
    encoder.encodeUint64(this.fee);
    return true;
  }

  @override
  dynamic toJson() {
    final val = <String, dynamic>{
      'fee': this.fee,
    };

    return val;
  }
}

class WithdrawPermissionUpdateOperationFeeParameters extends Serializable{
  int fee;

  WithdrawPermissionUpdateOperationFeeParameters(this.fee);

  factory WithdrawPermissionUpdateOperationFeeParameters.fromJson(dynamic json) {
    if (!(json is Map)) {
      return null;
    }

    int fee = json['fee'];
    return WithdrawPermissionUpdateOperationFeeParameters(fee);
  }

  @override
  bool serialize(Encoder encoder)  {
    encoder.encodeUint8(FeeParametersType.FeeParametersTypeWithdrawPermissionUpdate.index);
    encoder.encodeUint64(this.fee);
    return true;
  }

  @override
  dynamic toJson() {
    final val = <String, dynamic>{
      'fee': this.fee,
    };

    return val;
  }
}

class WithdrawPermissionClaimOperationFeeParameters extends Serializable{
  int fee;
  int pricePerKbyte;

  WithdrawPermissionClaimOperationFeeParameters(this.fee, this.pricePerKbyte);

  factory WithdrawPermissionClaimOperationFeeParameters.fromJson(dynamic json) {
    if (!(json is Map)) {
      return null;
    }

    int fee = json['fee'];
    int pricePerKbyte = json['price_per_kbyte'];
    return WithdrawPermissionClaimOperationFeeParameters(fee, pricePerKbyte);
  }

  @override
  bool serialize(Encoder encoder)  {
    encoder.encodeUint8(FeeParametersType.FeeParametersTypeWithdrawPermissionClaim.index);
    encoder.encodeUint64(this.fee);
    encoder.encodeUint32(this.pricePerKbyte);
    return true;
  }

  @override
  dynamic toJson() {
    final val = <String, dynamic>{
      'fee': this.fee,
      'price_per_kbyte' : this.pricePerKbyte,
    };

    return val;
  }
}

class WithdrawPermissionDeleteOperationFeeParameters extends Serializable{
  int fee;

  WithdrawPermissionDeleteOperationFeeParameters(this.fee);

  factory WithdrawPermissionDeleteOperationFeeParameters.fromJson(dynamic json) {
    if (!(json is Map)) {
      return null;
    }

    int fee = json['fee'];
    return WithdrawPermissionDeleteOperationFeeParameters(fee);
  }

  @override
  bool serialize(Encoder encoder)  {
    encoder.encodeUint8(FeeParametersType.FeeParametersTypeWithdrawPermissionDelete.index);
    encoder.encodeUint64(this.fee);
    return true;
  }

  @override
  dynamic toJson() {
    final val = <String, dynamic>{
      'fee': this.fee,
    };

    return val;
  }
}

class CommitteeMemberCreateOperationFeeParameters extends Serializable{
  int fee;

  CommitteeMemberCreateOperationFeeParameters(this.fee);

  factory CommitteeMemberCreateOperationFeeParameters.fromJson(dynamic json) {
    if (!(json is Map)) {
      return null;
    }

    int fee = json['fee'];
    return CommitteeMemberCreateOperationFeeParameters(fee);
  }

  @override
  bool serialize(Encoder encoder)  {
    encoder.encodeUint8(FeeParametersType.FeeParametersTypeCommitteeMemberCreate.index);
    encoder.encodeUint64(this.fee);
    return true;
  }

  @override
  dynamic toJson() {
    final val = <String, dynamic>{
      'fee': this.fee,
    };

    return val;
  }
}

class CommitteeMemberUpdateOperationFeeParameters extends Serializable{
  int fee;

  CommitteeMemberUpdateOperationFeeParameters(this.fee);

  factory CommitteeMemberUpdateOperationFeeParameters.fromJson(dynamic json) {
    if (!(json is Map)) {
      return null;
    }

    int fee = json['fee'];
    return CommitteeMemberUpdateOperationFeeParameters(fee);
  }

  @override
  bool serialize(Encoder encoder)  {
    encoder.encodeUint8(FeeParametersType.FeeParametersTypeCommitteeMemberUpdate.index);
    encoder.encodeUint64(this.fee);
    return true;
  }

  @override
  dynamic toJson() {
    final val = <String, dynamic>{
      'fee': this.fee,
    };

    return val;
  }
}

class CommitteeMemberUpdateGlobalParametersOperationFeeParameters extends Serializable{
  int fee;

  CommitteeMemberUpdateGlobalParametersOperationFeeParameters(this.fee);

  factory CommitteeMemberUpdateGlobalParametersOperationFeeParameters.fromJson(dynamic json) {
    if (!(json is Map)) {
      return null;
    }

    int fee = json['fee'];
    return CommitteeMemberUpdateGlobalParametersOperationFeeParameters(fee);
  }

  @override
  bool serialize(Encoder encoder)  {
    encoder.encodeUint8(FeeParametersType.FeeParametersTypeCommitteeMemberUpdateGlobalParameters.index);
    encoder.encodeUint64(this.fee);
    return true;
  }

  @override
  dynamic toJson() {
    final val = <String, dynamic>{
      'fee': this.fee,
    };

    return val;
  }
}

class VestingBalanceCreateOperationFeeParameters extends Serializable{
  int fee;

  VestingBalanceCreateOperationFeeParameters(this.fee);

  factory VestingBalanceCreateOperationFeeParameters.fromJson(dynamic json) {
    if (!(json is Map)) {
      return null;
    }

    int fee = json['fee'];
    return VestingBalanceCreateOperationFeeParameters(fee);
  }

  @override
  bool serialize(Encoder encoder)  {
    encoder.encodeUint8(FeeParametersType.FeeParametersTypeVestingBalanceCreate.index);
    encoder.encodeUint64(this.fee);
    return true;
  }

  @override
  dynamic toJson() {
    final val = <String, dynamic>{
      'fee': this.fee,
    };

    return val;
  }
}

class VestingBalanceWithdrawOperationFeeParameters extends Serializable{
  int fee;

  VestingBalanceWithdrawOperationFeeParameters(this.fee);

  factory VestingBalanceWithdrawOperationFeeParameters.fromJson(dynamic json) {
    if (!(json is Map)) {
      return null;
    }

    int fee = json['fee'];
    return VestingBalanceWithdrawOperationFeeParameters(fee);
  }

  @override
  bool serialize(Encoder encoder)  {
    encoder.encodeUint8(FeeParametersType.FeeParametersTypeVestingBalanceWithdraw.index);
    encoder.encodeUint64(this.fee);
    return true;
  }

  @override
  dynamic toJson() {
    final val = <String, dynamic>{
      'fee': this.fee,
    };

    return val;
  }
}

class WorkerCreateOperationFeeParameters extends Serializable{
  int fee;

  WorkerCreateOperationFeeParameters(this.fee);

  factory WorkerCreateOperationFeeParameters.fromJson(dynamic json) {
    if (!(json is Map)) {
      return null;
    }

    int fee = json['fee'];
    return WorkerCreateOperationFeeParameters(fee);
  }

  @override
  bool serialize(Encoder encoder)  {
    encoder.encodeUint8(FeeParametersType.FeeParametersTypeWorkerCreate.index);
    encoder.encodeUint64(this.fee);
    return true;
  }

  @override
  dynamic toJson() {
    final val = <String, dynamic>{
      'fee': this.fee,
    };

    return val;
  }
}

class CustomOperationFeeParameters extends Serializable{
  int fee;
  int pricePerKbyte;

  CustomOperationFeeParameters(this.fee, this.pricePerKbyte);

  factory CustomOperationFeeParameters.fromJson(dynamic json) {
    if (!(json is Map)) {
      return null;
    }

    int fee = json['fee'];
    int pricePerKbyte = json['price_per_kbyte'];
    return CustomOperationFeeParameters(fee, pricePerKbyte);
  }

  @override
  bool serialize(Encoder encoder)  {
    encoder.encodeUint8(FeeParametersType.FeeParametersTypeCustom.index);
    encoder.encodeUint64(this.fee);
    encoder.encodeUint32(this.pricePerKbyte);
    return true;
  }

  @override
  dynamic toJson() {
    final val = <String, dynamic>{
      'fee': this.fee,
      'price_per_kbyte' : this.pricePerKbyte,
    };

    return val;
  }
}

class AssertOperationFeeParameters extends Serializable{
  int fee;

  AssertOperationFeeParameters(this.fee);

  factory AssertOperationFeeParameters.fromJson(dynamic json) {
    if (!(json is Map)) {
      return null;
    }

    int fee = json['fee'];
    return AssertOperationFeeParameters(fee);
  }

  @override
  bool serialize(Encoder encoder)  {
    encoder.encodeUint8(FeeParametersType.FeeParametersTypeAssert.index);
    encoder.encodeUint64(this.fee);
    return true;
  }

  @override
  dynamic toJson() {
    final val = <String, dynamic>{
      'fee': this.fee,
    };

    return val;
  }
}

class BalanceClaimOperationFeeParameters extends Serializable{

  BalanceClaimOperationFeeParameters();

  factory BalanceClaimOperationFeeParameters.fromJson(dynamic json) {
    if (!(json is Map)) {
      return null;
    }

    return BalanceClaimOperationFeeParameters();
  }

  @override
  bool serialize(Encoder encoder)  {
    encoder.encodeUint8(FeeParametersType.FeeParametersTypeBalanceClaim.index);
    return true;
  }

  @override
  dynamic toJson() {
    final val = <String, dynamic>{
    };

    return val;
  }
}

class OverrideTransferOperationFeeParameters extends Serializable{
  int fee;
  int pricePerKbyte;

  OverrideTransferOperationFeeParameters(this.fee, this.pricePerKbyte);

  factory OverrideTransferOperationFeeParameters.fromJson(dynamic json) {
    if (!(json is Map)) {
      return null;
    }

    int fee = json['fee'];
    int pricePerKbyte = json['price_per_kbyte'];
    return OverrideTransferOperationFeeParameters(fee, pricePerKbyte);
  }

  @override
  bool serialize(Encoder encoder)  {
    encoder.encodeUint8(FeeParametersType.FeeParametersTypeOverrideTransfer.index);
    encoder.encodeUint64(this.fee);
    encoder.encodeUint32(this.pricePerKbyte);
    return true;
  }

  @override
  dynamic toJson() {
    final val = <String, dynamic>{
      'fee': this.fee,
      'price_per_kbyte' : this.pricePerKbyte,
    };

    return val;
  }
}

class TransferToBlindOperationFeeParameters extends Serializable{
  int fee;
  int pricePerKbyte;

  TransferToBlindOperationFeeParameters(this.fee, this.pricePerKbyte);

  factory TransferToBlindOperationFeeParameters.fromJson(dynamic json) {
    if (!(json is Map)) {
      return null;
    }

    int fee = json['fee'];
    int pricePerKbyte = json['price_per_kbyte'];
    return TransferToBlindOperationFeeParameters(fee, pricePerKbyte);
  }

  @override
  bool serialize(Encoder encoder)  {
    encoder.encodeUint8(FeeParametersType.FeeParametersTypeTransferToBlind.index);
    encoder.encodeUint64(this.fee);
    encoder.encodeUint32(this.pricePerKbyte);
    return true;
  }

  @override
  dynamic toJson() {
    final val = <String, dynamic>{
      'fee': this.fee,
      'price_per_kbyte' : this.pricePerKbyte,
    };

    return val;
  }
}

class BlindTransferOperationFeeParameters extends Serializable{
  int fee;
  int pricePerKbyte;

  BlindTransferOperationFeeParameters(this.fee, this.pricePerKbyte);

  factory BlindTransferOperationFeeParameters.fromJson(dynamic json) {
    if (!(json is Map)) {
      return null;
    }

    int fee = json['fee'];
    int pricePerKbyte = json['price_per_kbyte'];
    return BlindTransferOperationFeeParameters(fee, pricePerKbyte);
  }

  @override
  bool serialize(Encoder encoder)  {
    encoder.encodeUint8(FeeParametersType.FeeParametersTypeBlindTransfer.index);
    encoder.encodeUint64(this.fee);
    encoder.encodeUint32(this.pricePerKbyte);
    return true;
  }

  @override
  dynamic toJson() {
    final val = <String, dynamic>{
      'fee': this.fee,
      'price_per_kbyte' : this.pricePerKbyte,
    };

    return val;
  }
}

class TransferFromBlindOperationFeeParameters extends Serializable{
  int fee;

  TransferFromBlindOperationFeeParameters(this.fee);

  factory TransferFromBlindOperationFeeParameters.fromJson(dynamic json) {
    if (!(json is Map)) {
      return null;
    }

    int fee = json['fee'];
    return TransferFromBlindOperationFeeParameters(fee);
  }

  @override
  bool serialize(Encoder encoder)  {
    encoder.encodeUint8(FeeParametersType.FeeParametersTypeTransferFromBlind.index);
    encoder.encodeUint64(this.fee);
    return true;
  }

  @override
  dynamic toJson() {
    final val = <String, dynamic>{
      'fee': this.fee,
    };

    return val;
  }
}

class AssetSettleCancelOperationFeeParameters extends Serializable{

  AssetSettleCancelOperationFeeParameters();

  factory AssetSettleCancelOperationFeeParameters.fromJson(dynamic json) {
    if (!(json is Map)) {
      return null;
    }

    return AssetSettleCancelOperationFeeParameters();
  }

  @override
  bool serialize(Encoder encoder)  {
    encoder.encodeUint8(FeeParametersType.FeeParametersTypeAssetSettleCancel.index);
    return true;
  }

  @override
  dynamic toJson() {
    final val = <String, dynamic>{
    };

    return val;
  }
}

class AssetClaimFeesOperationFeeParameters extends Serializable{
  int fee;

  AssetClaimFeesOperationFeeParameters(this.fee);

  factory AssetClaimFeesOperationFeeParameters.fromJson(dynamic json) {
    if (!(json is Map)) {
      return null;
    }

    int fee = json['fee'];
    return AssetClaimFeesOperationFeeParameters(fee);
  }

  @override
  bool serialize(Encoder encoder)  {
    encoder.encodeUint8(FeeParametersType.FeeParametersTypeAssetClaimFees.index);
    encoder.encodeUint64(this.fee);
    return true;
  }

  @override
  dynamic toJson() {
    final val = <String, dynamic>{
      'fee': this.fee,
    };

    return val;
  }
}

class FeeParameters extends Serializable{
  FeeParametersType type;
  dynamic data;

  FeeParameters(this.type, this.data);

  static List<FeeParameters> toList(dynamic json) {
    List<FeeParameters> fields = List();
    if(json != null) {
      final ts = json as List<dynamic>;
      for(final d in ts) {
        final f = FeeParameters.fromJson(d);
        fields.add(f);
      }
    }
    return fields;
  }

  factory FeeParameters.fromJson(dynamic json) {
    if(!(json is List)) {
      return null;
    }

    final lst = json as List;
    if(lst.length != 2) {
      return null;
    }

    return FeeParameters(FeeParametersType.values[lst[0] as int], lst[1]);
  }

  @override
  bool serialize(Encoder encoder)  {
    Serializable t = null;
    switch(this.type) {
      case FeeParametersType.FeeParametersTypeTransfer:
        t = this.data as TransferOperationFeeParameters;
        break;
      case FeeParametersType.FeeParametersTypeLimitOrderCreate:
        t = this.data as LimitOrderCreateOperationFeeParameters;
        break;
      case FeeParametersType.FeeParametersTypeLimitOrderCancel:
        t = this.data as LimitOrderCancelOperationFeeParameters;
        break;
      case FeeParametersType.FeeParametersTypeCallOrderUpdate:
        t = this.data as CallOrderUpdateOperationFeeParameters;
        break;
      case FeeParametersType.FeeParametersTypeFillOrder:
        t = this.data as FillOrderOperationFeeParameters;
        break;
      case FeeParametersType.FeeParametersTypeAccountCreate:
        t = this.data as AccountCreateOperationFeeParameters;
        break;
      case FeeParametersType.FeeParametersTypeAccountUpdate:
        t = this.data as AccountUpdateOperationFeeParameters;
        break;
      case FeeParametersType.FeeParametersTypeAccountWhitelist:
        t = this.data as AccountWhitelistOperationFeeParameters;
        break;
      case FeeParametersType.FeeParametersTypeAccountUpgrade:
        t = this.data as AccountUpgradeOperationFeeParameters;
        break;
      case FeeParametersType.FeeParametersTypeAccountTransfer:
        t = this.data as AccountTransferOperationFeeParameters;
        break;
      case FeeParametersType.FeeParametersTypeAssetCreate:
        t = this.data as AssetCreateOperationFeeParameters;
        break;
      case FeeParametersType.FeeParametersTypeAssetUpdate:
        t = this.data as AssetUpdateOperationFeeParameters;
        break;
      case FeeParametersType.FeeParametersTypeAssetUpdateBitasset:
        t = this.data as AssetUpdateBitassetOperationFeeParameters;
        break;
      case FeeParametersType.FeeParametersTypeAssetUpdateFeedProducers:
        t = this.data as AssetUpdateFeedProducersOperationFeeParameters;
        break;
      case FeeParametersType.FeeParametersTypeAssetIssue:
        t = this.data as AssetIssueOperationFeeParameters;
        break;
      case FeeParametersType.FeeParametersTypeAssetReserve:
        t = this.data as AssetReserveOperationFeeParameters;
        break;
      case FeeParametersType.FeeParametersTypeAssetFundFeePool:
        t = this.data as AssetFundFeePoolOperationFeeParameters;
        break;
      case FeeParametersType.FeeParametersTypeAssetSettle:
        t = this.data as AssetSettleOperationFeeParameters;
        break;
      case FeeParametersType.FeeParametersTypeAssetGlobalSettle:
        t = this.data as AssetGlobalSettleOperationFeeParameters;
        break;
      case FeeParametersType.FeeParametersTypeAssetPublishFeed:
        t = this.data as AssetPublishFeedOperationFeeParameters;
        break;
      case FeeParametersType.FeeParametersTypeWitnessCreate:
        t = this.data as WitnessCreateOperationFeeParameters;
        break;
      case FeeParametersType.FeeParametersTypeWitnessUpdate:
        t = this.data as WitnessUpdateOperationFeeParameters;
        break;
      case FeeParametersType.FeeParametersTypeProposalCreate:
        t = this.data as ProposalCreateOperationFeeParameters;
        break;
      case FeeParametersType.FeeParametersTypeProposalUpdate:
        t = this.data as ProposalUpdateOperationFeeParameters;
        break;
      case FeeParametersType.FeeParametersTypeProposalDelete:
        t = this.data as ProposalDeleteOperationFeeParameters;
        break;
      case FeeParametersType.FeeParametersTypeWithdrawPermissionCreate:
        t = this.data as WithdrawPermissionCreateOperationFeeParameters;
        break;
      case FeeParametersType.FeeParametersTypeWithdrawPermissionUpdate:
        t = this.data as WithdrawPermissionUpdateOperationFeeParameters;
        break;
      case FeeParametersType.FeeParametersTypeWithdrawPermissionClaim:
        t = this.data as WithdrawPermissionClaimOperationFeeParameters;
        break;
      case FeeParametersType.FeeParametersTypeWithdrawPermissionDelete:
        t = this.data as WithdrawPermissionDeleteOperationFeeParameters;
        break;
      case FeeParametersType.FeeParametersTypeCommitteeMemberCreate:
        t = this.data as CommitteeMemberCreateOperationFeeParameters;
        break;
      case FeeParametersType.FeeParametersTypeCommitteeMemberUpdate:
        t = this.data as CommitteeMemberUpdateOperationFeeParameters;
        break;
      case FeeParametersType.FeeParametersTypeCommitteeMemberUpdateGlobalParameters:
        t = this.data as CommitteeMemberUpdateGlobalParametersOperationFeeParameters;
        break;
      case FeeParametersType.FeeParametersTypeVestingBalanceCreate:
        t = this.data as VestingBalanceCreateOperationFeeParameters;
        break;
      case FeeParametersType.FeeParametersTypeVestingBalanceWithdraw:
        t = this.data as VestingBalanceWithdrawOperationFeeParameters;
        break;
      case FeeParametersType.FeeParametersTypeWorkerCreate:
        t = this.data as WorkerCreateOperationFeeParameters;
        break;
      case FeeParametersType.FeeParametersTypeCustom:
        t = this.data as CustomOperationFeeParameters;
        break;
      case FeeParametersType.FeeParametersTypeAssert:
        t = this.data as AssertOperationFeeParameters;
        break;
      case FeeParametersType.FeeParametersTypeBalanceClaim:
        t = this.data as BalanceClaimOperationFeeParameters;
        break;
      case FeeParametersType.FeeParametersTypeOverrideTransfer:
        t = this.data as OverrideTransferOperationFeeParameters;
        break;
      case FeeParametersType.FeeParametersTypeTransferToBlind:
        t = this.data as TransferToBlindOperationFeeParameters;
        break;
      case FeeParametersType.FeeParametersTypeBlindTransfer:
        t = this.data as BlindTransferOperationFeeParameters;
        break;
      case FeeParametersType.FeeParametersTypeTransferFromBlind:
        t = this.data as TransferFromBlindOperationFeeParameters;
        break;
      case FeeParametersType.FeeParametersTypeAssetSettleCancel:
        t = this.data as AssetSettleCancelOperationFeeParameters;
        break;
      case FeeParametersType.FeeParametersTypeAssetClaimFees:
        t = this.data as AssetClaimFeesOperationFeeParameters;
        break;
      default:
    }
    if(t != null) {
      t.serialize(encoder);
    }
  }

  @override
  dynamic toJson() {
    return List<dynamic>.from([type.index, data]);
  }
}