import 'graphene_id.dart';
import 'vote.dart';

import '../core/serialization.dart';
import '../core/encoder.dart';

class AccountOptions extends Serializable{
  String memoKey;
  GrapheneId votingAccount;
  int numWitness;
  int numCommittee;
  Votes votes;
  List<dynamic> extensions;

  AccountOptions(this.memoKey, this.votingAccount, this.numWitness,
      this.numCommittee, this.votes);

  factory AccountOptions.fromJson(dynamic json) {
    if(!(json is Map)) {
      return null;
    }
    String memoKey = json['memo_key'] as String;
    GrapheneId votingAccount = GrapheneId(json['voting_account']);
    int numWitness = json['num_witness'] as int;
    int numCommittee = json['num_committee'] as int;
    Votes votes = Votes.fromJson(json['votes']);

    final opt = AccountOptions(memoKey, votingAccount, numWitness,
        numCommittee, votes);
    opt.extensions = List();
    return opt;
  }

  @override
  bool serialize(Encoder encoder)  {
    encoder.encodePubKey(this.memoKey);
    this.votingAccount.serialize(encoder);
    encoder.encodeUint16(this.numWitness);
    encoder.encodeUint16(this.numCommittee);
    this.votes.serialize(encoder);
    encoder.encodeVarint(0);
    return true;
  }

  @override
  dynamic toJson() {
    final val = <String, dynamic>{
      'memo_key': this.memoKey,
      'voting_account' : this.votingAccount.toJson(),
      'num_witness' : this.numWitness,
      'num_committee' : this.numCommittee,
      'votes' : this.votes.toJson(),
      'extensions' : [],
    };

    return val;
  }
}