import 'dart:convert';
import 'package:http/http.dart' as http;
import '../api/api.dart';

class HttpRpc {
  int _currentId = 0;
  final String endpoint;
  HttpRpc(this.endpoint) {

  }

  Future<dynamic> call(Callable callable) async{
    try {
      var call = callable.toCall(++_currentId);
      var b = json.encode(call);
      var response = await http.post(endpoint, body: b);
      return json.decode(response.body);
    } catch (e) {
      e.isFetchError = true;
      throw e;
    }
  }
}