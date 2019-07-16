import '../core/serialization.dart';
import '../core/encoder.dart';
import 'graphene_id.dart';
import 'fee_schedule.dart';

class ChainParameters extends Serializable{
  FeeSchedule currentFees;
  int blockInterval;
  int maintenanceInterval;
  int maintenanceSkipSlots;
  int committeeProposalReviewPeriod;
  int maximumTransactionSize;
  int maximumBlockSize;
  int maximumTimeUntilExpiration;
  int maximumProposalLifetime;
  int maximumAssetWhitelistAuthorities;
  int maximumAssetFeedPublishers;
  int maximumCommitteeCount;
  int maximumWitnessCount;
  int maximumAuthorityMembership;
  int reservePercentOfFee;
  int networkPercentOfFee;
  int lifetimeReferrerPercentOfFee;
  int cashbackVestingPeriodSeconds;
  int cashbackVestingThreshold;
  bool countNonMemberVotes;
  bool allowNonMemberWhitelists;
  int witnessPayPerBlock;
  int workerBudgetPerDay;
  int maxPredicateOpcode;
  int feeLiquidationThreshold;
  int accountsPerFeeScale;
  int accountFeeScaleBitshifts;
  int maxAuthorityDepth;

  List<dynamic> extensions = [];

  ChainParameters();

  factory ChainParameters.fromJson(dynamic json) {
    if(!(json is Map)) {
      return null;
    }
    final c = ChainParameters();
    final maximumCommitteeCount = json['maximum_committee_count'] as int;
    c.maximumCommitteeCount = maximumCommitteeCount;
    final maximumWitnessCount = json['maximum_witness_count'] as int;
    c.maximumWitnessCount = maximumWitnessCount;
    final currentFees = FeeSchedule.fromJson(json['current_fees']);
    c.currentFees = currentFees;
    int blockInterval = json['block_interval'];
    c.blockInterval = blockInterval;
    int maintenanceInterval = json['maintenance_interval'];
    c.maintenanceInterval = maintenanceInterval;
    int maintenanceSkipSlots = json['maintenance_skip_slots'];
    c.maintenanceSkipSlots = maintenanceSkipSlots;
    int committeeProposalReviewPeriod = json['committee_proposal_review_period'];
    c.committeeProposalReviewPeriod = committeeProposalReviewPeriod;
    int maximumTransactionSize = json['maximum_transaction_size'];
    c.maximumTransactionSize = maximumTransactionSize;
    int maximumBlockSize = json['maximum_block_size'];
    c.maximumBlockSize = maximumBlockSize;
    int maximumTimeUntilExpiration = json['maximum_time_until_expiration'];
    c.maximumTimeUntilExpiration = maximumTimeUntilExpiration;
    int maximumProposalLifetime = json['maximum_proposal_lifetime'];
    c.maximumProposalLifetime = maximumProposalLifetime;
    int maximumAssetWhitelistAuthorities = json['maximum_asset_whitelist_authorities'];
    c.maximumAssetWhitelistAuthorities = maximumAssetWhitelistAuthorities;
    int maximumAssetFeedPublishers = json['maximum_asset_feed_publishers'];
    c.maximumAssetFeedPublishers = maximumAssetFeedPublishers;
    int maximumAuthorityMembership = json['maximum_authority_membership'];
    c.maximumAuthorityMembership = maximumAuthorityMembership;
    int reservePercentOfFee = json['reserve_percent_of_fee'];
    c.reservePercentOfFee = reservePercentOfFee;
    int networkPercentOfFee = json['network_percent_of_fee'];
    c.networkPercentOfFee = networkPercentOfFee;
    int lifetimeReferrerPercentOfFee = json['lifetime_referrer_percent_of_fee'];
    c.lifetimeReferrerPercentOfFee = lifetimeReferrerPercentOfFee;
    int cashbackVestingPeriodSeconds = json['cashback_vesting_period_seconds'];
    c.cashbackVestingPeriodSeconds = cashbackVestingPeriodSeconds;
    int cashbackVestingThreshold = json['cashback_vesting_threshold'];
    c.cashbackVestingThreshold = cashbackVestingThreshold;
    bool countNonMemberVotes = json['count_non_member_votes'];
    c.countNonMemberVotes = countNonMemberVotes;
    bool allowNonMemberWhitelists = json['allow_non_member_whitelists'];
    c.allowNonMemberWhitelists = allowNonMemberWhitelists;
    int witnessPayPerBlock = json['witness_pay_per_block'];
    c.witnessPayPerBlock = witnessPayPerBlock;
    int workerBudgetPerDay = json['worker_budget_per_day'];
    c.workerBudgetPerDay = workerBudgetPerDay;
    int maxPredicateOpcode = json['max_predicate_opcode'];
    c.maxPredicateOpcode = maxPredicateOpcode;
    int feeLiquidationThreshold = json['fee_liquidation_threshold'];
    c.feeLiquidationThreshold = feeLiquidationThreshold;
    int accountsPerFeeScale = json['accounts_per_fee_scale'];
    c.accountsPerFeeScale = accountsPerFeeScale;
    int accountFeeScaleBitshifts = json['account_fee_scale_bitshifts'];
    c.accountFeeScaleBitshifts = accountFeeScaleBitshifts;
    int maxAuthorityDepth = json['max_authority_depth'];
    c.maxAuthorityDepth = maxAuthorityDepth;
    return c;
  }

