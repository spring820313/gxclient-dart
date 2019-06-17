import 'call.dart';
import 'rpc_call.dart';
import 'api_type.dart';

class GetMarketHistoryCall extends Callable {
  final String username, pass;

  GetMarketHistoryCall(this.username, this.pass);

  @override
  Call toCall(int id, bool httpCall) {
    return Call(ApiType.API_HISTORY, id, RPC.CALL_GET_MARKET_HISTORY, List<dynamic>.from([username, pass]), httpCall);
  }
}