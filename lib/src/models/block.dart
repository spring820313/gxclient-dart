import '../core/serialization.dart';
import '../core/encoder.dart';
import 'time.dart';

class Block extends Serializable{
  String transactionMerkleRoot;
  String previous;
  Time timestamp;
  String witness;
  String witnessSignature;

  Block(this.transactionMerkleRoot, this.previous,
      this.timestamp, this.witness, this.witnessSignature);

  factory Block.fromJson(dynamic json) {
    if(!(json is Map)) {
      return null;
    }
    String transactionMerkleRoot = json['transaction_merkle_root'];
    String previous = json['previous'];
    Time timestamp = Time.fromJson(json['timestamp']);
    String witness = json['witness'];
    String witnessSignature = json['witness_signature'];
    return Block(transactionMerkleRoot, previous, timestamp, witness, witnessSignature);
  }

  @override
  bool serialize(Encoder encoder)  {
    return true;
  }

  @override
  dynamic toJson() {
    final val = <String, dynamic>{
      'transaction_merkle_root': this.transactionMerkleRoot,
      'previous' : this.previous,
      'timestamp' : this.timestamp.toJson(),
      'witness' : this.witness,
      'witness_signature' : this.witnessSignature,
    };

    return val;
  }
}