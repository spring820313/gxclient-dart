import 'graphene_id.dart';
import '../core/serialization.dart';
import '../core/encoder.dart';
import 'time.dart';

class DynamicGlobalProperties extends Serializable{
  GrapheneId id;
  int headBlockNumber;
  String headBlockID;
  Time time;
  GrapheneId currentWitness;
  Time nextMaintenanceTime;
  Time lastBudgetTime;
  int accountsRegisteredThisInterval;
  int dynamicFlags;
  String recentSlotsFilled;
  int lastIrreversibleBlockNum;
  int currentAslot;
  int witnessBudget;
  int recentlyMissedCount;

  DynamicGlobalProperties();

  factory DynamicGlobalProperties.fromJson(dynamic json) {
    if(!(json is Map)) {
      return null;
    }

    var d = DynamicGlobalProperties();
    GrapheneId id = GrapheneId.fromJson(json['id']);
    d.id = id;
    int headBlockNumber = json['head_block_number'] as int;
    d.headBlockNumber = headBlockNumber;
    String headBlockID = json['head_block_id'];
    d.headBlockID = headBlockID;
    Time time = Time.fromJson(json['time']);
    d.time = time;
    GrapheneId currentWitness = GrapheneId.fromJson(json['current_witness']);
    d.currentWitness = currentWitness;
    Time nextMaintenanceTime = Time.fromJson(json['next_maintenance_time']);
    d.nextMaintenanceTime = nextMaintenanceTime;
    Time lastBudgetTime = Time.fromJson(json['last_budget_time']);
    d.lastBudgetTime = lastBudgetTime;
    int accountsRegisteredThisInterval = json['accounts_registered_this_interval'] as int;
    d.accountsRegisteredThisInterval = accountsRegisteredThisInterval;
    int dynamicFlags = json['dynamic_flags'] as int;
    d.dynamicFlags = dynamicFlags;
    String recentSlotsFilled = json['recent_slots_filled'];
    d.recentSlotsFilled = recentSlotsFilled;
    int lastIrreversibleBlockNum = json['last_irreversible_block_num'] as int;
    d.lastIrreversibleBlockNum = lastIrreversibleBlockNum;
    int currentAslot = json['current_aslot'] as int;
    d.currentAslot = currentAslot;
    int witnessBudget = json['witness_budget'] as int;
    d.witnessBudget = witnessBudget;
    int recentlyMissedCount = json['recently_missed_count'] as int;
    d.recentlyMissedCount = recentlyMissedCount;

    return d;
  }

  @override
  bool serialize(Encoder encoder)  {
    return true;
  }

  @override
  dynamic toJson() {
    final val = <String, dynamic>{
      'id': this.id.toJson(),
      'head_block_number' : this.headBlockNumber,
      'head_block_id' : this.headBlockID,
      'time' : this.time.toJson(),
      'current_witness' : this.currentWitness.toJson(),

      'next_maintenance_time': this.nextMaintenanceTime.toJson(),
      'last_budget_time' : this.lastBudgetTime.toJson(),
      'accounts_registered_this_interval' : this.accountsRegisteredThisInterval,
      'dynamic_flags' : this.dynamicFlags,
      'recent_slots_filled' : this.recentSlotsFilled,
      'last_irreversible_block_num' : this.lastIrreversibleBlockNum,

      'current_aslot' : this.currentAslot,
      'witness_budget' : this.witnessBudget,
      'recently_missed_count' : this.recentlyMissedCount,
    };

    return val;
  }
}