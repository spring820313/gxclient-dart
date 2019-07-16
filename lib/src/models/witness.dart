import 'dart:core';

import '../core/serialization.dart';
import '../core/encoder.dart';

class Witness extends Serializable{
  String id;
  bool isValid;
  int lastAslot;
  int lastConfirmedBlockNum;
  String payVb;
  String signingKey;
  int totalMissed;
  int totalVotes;
  String url;
  String voteId;
  String witnessAccount;

  Witness();

  factory Witness.fromJson(dynamic json) {
    if(!(json is Map)) {
      return null;
    }

    final wi = Witness();
    wi.id = json['id'];
    wi.isValid = json['is_valid'] as bool;
    wi.payVb = json['pay_vb'];
    wi.totalVotes = json['total_votes'];
    wi.url = json['url'];
    wi.voteId = json['vote_id'];

    wi.lastAslot = json['last_aslot'];
    wi.lastConfirmedBlockNum = json['last_confirmed_block_num'];
    wi.signingKey = json['signing_key'];
    wi.totalMissed = json['total_missed'];
    wi.witnessAccount = json['witness_account'];
    return wi;
  }

  @override
  bool serialize(Encoder encoder)  {
    return true;
  }

  @override
  dynamic toJson() {
    final val = <String, dynamic>{
      'id': this.id,
      'is_valid' : this.isValid,
      'last_aslot' : this.lastAslot,
      'last_confirmed_block_num' : this.lastConfirmedBlockNum,
      'pay_vb' : this.payVb,

      'signing_key': this.signingKey,
      'total_missed' : this.totalMissed,
      'total_votes' : this.totalVotes,
      'url' : this.url,
      'vote_id' : this.voteId,
      'witness_account' : this.witnessAccount,
    };

    return val;
  }
}