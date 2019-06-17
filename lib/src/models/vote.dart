import '../core/serialization.dart';
import '../core/encoder.dart';

class VoteID extends Serializable{
  int typ;
  int instance;

  VoteID(this.typ, this.instance);

  VoteID.fromString(String id) {
    final ids = id.split(":");
    if(ids.length != 2) {
      throw 'Bad parameter';
    }
    final t = int.tryParse(ids[0]);
    if(t == null) {
      throw 'Bad parameter';
    }

    final i = int.tryParse(ids[1]);
    if(i == null) {
      throw 'Bad parameter';
    }
    this.typ = t;
    this.instance = i;
  }

  @override
  bool serialize(Encoder encoder)  {
    final bin = (this.typ & 0xff) | (this.instance << 8);
    encoder.encodeUint32(bin);
    return true;
  }

  @override
  dynamic toJson() {
    final val = "${this.typ}:${this.instance}";
    return val;
  }
}

class Votes extends Serializable{
  List<VoteID> ids = List();

  Votes();

  factory Votes.fromJson(dynamic json) {
    if(!(json is List)) {
      return null;
    }

    Votes ids = Votes();
    for(var x in json) {
      final s = x as String;

      VoteID id = VoteID.fromString(s);
      ids.ids.add(id);
    }
    return ids;
  }

  bool serialize(Encoder encoder)  {
    encoder.encodeVarint(ids.length);
    for(var x in ids) {
      x.serialize(encoder);
    }
    return true;
  }

  dynamic toJson() {
    List<dynamic> result = List();
    for(var id in ids) {
      result.add(id.toJson());
    }

    return result;
  }

  void add(VoteID id) {
    ids.add(id);
  }
}