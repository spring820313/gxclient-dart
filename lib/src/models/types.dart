
enum SpecialAuthorityType {
  SpecialAuthorityTypeNoSpecial,
  SpecialAuthorityTypeTopHolders
}

enum AccountCreateExtensionsType {
  AccountCreateExtensionsNullExt,
  AccountCreateExtensionsOwnerSpecial,
  AccountCreateExtensionsActiveSpecial,
  AccountCreateExtensionsBuyback
}

enum PredicateType {
  PredicateAccountNameEqLit,
  PredicateAssetSymbolEqLit,
  PredicateBlockId
}

enum WorkerInitializerType {
  WorkerInitializerTypeRefund,
  WorkerInitializerTypeVestingBalance,
  WorkerInitializerTypeBurn
}

enum VestingPolicyType {
  VestingPolicyTypeLinear,
  VestingPolicyTypeCCD
}

enum FeeParametersType {
  FeeParametersTypeTransfer,
  FeeParametersTypeLimitOrderCreate,
  FeeParametersTypeLimitOrderCancel,
  FeeParametersTypeCallOrderUpdate,
  FeeParametersTypeFillOrder,
  FeeParametersTypeAccountCreate,
  FeeParametersTypeAccountUpdate,
  FeeParametersTypeAccountWhitelist,
  FeeParametersTypeAccountUpgrade,
  FeeParametersTypeAccountTransfer,
  FeeParametersTypeAssetCreate,
  FeeParametersTypeAssetUpdate,
  FeeParametersTypeAssetUpdateBitasset,
  FeeParametersTypeAssetUpdateFeedProducers,
  FeeParametersTypeAssetIssue,
  FeeParametersTypeAssetReserve,
  FeeParametersTypeAssetFundFeePool,
  FeeParametersTypeAssetSettle,
  FeeParametersTypeAssetGlobalSettle,
  FeeParametersTypeAssetPublishFeed,
  FeeParametersTypeWitnessCreate,
  FeeParametersTypeWitnessUpdate,
  FeeParametersTypeProposalCreate,
  FeeParametersTypeProposalUpdate,
  FeeParametersTypeProposalDelete,
  FeeParametersTypeWithdrawPermissionCreate,
  FeeParametersTypeWithdrawPermissionUpdate,
  FeeParametersTypeWithdrawPermissionClaim,
  FeeParametersTypeWithdrawPermissionDelete,
  FeeParametersTypeCommitteeMemberCreate,
  FeeParametersTypeCommitteeMemberUpdate,
  FeeParametersTypeCommitteeMemberUpdateGlobalParameters,
  FeeParametersTypeVestingBalanceCreate,
  FeeParametersTypeVestingBalanceWithdraw,
  FeeParametersTypeWorkerCreate,
  FeeParametersTypeCustom,
  FeeParametersTypeAssert,
  FeeParametersTypeBalanceClaim,
  FeeParametersTypeOverrideTransfer,
  FeeParametersTypeTransferToBlind,
  FeeParametersTypeBlindTransfer,
  FeeParametersTypeTransferFromBlind,
  FeeParametersTypeAssetSettleCancel,
  FeeParametersTypeAssetClaimFees
}