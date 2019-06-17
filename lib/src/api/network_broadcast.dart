import 'call.dart';
import 'rpc_call.dart';
import '../core/transaction.dart';
import 'api_type.dart';

class BroadcastTransactionCall extends Callable {
  final Transaction tx;

  BroadcastTransactionCall(this.tx);

  @override
  Call toCall(int id, bool httpCall) {
    if(httpCall)
      return Call(ApiType.API_NETWORK_BROADCAST, id, "call", List<dynamic>.from([2, RPC.CALL_BROADCAST_TRANSACTION, List<dynamic>.from([tx.toJson()])]), true);
    return Call(ApiType.API_NETWORK_BROADCAST, id, RPC.CALL_BROADCAST_TRANSACTION, List<dynamic>.from([tx.toJson()]), false);
  }
}

class BroadcastTransactionSynchronousCall extends Callable {
  final Transaction tx;

  BroadcastTransactionSynchronousCall(this.tx);

  @override
  Call toCall(int id, bool httpCall) {
    if(httpCall)
      return Call(ApiType.API_NETWORK_BROADCAST, id, "call", List<dynamic>.from([2, RPC.CALL_BROADCAST_TRANSACTION_SYNCHRONOUS, List<dynamic>.from([tx.toJson()])]), true);
    return Call(ApiType.API_NETWORK_BROADCAST, id, RPC.CALL_BROADCAST_TRANSACTION_SYNCHRONOUS, List<dynamic>.from([tx.toJson()]), false);
  }
}
