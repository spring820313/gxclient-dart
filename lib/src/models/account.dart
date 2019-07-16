import '../core/serialization.dart';
import '../core/encoder.dart';
import 'graphene_id.dart';
import 'authority.dart';
import 'account_options.dart';
import 'time.dart';

class Account extends Serializable{
  GrapheneId id;
  String name;
  GrapheneId statistics;
  Time membershipExpirationDate;
  int networkFeePercentage;
  int lifetimeReferrerFeePercentage;
  int referrerRewardsPercentage;
  int topNControlFlags;
  GrapheneIds whitelistingAccounts;
  GrapheneIds blacklistingAccounts;
  GrapheneIds whitelistedAccounts;
  GrapheneIds blacklistedAccounts;
  AccountOptions options;
  GrapheneId registrar;
  GrapheneId referrer;
  GrapheneId lifetimeReferrer;
  GrapheneId cashbackVB;
  Authority owner;
  Authority active;
  OwnerSpecialAuthority ownerSpecialAuthority;
  ActiveSpecialAuthority activeSpecialAuthority;

  Account();

  factory Account.fromJson(dynamic json) {
    if(!(json is Map)) {
      return null;
    }

    Account account = Account();
    account.id = GrapheneId.fromJson(json['id']);
    account.name = json['name'];
    GrapheneId statistics = GrapheneId(json['statistics']);
    account.statistics = statistics;
    account.membershipExpirationDate = Time.fromJson(json['membership_expiration_date']);
    account.networkFeePercentage = json['network_fee_percentage'] as int;
    account.lifetimeReferrerFeePercentage = json['lifetime_referrer_fee_percentage'] as int;
    account.referrerRewardsPercentage = json['referrer_rewards_percentage'] as int;
    account.topNControlFlags = json['top_n_control_flags'] as int;
    account.whitelistingAccounts = GrapheneIds.fromJson(json['whitelisting_accounts']);
    account.blacklistingAccounts = GrapheneIds.fromJson(json['blacklisting_accounts']);
    account.whitelistedAccounts = GrapheneIds.fromJson(json['whitelisted_accounts']);
    account.blacklistedAccounts = GrapheneIds.fromJson(json['blacklisted_accounts']);
    account.options = AccountOptions.fromJson(json['options']);
    account.registrar = GrapheneId.fromJson(json['registrar']);
    account.referrer = GrapheneId.fromJson(json['referrer']);
    account.lifetimeReferrer = GrapheneId.fromJson(json['lifetime_referrer']);
    account.cashbackVB = GrapheneId.fromJson(json['cashback_vb']);
    account.owner = Authority.fromJson(json['owner']);
    account.active = Authority.fromJson(json['active']);
    account.ownerSpecialAuthority = OwnerSpecialAuthority.fromJson(json['owner_special_authority']);
    account.activeSpecialAuthority = ActiveSpecialAuthority.fromJson(json['active_special_authority']);

    return account;
  }

  @override
  bool serialize(Encoder encoder)  {
    return true;
  }

  @override
  dynamic toJson() {
    final val = <String, dynamic>{
      'id': this.id,
      'name' : this.name,
      'statistics' : this.statistics.toJson(),
      'membership_expiration_date' : this.membershipExpirationDate.toJson(),
      'network_fee_percentage' : this.networkFeePercentage,
      'lifetime_referrer_fee_percentage' : this.lifetimeReferrerFeePercentage,

      'referrer_rewards_percentage': this.referrerRewardsPercentage,
      'top_n_control_flags' : this.topNControlFlags,
      'whitelisting_accounts' : this.whitelistingAccounts.toJson(),
      'blacklisting_accounts' : this.blacklistingAccounts.toJson(),
      'whitelisted_accounts' : this.whitelistedAccounts.toJson(),
      'blacklisted_accounts' : this.blacklistedAccounts.toJson(),

      'options': this.options.toJson(),
      'registrar' : this.registrar.toJson(),
      'referrer' : this.referrer.toJson(),
      'lifetime_referrer' : this.lifetimeReferrer.toJson(),
      'cashback_vb' : this.cashbackVB != null ? this.cashbackVB.toJson() : null,
      'owner' : this.owner.toJson(),

      'active' : this.active.toJson(),
      'owner_special_authority' : this.ownerSpecialAuthority.toJson(),
      'active_special_authority' : this.activeSpecialAuthority.toJson(),
    };

    return val;
  }
}

class RegisterAccountInfo extends Serializable {
  String name;
  String activeKey;
  String ownerKey;
  String memoKey;

  RegisterAccountInfo(this.name, this.activeKey, this.ownerKey, this.memoKey);

  @override
  bool serialize(Encoder encoder)  {
    return true;
  }

  @override
  dynamic toJson() {
    final val = <String, dynamic>{
      'name': this.name,
      'active_key' : this.activeKey,
      'owner_key' : this.ownerKey ?? this.activeKey,
      'memo_key' : this.memoKey ?? this.activeKey,
    };

    return val;
  }
}

class RegisterAccount extends Serializable {
  RegisterAccountInfo account;
  RegisterAccount(this.account);

  @override
  bool serialize(Encoder encoder)  {
    return true;
  }

  @override
  dynamic toJson() {
    final val = <String, dynamic>{
      'account': this.account.toJson(),
    };

    return val;
  }
}