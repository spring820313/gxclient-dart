import 'dart:convert';

import 'call.dart';
import 'rpc_call.dart';
import 'api_type.dart';
import '../core/core.dart';
import '../models/models.dart';

class GetChainIDCall extends Callable {
  GetChainIDCall();

  @override
  Call toCall(int id, bool httpCall) {
    return Call(ApiType.API_DATABASE, id, RPC.CALL_GET_CHAIN_ID, List<dynamic>.from([]), httpCall);
  }
}

class GetAccountByNameCall extends Callable {
  final String name;

  GetAccountByNameCall(this.name);

  @override
  Call toCall(int id, bool httpCall) {
    return Call(ApiType.API_DATABASE, id, RPC.CALL_GET_ACCOUNT_BY_NAME, List<dynamic>.from([name]),httpCall);
  }
}

class LookupAssetSymbolsCall extends Callable {
  List<String> symbols;

  LookupAssetSymbolsCall(this.symbols);

  @override
  Call toCall(int id, bool httpCall) {
    return Call(ApiType.API_DATABASE, id, RPC.CALL_LOOKUP_ASSET_SYMBOLS, List<dynamic>.from([symbols]),httpCall);
  }
}

class GetRequiredFeeCall extends Callable {
  final String assetID;
  List<dynamic> ops;

  GetRequiredFeeCall(this.assetID, List<Operation> operations) {
    ops = List<dynamic>();
    for(var o in operations) {
      ops.add(OperationTuple(o.opType(), o).toJson());
    }
  }

  @override
  Call toCall(int id, bool httpCall) {
    return Call(ApiType.API_DATABASE, id, RPC.CALL_GET_REQUIRED_FEES, List<dynamic>.from([ops, assetID]),httpCall);
  }
}

class GetBlockCall extends Callable {
  int blockNum;

  GetBlockCall(this.blockNum);

  @override
  Call toCall(int id, bool httpCall) {
    return Call(ApiType.API_DATABASE, id, RPC.CALL_GET_BLOCK, List<dynamic>.from([blockNum]),httpCall);
  }
}

class GetDynamicGlobalPropertiesCall extends Callable {
  GetDynamicGlobalPropertiesCall();

  @override
  Call toCall(int id, bool httpCall) {
    return Call(ApiType.API_DATABASE, id, RPC.CALL_GET_DYNAMIC_GLOBAL_PROPERTIES, List<dynamic>.from([]),httpCall);
  }
}

class GetObjectsCall extends Callable {
  List<String> objIds;
  GetObjectsCall(this.objIds);

  @override
  Call toCall(int id, bool httpCall) {
    return Call(ApiType.API_DATABASE, id, RPC.CALL_GET_OBJECTS, List<dynamic>.from([objIds]),httpCall);
  }
}

class GetWitnessByAccountCall extends Callable {
  String accountId;
  GetWitnessByAccountCall(this.accountId);

  @override
  Call toCall(int id, bool httpCall) {
    return Call(ApiType.API_DATABASE, id, RPC.CALL_GET_WITNESS_BY_ACCOUNT, List<dynamic>.from([accountId]),httpCall);
  }
}

class GetCommitteeMemberByAccountCall extends Callable {
  String accountId;
  GetCommitteeMemberByAccountCall(this.accountId);

  @override
  Call toCall(int id, bool httpCall) {
    return Call(ApiType.API_DATABASE, id, RPC.CALL_GET_COMMITTEE_MEMBER_BY_ACCOUNT, List<dynamic>.from([accountId]),httpCall);
  }
}

class SerializeContractCallArgsCall extends Callable {
  String contractName;
  String method;
  dynamic parameters;
  SerializeContractCallArgsCall(this.contractName, this.method, this.parameters);

  @override
  Call toCall(int id, bool httpCall) {
    final params = this.parameters == null ? "{}" : json.encode(parameters);
    return Call(ApiType.API_DATABASE, id, RPC.CALL_GET_SERIALIZE_CONTRACT_CALL_ARGS, List<dynamic>.from([contractName, method, params]),httpCall);
  }
}

class GetTableRowsCall extends Callable {
  String contractName;
  String tableName;
  int lowerBound;
  int upperBound;
  GetTableRowsCall(this.contractName, this.tableName, this.lowerBound, this.upperBound);

  @override
  Call toCall(int id, bool httpCall) {
    return Call(ApiType.API_DATABASE, id, RPC.CALL_GET_TABLE_ROWS, List<dynamic>.from([contractName, tableName, lowerBound, upperBound]),httpCall);
  }
}

class GetTableRowsExCall extends Callable {
  String contractName;
  String tableName;
  TableRowsParams params;
  GetTableRowsExCall(this.contractName, this.tableName, this.params);

  @override
  Call toCall(int id, bool httpCall) {
    return Call(ApiType.API_DATABASE, id, RPC.CALL_GET_TABLE_ROWS_EX, List<dynamic>.from([contractName, tableName, params.toJson()]),httpCall);
  }
}

class GetAccountBalancesCall extends Callable {
  String accountID;
  List<String> assetsIDs;

  GetAccountBalancesCall(this.accountID, this.assetsIDs);

  @override
  Call toCall(int id, bool httpCall) {
    return Call(ApiType.API_DATABASE, id, RPC.CALL_GET_ACCOUNT_BALANCES, List<dynamic>.from([accountID, assetsIDs]),httpCall);
  }
}

class GetNamedAccountBalancesCall extends Callable {
  String account;
  List<String> assetsIDs;

  GetNamedAccountBalancesCall(this.account, this.assetsIDs);

  @override
  Call toCall(int id, bool httpCall) {
    return Call(ApiType.API_DATABASE, id, RPC.CALL_GET_NAMED_ACCOUNT_BALANCES, List<dynamic>.from([account, assetsIDs]),httpCall);
  }
}

class GetAccountsByPublicKeysCall extends Callable {
  List<String> publicKeys;

  GetAccountsByPublicKeysCall(this.publicKeys);

  @override
  Call toCall(int id, bool httpCall) {
    return Call(ApiType.API_DATABASE, id, RPC.CALL_GET_KEY_REFERENCES, List<dynamic>.from([publicKeys]),httpCall);
  }
}