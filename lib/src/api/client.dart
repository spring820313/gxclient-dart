import 'dart:convert';
import 'package:http/http.dart' as http;

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
    if(this.baseRpc is WssRpc) {
      await login("", "");
      ApiType.API_DATABASE = await getApiIdByName("database");
      ApiType.API_HISTORY = await getApiIdByName("history");
      ApiType.API_NETWORK_BROADCAST = await getApiIdByName("network_broadcast");
    }
    this.chainID = await getChainID();
  }

  void close() {
    if(this.baseRpc != null) {
      this.baseRpc.dispose();
    }
  }

  Future<dynamic> login(String username, String pass) async {
    if(this.baseRpc == null) {
      return null;
    }
    Callable ab = LoginCall(username, pass);
    final response = await baseRpc.call(ab);
    if(!response.containsKey("result")) {
      return null;
    }

    return response["result"];
  }

  Future<int> getApiIdByName(String name) async {
    if(this.baseRpc == null) {
      return null;
    }
    Callable ab = GetApiIdByNameCall(name);
    final response = await baseRpc.call(ab);
    if(!response.containsKey("result")) {
      return null;
    }

    return response["result"] as int;
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

  Future<ContractAccountProperties> getContractAccountByName(String name) async {
    if(this.baseRpc == null) {
      return null;
    }
    Callable ab = GetAccountByNameCall(name);
    final response = await baseRpc.call(ab);
    if(!response.containsKey("result")) {
      return null;
    }

    print(json.encode(response["result"]).toString());
    var a = ContractAccountProperties.fromJson(response["result"]);

    return a;
  }

  Future<Abi> getContractABI(String name) async {
    final account = await getContractAccountByName(name);
    if(account == null) {
      return null;
    }
    return account.abi;
  }

  Future<List<Table>> getContractTable(String name) async {
    final abi = await getContractABI(name);
    if(abi == null) {
      return null;
    }
    return abi.tables;
  }

  Future<List<Account>> getAccounts(List<String> names) async {
    final accounts = List<Account>();
    for(var name in names) {
      final account = await getAccountByName(name);
      accounts.add(account);
    }
    return accounts;
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

  Future<List<ObjectParameters>> getObjects(List<String> objIds) async {
    if(this.baseRpc == null) {
      return null;
    }
    Callable ab = GetObjectsCall(objIds);
    final response = await baseRpc.call(ab);

    if(!response.containsKey("result")) {
      return null;
    }

    List<ObjectParameters> result = List();
    for(var r in response["result"]) {
      final op = ObjectParameters.fromJson(r);
      result.add(op);
    }
    return result;
  }

  Future<dynamic> serializeContractCallArgs(String contractName, String method, dynamic parameters) async {
    if(this.baseRpc == null) {
      return null;
    }
    Callable ab = SerializeContractCallArgsCall(contractName, method, parameters);
    final response = await baseRpc.call(ab);
    if(!response.containsKey("result")) {
      return null;
    }

    return response["result"];
  }

  Future<dynamic> getTableRows(String contractName, String tableName, int lowerBound, int upperBound) async {
    if(this.baseRpc == null) {
      return null;
    }
    Callable ab = GetTableRowsCall(contractName, tableName, lowerBound, upperBound);
    final response = await baseRpc.call(ab);
    if(!response.containsKey("result")) {
      return null;
    }

    return response["result"];
  }

  Future<dynamic> getTableObjects(String contractName, String tableName, TableRowsParams params) async {
    if(this.baseRpc == null) {
      return null;
    }
    Callable ab = GetTableRowsExCall(contractName, tableName, params);
    final response = await baseRpc.call(ab);
    if(!response.containsKey("result")) {
      return null;
    }

    return response["result"];
  }

  Future<Witness> getWitnessByAccount(String accountId) async {
    if(this.baseRpc == null) {
      return null;
    }
    Callable ab = GetWitnessByAccountCall(accountId);
    final response = await baseRpc.call(ab);

    if(!response.containsKey("result")) {
      return null;
    }

    var wi = Witness.fromJson(response["result"]);
    return wi;
  }

  Future<List<AssetAmount>> getAccountBalances(String accountId, List<String> assetIDs) async {
    if(this.baseRpc == null) {
      return null;
    }
    Callable ab = GetAccountBalancesCall(accountId, assetIDs);
    final response = await baseRpc.call(ab);

    if(!response.containsKey("result")) {
      return null;
    }

    var wi = AssetAmount.toList(response["result"]);
    return wi;
  }

  Future<List<AssetAmount>> getNamedAccountBalances(String account, List<String> assetIDs) async {
    if(this.baseRpc == null) {
      return null;
    }
    Callable ab = GetNamedAccountBalancesCall(account, assetIDs);
    final response = await baseRpc.call(ab);

    if(!response.containsKey("result")) {
      return null;
    }

    var wi = AssetAmount.toList(response["result"]);
    return wi;
  }

  Future<Committee> getCommitteeMemberByAccount(String accountId) async {
    if(this.baseRpc == null) {
      return null;
    }
    Callable ab = GetCommitteeMemberByAccountCall(accountId);
    final response = await baseRpc.call(ab);

    if(!response.containsKey("result")) {
      return null;
    }

    var co = Committee.fromJson(response["result"]);
    return co;
  }

  Future<List<String>> getVoteIdsByAccounts(List<String> accountNames) async {
    final ids = List<String>();

    final accounts = await getAccounts(accountNames);
    if(accounts == null) {
      return ids;
    }

    for(var account in accounts) {
      final wi = await getWitnessByAccount(account.id.toString());
      if(wi != null) {
        ids.add(wi.voteId);
      }

      final co = await getCommitteeMemberByAccount(account.id.toString());
      if(co != null) {
        ids.add(co.voteId);
      }
    }

    return ids;
  }

  Future<List<List<String>>> getAccountsByPublicKeys(List<String> publicKeys) async {
    final accounts = List<List<String>>();

    if(this.baseRpc == null) {
      return null;
    }
    Callable ab = GetAccountsByPublicKeysCall(publicKeys);
    final response = await baseRpc.call(ab);

    if(!response.containsKey("result")) {
      return null;
    }

    for(var r in response["result"]) {
      var a = strsToList(r);
      accounts.add(a);
    }
    return accounts;
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
    DateTime t = DateTime.parse("2019-06-17T03:13:03Z");
    final test = t.add(new Duration(minutes: 10));
    final a = test.millisecondsSinceEpoch;
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

  Future<dynamic> register(String account, String activeKey, String faucet, [String ownerKey, String memoKey]) async {
    final accountInfo = RegisterAccountInfo(account, activeKey, ownerKey, memoKey);
    final regAccount = RegisterAccount(accountInfo);
    final data = regAccount.toJson();

    final b = json.encode(data);

    try {
      var response = await http.post(faucet, body: b);
      return json.decode(response.body);
    } catch (e) {
      e.isFetchError = true;
      throw e;
    }
  }

  Future<dynamic> vote(String key, String from, List<String> accounts, [String proxyAccount, String feeAsset = 'GXC']) async {
    final myAccount = await getAccountByName(from);
    if(myAccount == null) {
      throw 'Bad Parameter ';
    }
    final myAccountId = myAccount.id;

    GrapheneId votingAccountId = null;
    if(proxyAccount == null) {
      votingAccountId = GrapheneId("1.2.5");
    } else {
      final votingAccount = await getAccountByName(proxyAccount);
      if(votingAccount == null) {
        throw 'Bad Parameter ';
      }
      votingAccountId = GrapheneId(votingAccount.id.toString());
    }

    List<String> voteIds = await getVoteIdsByAccounts(accounts);
    if(voteIds == null) {
      throw 'Bad Parameter ';
    }

    List<Asset> assets = await lookupAssetSymbols(List.from([feeAsset]));
    if(assets == null || assets.length <= 0) {
      throw 'Bad Parameter ';
    }
    final feeAssetId = assets[0].id;

    final objs = await getObjects(List.from(["2.0.0"]));
    if(objs == null || objs.length != 1) {
      throw 'Exception occurred ';
    }

    final maximumCommitteeCount = objs[0].parameters.maximumCommitteeCount;
    final maximumWitnessCount = objs[0].parameters.maximumWitnessCount;

    var newOptions = myAccount.options;
    for(var voteId in voteIds) {
      final vote = VoteID.fromString(voteId);
      newOptions.votes.add(vote);
    }

    newOptions.votes.sort();

    var numCommitee = 0;
    var numWitness = 0;
    for(var voteId in newOptions.votes.ids) {
      final typ = voteId.typ;
      if(typ == 0) {
        numCommitee += 1;
      }
      if(typ == 1) {
        numWitness += 1;
      }
    }

    newOptions.numWitness = numWitness < maximumWitnessCount ? numWitness : maximumWitnessCount;
    newOptions.numCommittee = numCommitee < maximumCommitteeCount ? numCommitee : maximumCommitteeCount;
    newOptions.votingAccount = votingAccountId;

    var fee = AssetAmount(0, feeAssetId);
    final op = AccountUpdateOperation(myAccountId, null, newOptions, null, fee);

    final List<AssetAmount> fees =  await getRequiredFee(fee.assetID.toString(), List<Operation>.from([op]));
    if(fees == null || fees.length <= 0) {
      return null;
    }
    op.fee.amount = fees[0].amount;

    var ops = Operations();
    ops.add(op);

    final signedTransaction = await sign(List<String>.from([key]), ops);

    return broadcastTransaction(signedTransaction.tx);
  }

  Future<dynamic> callContract(String key, String from, String contractName, String method, dynamic parameters, [AssetAmount amount, String feeAsset = 'GXC']) async {
    final myAccount = await getAccountByName(from);
    if(myAccount == null) {
      throw 'Bad Parameter ';
    }
    final myAccountId = myAccount.id;

    final contract = await getContractAccountByName(contractName);
    if(contract == null) {
      throw 'Bad Parameter ';
    }
    final contractId = contract.id;

    final data = await serializeContractCallArgs(contractName, method, parameters);
    if(data == null) {
      throw 'Exception occurred ';
    }

    List<Asset> assets = await lookupAssetSymbols(List.from([feeAsset]));
    if(assets == null || assets.length <= 0) {
      throw 'Bad Parameter ';
    }
    final feeAssetId = assets[0].id;

    var fee = AssetAmount(0, feeAssetId);
    final op = CallContractOperation(myAccountId, contractId, amount, fee, method, data);

    final List<AssetAmount> fees =  await getRequiredFee(feeAssetId.toString(), List<Operation>.from([op]));
    if(fees == null || fees.length <= 0) {
      return null;
    }
    op.fee.amount = fees[0].amount;

    var ops = Operations();
    ops.add(op);

    final signedTransaction = await sign(List<String>.from([key]), ops);

    return broadcastTransaction(signedTransaction.tx);
  }

  Future<dynamic> createContract(String key, String from, String contractName, String code, Abi abi, String vmType, String vmVersion, [String feeAsset = 'GXC']) async {
    final myAccount = await getAccountByName(from);
    if(myAccount == null) {
      throw 'Bad Parameter ';
    }
    final myAccountId = myAccount.id;

    if(code == null || code.length <= 0) {
      throw 'Bad Parameter ';
    }

    List<Asset> assets = await lookupAssetSymbols(List.from([feeAsset]));
    if(assets == null || assets.length <= 0) {
      throw 'Bad Parameter ';
    }
    final feeAssetId = assets[0].id;

    var fee = AssetAmount(0, feeAssetId);
    final op = CreateContractOperation(myAccountId, contractName, vmType, vmVersion, code, abi, fee);

    final List<AssetAmount> fees =  await getRequiredFee(feeAssetId.toString(), List<Operation>.from([op]));
    if(fees == null || fees.length <= 0) {
      return null;
    }
    op.fee.amount = fees[0].amount;

    var ops = Operations();
    ops.add(op);

    final signedTransaction = await sign(List<String>.from([key]), ops);

    return broadcastTransaction(signedTransaction.tx);
  }

  Future<dynamic> updateContract(String key, String from, String contractName, String code, Abi abi, [String newOwner, String feeAsset = 'GXC']) async {
    final myAccount = await getAccountByName(from);
    if(myAccount == null) {
      throw 'Bad Parameter ';
    }
    final myAccountId = myAccount.id;

    if(code == null || code.length <= 0) {
      throw 'Bad Parameter ';
    }

    final contract = await getContractAccountByName(contractName);
    if(contract == null) {
      throw 'Bad Parameter ';
    }
    final contractId = contract.id;

    GrapheneId newOwnerId = null;
    if(newOwner != null) {
      final newAccount = await getAccountByName(newOwner);
      if(newAccount == null) {
        throw 'Bad Parameter ';
      }
      newOwnerId = newAccount.id;
    }

    List<Asset> assets = await lookupAssetSymbols(List.from([feeAsset]));
    if(assets == null || assets.length <= 0) {
      throw 'Bad Parameter ';
    }
    final feeAssetId = assets[0].id;

    var fee = AssetAmount(0, feeAssetId);
    final op = UpdateContractOperation(myAccountId, newOwnerId, contractId, code, abi, fee);

    final List<AssetAmount> fees =  await getRequiredFee(feeAssetId.toString(), List<Operation>.from([op]));
    if(fees == null || fees.length <= 0) {
      return null;
    }
    op.fee.amount = fees[0].amount;

    var ops = Operations();
    ops.add(op);

    final signedTransaction = await sign(List<String>.from([key]), ops);

    return broadcastTransaction(signedTransaction.tx);
  }

  Future<SignedProxyTransferParams> getSignedProxyTransferParams(String key, String from, String to, String proxy, AssetAmount amount, int percentage, String memo) async {
    final fromAccount = await getAccountByName(from);
    if (fromAccount == null) {
      throw 'Bad Parameter ';
    }
    final fromAccountId = fromAccount.id;

    final toAccount = await getAccountByName(to);
    if (toAccount == null) {
      throw 'Bad Parameter ';
    }
    final toAccountId = toAccount.id;

    final proxyAccount = await getAccountByName(proxy);
    if (proxyAccount == null) {
      throw 'Bad Parameter ';
    }
    final proxyAccountId = proxyAccount.id;

    final props = await getDynamicGlobalProperties();
    if(props == null) {
      throw 'Exception occurred ';
    }

    final expiration = props.time.dt.add(new Duration(minutes: 10));
    final signedProxyTransferParams = SignedProxyTransferParams(fromAccountId, toAccountId, proxyAccountId,
        amount, percentage, memo, Time(expiration));
    signedProxyTransferParams.sign(key);
    return signedProxyTransferParams;
  }

  Future<dynamic> proxyTransfer(String key, String proxyMemo, SignedProxyTransferParams requestParams, [String feeAsset = 'GXC']) async {
    List<Asset> assets = await lookupAssetSymbols(List.from([feeAsset]));
    if(assets == null || assets.length <= 0) {
      throw 'Bad Parameter ';
    }
    final feeAssetId = assets[0].id;

    var fee = AssetAmount(0, feeAssetId);
    final op = ProxyTransferOperation(proxyMemo, requestParams, fee);

    final List<AssetAmount> fees =  await getRequiredFee(feeAssetId.toString(), List<Operation>.from([op]));
    if(fees == null || fees.length <= 0) {
      return null;
    }
    op.fee.amount = fees[0].amount;

    var ops = Operations();
    ops.add(op);

    final signedTransaction = await sign(List<String>.from([key]), ops);

    return broadcastTransaction(signedTransaction.tx);
  }

}