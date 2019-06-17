import 'dart:convert';
import 'package:http/http.dart' as http;
import '../api/api.dart';
import 'base_rpc.dart';

class HttpRpc extends BaseRpc {
  int _currentId = 0;
  final String endpoint;
  HttpRpc(this.endpoint);

  @override
  void connect() async {}

  @override
  void dispose() {}

  @override
  Future<dynamic> call(Callable callable) async{
    try {
      var call = callable.toCall(++_currentId, true);
      var b = json.encode(call);
      print(b.toString());
      var response = await http.post(endpoint, body: b);
      return json.decode(response.body);
    } catch (e) {
      e.isFetchError = true;
      throw e;
    }
  }
}