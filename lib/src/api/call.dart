import './api_type.dart';
import './rpc_call.dart';

class Call {
  static Map<int, int> apiIds = {};

  int id;
  int apiId = ApiType.API_NONE;
  String method = 'call';
  String methodToCall;
  List<dynamic> params;
  bool httpCall = false;

  Call(this.apiId, this.id, this.methodToCall, this.params, this.httpCall);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if(httpCall) {
      data['id'] = id;
      data['method'] = methodToCall;
      data['params'] = params;
    } else {
      data['id'] = id;
      data['method'] = method;
      data['params'] = [apiId, methodToCall, params];
    }
    return data;
  }
}

abstract class Callable {
  Call toCall(int id, bool httpCall);
}



