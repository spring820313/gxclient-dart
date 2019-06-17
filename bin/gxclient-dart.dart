import 'dart:convert';
import 'dart:io';
import '../lib/src/ecc/ecc.dart';
import '../lib/src/models/models.dart';
import '../lib/src/core/core.dart';
import '../lib/src/core/formatting.dart';
import '../lib/gxclient.dart';


void testEcc() {
  GXCPrivateKey privateKey = GXCPrivateKey.fromString(
      '5K1ravLd96RmdTf8rcGVhtJFS7hqvihwurfV3cdao8QVnkoEkXq');

  // Get the related GXC public key
  GXCPublicKey publicKey = privateKey.toGXCPublicKey();
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
  /*
  Account account = Account('1', null);
  print(account.toString());

  String s = '{\"name\": \"John Smith\",\"email\": \"john@example.com\"}';
  Map<String, dynamic> user = json.decode(s);
  print(user);

  Account account2 = Account.fromJson(account.toJson());
  print(account2);
   */
}

void testWssRpc() async{
  /*
  WssRpc rpc = WssRpc('wss://testnet.gxchain.org');

  Callable ab = GetAccountByName('test');

  final future = rpc.call(ab);
  future.then((news) {
    print(json.encode(news.result).toString());
    rpc.dispose();
  });
   */
  //final response = await rpc.call(ab);
  //print(json.encode(response.result).toString());
  Client client = Client('wss://testnet.gxchain.org');

  await sleep(const Duration(seconds:10));
  //rpc.dispose();
  client.close();
}

void testHttpRpc() async {
  //HttpRpc rpc = HttpRpc('https://testnet.gxchain.org');

  /*
  Callable ab = GetAccountByName('test');
  final response = await rpc.call(ab);
  if(response.containsKey("result")) {
    print(json.encode(response["result"]).toString());
    return;
  }
  print('result = null');
   */

  /*
  Callable ab = GetChainIDCall();
  final response = await rpc.call(ab);
  if(response.containsKey("result")) {
    print(json.encode(response["result"]).toString());
    return;
  }
  print('result = null');
   */

  Client client = Client('https://testnet.gxchain.org');
  /*
  final account = await client.getAccountByName('spring123');
  print(json.encode(account.toJson()).toString());
   */

  /*
  final assets = await client.lookupAssetSymbolsCall(List.from(['GXC']));
  print(json.encode(assets[0].toJson()).toString());
   */

  /*
  final block = await client.getBlock(100);
  print(json.encode(block.toJson()).toString());
   */

  int a = TransactionUtils.refBlockNum(0x12345678);

  int b = TransactionUtils.refBlockPrefix("00df5132f4a401281918632a2a3dd5084f44b50e");

  final global = await client.getDynamicGlobalProperties();
  print(json.encode(global.toJson()).toString());
}

void testTransfer() async {
  Client client = Client('https://testnet.gxchain.org');
  client.init();
  final from = await client.getAccountByName('spring123');
  final to = await client.getAccountByName('spring456');
  final assets = await client.lookupAssetSymbols(List.from(["GXC"]));

  final key = "5K1ravLd96RmdTf8rcGVhtJFS7hqvihwurfV3cdao8QVnkoEkXq";

  final amount = AssetAmount(10, assets[0].id);
  final fee = AssetAmount(0, assets[0].id);

  final k = from.active.keyAuths.auth.keys.toList()[0];
  final memoKey = to.options.memoKey;
  final memo = Memo(key, memoKey, "1234578912345678901234567890");

  final res = await client.transfer(key, from.id, to.id, amount, fee, memo);
  print(res.toString());
}

void testAes() {
  DateTime dt = DateTime.now().toUtc();
  print(dt.toIso8601String());
  print((dt.millisecondsSinceEpoch / 1000).round());
  var privKey = '5K1ravLd96RmdTf8rcGVhtJFS7hqvihwurfV3cdao8QVnkoEkXq';
  var pubKey = 'GXC7vr8Wre4UJgJz7H7GmYYGW7NEe6sxdmGhZPDUnHwmKnATrEBu9';
  var message = '我abc你de的';
  var nonce = '1234567890';

  var encryptedData = GhAes.encryptWithChecksum(privKey, pubKey, nonce, message);
  var hexEncrypted = bytesToHex(encryptedData);
  print(hexEncrypted);

  var plainText = GhAes.decryptWithChecksum(privKey, pubKey, nonce, hexEncrypted);
  print(plainText);
}

void main() {
  //testEcc();
  //testJson();
  //testWssRpc();
  //testHttpRpc();
  //testAes();
  testTransfer();
  print('Hello, World!');
}
