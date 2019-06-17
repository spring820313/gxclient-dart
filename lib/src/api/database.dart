import 'call.dart';
import 'rpc_call.dart';
import 'api_type.dart';
import '../core/operations.dart';

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