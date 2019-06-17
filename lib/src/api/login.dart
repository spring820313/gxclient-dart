import 'call.dart';
import 'rpc_call.dart';
import 'api_type.dart';

class LoginCall extends Callable {
  final String username, pass;

  LoginCall(this.username, this.pass);

  @override
  Call toCall(int id, bool httpCall) {
    return Call(ApiType.API_LOGIN, id, RPC.CALL_LOGIN, List<dynamic>.from([username, pass]), httpCall);
  }
}

class RequestApiTypeCall extends Callable {
  final String requestedApiMethod;

  RequestApiTypeCall(this.requestedApiMethod);

  @override
  Call toCall(int id, bool httpCall) {
    return Call(ApiType.API_LOGIN, id, requestedApiMethod, [], httpCall);
  }
}

class GetApiByNameCall extends Callable {
  final String name;

  GetApiByNameCall(this.name);

  @override
  Call toCall(int id, bool httpCall) {
    return Call(ApiType.API_LOGIN, id, RPC.CALL_GET_API_BY_NAME, List<dynamic>.from([name]), httpCall);
  }
}