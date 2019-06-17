import 'dart:convert';

import '../transport/transport.dart';
import '../core/core.dart';
import '../models/models.dart';
import 'api.dart';

class Client {
  final String url;
  String chainID;
  BaseRpc baseRpc;

  Client(this.url) {
    if(this.url.startsWith('http') || this.url.startsWith('https')) {
      this.baseRpc = HttpRpc(this.url);
    } else {
      this.baseRpc = WssRpc(this.url);
    }
    this.baseRpc.connect();
  }

  void init() async{
    this.chainID = await getChainID();
  }

  void close() {
    if(this.baseRpc != null) {
      this.baseRpc.dispose();
    }
  }

  Future<List<AssetAmount>> getRequiredFee(String assetID, List<Operation> operations) async {
    if(this.baseRpc == null) {
      return null;
    }
    Callable ab = GetRequiredFeeCall(assetID, operations);
    final response = await baseRpc.call(ab);
    if(!response.containsKey("result")) {
      return null;
    }
    List<AssetAmount> result = List();
    for(var r in response["result"]) {
      var a = AssetAmount.fromJson(r);
      result.add(a);
    }
    return result;
  }

  Future<Account> getAccountByName(String name) async {
    if(this.baseRpc == null) {
      return null;
    }
    Callable ab = GetAccountByNameCall(name);
    final response = await baseRpc.call(ab);
    if(!response.containsKey("result")) {
      return null;
    }

    print(json.encode(response["result"]).toString());
    var a = Account.fromJson(response["result"]);

    return a;
  }

  Future<List<Asset>> lookupAssetSymbols(List<String> names) async {
    if(this.baseRpc == null) {
      return null;
    }
    Callable ab = LookupAssetSymbolsCall(names);
    final response = await baseRpc.call(ab);
    if(!response.containsKey("result")) {
      return null;
    }

    List<Asset> result = List();
    for(var r in response["result"]) {
      var a = Asset.fromJson(r);
      result.add(a);
    }
    return result;
  }

  Future<dynamic> broadcastTransaction(Transaction tx) async {
    if(this.baseRpc == null) {
      return null;
    }
    Callable ab = BroadcastTransactionCall(tx);
    final response = await baseRpc.call(ab);

    return response;
  }

  Future<Block> getBlock(int blockNum) async {
    if(this.baseRpc == null) {
      return null;
    }
    Callable ab = GetBlockCall(blockNum);
    final response = await baseRpc.call(ab);

    if(!response.containsKey("result")) {
      return null;
    }

    var b = Block.fromJson(response["result"]);
    return b;
  }

  Future<String> getChainID() async {
    if(this.baseRpc == null) {
      return null;
    }
    Callable ab = GetChainIDCall();
    final response = await baseRpc.call(ab);

    if(!response.containsKey("result")) {
      return null;
    }

    final chainId = response["result"];
    return chainId;
  }

  Future<DynamicGlobalProperties> getDynamicGlobalProperties() async {
    if(this.baseRpc == null) {
      return null;
    }
    Callable ab = GetDynamicGlobalPropertiesCall();
    final response = await baseRpc.call(ab);

    if(!response.containsKey("result")) {
      return null;
    }

    var d = DynamicGlobalProperties.fromJson(response["result"]);
    return d;
  }

  Future<SignedTransaction> sign(List<String> wifs, Operations operations) async {
    final props = await getDynamicGlobalProperties();
    if(props == null) {
      throw "failed to get dynamic global properties";
    }

    final block = await getBlock(props.lastIrreversibleBlockNum);
    if(block == null) {
      throw "failed to get block";
    }

    final refBlockPrefix = TransactionUtils.refBlockPrefix(block.previous);
    //DateTime t = DateTime.parse("2019-06-17T03:13:03Z");
    final expiration = props.time.dt.add(new Duration(minutes: 10));

    final tx = Transaction.Default();
    tx.refBlockNum = TransactionUtils.refBlockNum(props.lastIrreversibleBlockNum - 1 & 0xffff);
    tx.refBlockPrefix = refBlockPrefix;
    tx.expiration = expiration;
    tx.operations = operations;

    final stx = SignedTransaction(tx);
    final ret = stx.sign(wifs, chainID);
    if(ret == false) return null;

    return stx;
  }

  Future<dynamic> transfer(String key, GrapheneId from, GrapheneId to, AssetAmount amount, AssetAmount fee, Memo memo) async {
    final op = TransferOperation(from, to, amount, fee, memo);
    String assetID = fee.assetID.toString();

    final List<AssetAmount> assets =  await getRequiredFee(assetID, List<Operation>.from([op]));
    if(assets == null || assets.length <= 0) {
      return null;
    }
    op.fee.amount = assets[0].amount;

    var ops = Operations();
    ops.add(op);

    final signedTransaction = await sign(List<String>.from([key]), ops);

    return broadcastTransaction(signedTransaction.tx);
  }
}