  @override
  bool serialize(Encoder encoder)  {
    this.currentFees.serialize(encoder);
    encoder.encodeUint8(this.blockInterval);
    encoder.encodeUint32(this.maintenanceInterval);
    encoder.encodeUint8(this.maintenanceSkipSlots);

    encoder.encodeUint32(this.committeeProposalReviewPeriod);
    encoder.encodeUint32(this.maximumTransactionSize);
    encoder.encodeUint32(this.maximumBlockSize);
    encoder.encodeUint32(this.maximumTimeUntilExpiration);
    encoder.encodeUint32(this.maximumProposalLifetime);
    encoder.encodeUint8(this.maximumAssetWhitelistAuthorities);

    encoder.encodeUint8(this.maximumAssetFeedPublishers);
    encoder.encodeUint16(this.maximumWitnessCount);
    encoder.encodeUint16(this.maximumCommitteeCount);
    encoder.encodeUint16(this.maximumAuthorityMembership);
    encoder.encodeUint16(this.reservePercentOfFee);
    encoder.encodeUint16(this.networkPercentOfFee);

    encoder.encodeUint16(this.lifetimeReferrerPercentOfFee);
    encoder.encodeUint32(this.cashbackVestingPeriodSeconds);
    encoder.encodeUint64(this.cashbackVestingThreshold);
    encoder.encodeBool(this.countNonMemberVotes);
    encoder.encodeBool(this.allowNonMemberWhitelists);
    encoder.encodeUint64(this.witnessPayPerBlock);

    encoder.encodeUint64(this.workerBudgetPerDay);
    encoder.encodeUint16(this.maxPredicateOpcode);
    encoder.encodeUint64(this.feeLiquidationThreshold);
    encoder.encodeUint16(this.accountsPerFeeScale);
    encoder.encodeUint8(this.accountFeeScaleBitshifts);
    encoder.encodeUint8(this.maxAuthorityDepth);

    encoder.encodeVarint(0);
    return true;
  }

  @override
  dynamic toJson() {
    final val = <String, dynamic>{
      'current_fees': this.currentFees.toJson(),
      'maximum_committee_count': this.maximumCommitteeCount,
      'maximum_witness_count': this.maximumWitnessCount,

      'block_interval': this.blockInterval,
      'maintenance_interval': this.maintenanceInterval,
      'maintenance_skip_slots': this.maintenanceSkipSlots,
      'committee_proposal_review_period': this.committeeProposalReviewPeriod,
      'maximum_transaction_size': this.maximumTransactionSize,
      'maximum_block_size': this.maximumBlockSize,

      'maximum_time_until_expiration': this.maximumTimeUntilExpiration,
      'maximum_proposal_lifetime': this.maximumProposalLifetime,
      'maximum_asset_whitelist_authorities': this.maximumAssetWhitelistAuthorities,
      'maximum_asset_feed_publishers': this.maximumAssetFeedPublishers,
      'maximum_authority_membership': this.maximumAuthorityMembership,
      'reserve_percent_of_fee': this.reservePercentOfFee,

      'network_percent_of_fee': this.networkPercentOfFee,
      'lifetime_referrer_percent_of_fee': this.lifetimeReferrerPercentOfFee,
      'cashback_vesting_period_seconds': this.cashbackVestingPeriodSeconds,
      'cashback_vesting_threshold': this.cashbackVestingThreshold,
      'count_non_member_votes': this.countNonMemberVotes,
      'allow_non_member_whitelists': this.allowNonMemberWhitelists,

      'witness_pay_per_block': this.witnessPayPerBlock,
      'worker_budget_per_day': this.workerBudgetPerDay,
      'max_predicate_opcode': this.maxPredicateOpcode,
      'fee_liquidation_threshold': this.feeLiquidationThreshold,
      'accounts_per_fee_scale': this.accountsPerFeeScale,
      'account_fee_scale_bitshifts': this.accountFeeScaleBitshifts,

      'max_authority_depth': this.maxAuthorityDepth,

      'extensions': [],
    };

    return val;
  }
}

class ObjectParameters extends Serializable{
  GrapheneId id;
  ChainParameters parameters;

  ObjectParameters(this.id, this.parameters);

  factory ObjectParameters.fromJson(dynamic json) {
    if(!(json is Map)) {
      return null;
    }
    final id = GrapheneId.fromJson(json['id']);
    final parameters = ChainParameters.fromJson(json['parameters']);
    return ObjectParameters(id, parameters);
  }

  @override
  bool serialize(Encoder encoder)  {
    this.id.serialize(encoder);
    this.parameters.serialize(encoder);
    return true;
  }

  @override
  dynamic toJson() {
    final val = <String, dynamic>{
      'id': this.id.toJson(),
      'parameters': this.parameters.toJson(),
    };

    return val;
  }
}