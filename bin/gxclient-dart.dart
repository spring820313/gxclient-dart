import 'dart:convert';

import '../lib/src/ecc/ecc.dart';
import '../lib/src/models/account.dart';
import '../lib/gxclient.dart';

void testEcc() {
  GXCPrivateKey privateKey = GXCPrivateKey.fromString(
      '5KQwrPbwdL6PhXujxW37FSSQZ1JiwsST4cqQzDeyXtP79zkvFD3');

  // Get the related GXC public key
  GXCPublicKey publicKey = privateKey.toEOSPublicKey();
  // Print the GXC public key
  print(publicKey.toString());

  // Going to sign the data
  String data = 'data';

  // Sign
  GXCSignature signature = privateKey.signString(data);
  // Print the GXC signature
  print(signature.toString());

  // Verify the data using the signature
  signature.verify(data, publicKey);
}

void testJson() {
  Account account = Account('1', null);
  print(account.toString());

  String s = '{\"name\": \"John Smith\",\"email\": \"john@example.com\"}';
  Map<String, dynamic> user = json.decode(s);
  print(user);

  Account account2 = Account.fromJson(account.toJson());
  print(account2);
}

void testWssRpc() async{
  WssRpc rpc = WssRpc();

  Callable ab = GetAccountByName('test');
  /*
  final future = rpc.call(ab);
  future.then((news) {
    print(json.encode(news.result).toString());
    rpc.dispose();
  });
   */
  final response = await rpc.call(ab);
  print(json.encode(response.result).toString());
  rpc.dispose();
}

void testHttpRpc() async {
  HttpRpc rpc = HttpRpc('https://eu.nodes.bitshares.ws');

  Callable ab = GetAccountByName('test');
  final response = await rpc.call(ab);
  if(response.containsKey("result")) {
    print(json.encode(response["result"]).toString());
    return;
  }
  print('result = null');
}

void main() {
  //testEcc();
  //testJson();
  testWssRpc();
  //testHttpRpc();
  print('Hello, World!');
}
