import 'dart:core';

import '../core/serialization.dart';
import '../core/encoder.dart';

class Committee extends Serializable{
  String id;
  bool isValid;
  String payVb;
  int totalVotes;
  String url;
  String voteId;

  Committee();

  factory Committee.fromJson(dynamic json) {
    if(!(json is Map)) {
      return null;
    }

    final co = Committee();
    co.id = json['id'];
    co.isValid = json['is_valid'] as bool;
    co.payVb = json['pay_vb'];
    co.totalVotes = json['total_votes'];
    co.url = json['url'];
    co.voteId = json['vote_id'];
    return co;
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
      'pay_vb' : this.payVb,
      'total_votes' : this.totalVotes,
      'url' : this.url,
      'vote_id' : this.voteId,
    };

    return val;
  }
}