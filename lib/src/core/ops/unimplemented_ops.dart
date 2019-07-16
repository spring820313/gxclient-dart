import '../operations.dart';
import '../encoder.dart';
import 'optype.dart';

class UnimplementedOperation extends Operation {
  @override
  OpType opType() {
    return OpType.TransferOpType;
  }

  @override
  bool serialize(Encoder encoder) {
    return true;
  }

  @override
  dynamic toJson() {
    final val = <String, dynamic>{
    };
    return val;
  }
}

class AccountUpgradeMerchantOperation extends UnimplementedOperation {
  @override
  OpType opType() {
    return OpType.AccountUpgradeMerchantOpType;
  }
}

class AccountUpgradeDatasourceOperation extends UnimplementedOperation {
  @override
  OpType opType() {
    return OpType.AccountUpgradeDatasourceOpType;
  }
}

class AccountUpgradeDataTransactionMemberOperation extends UnimplementedOperation {
  @override
  OpType opType() {
    return OpType.AccountUpgradeDataTransactionMemberOpType;
  }
}

class StaleDataMarketCategoryCreateOperation extends UnimplementedOperation {
  @override
  OpType opType() {
    return OpType.StaleDataMarketCategoryCreateOpType;
  }
}

class StaleDataMarketCategoryUpdateOperation extends UnimplementedOperation {
  @override
  OpType opType() {
    return OpType.StaleDataMarketCategoryUpdateOpType;
  }
}

class StaleFreeDataProductCreateOperation extends UnimplementedOperation {
  @override
  OpType opType() {
    return OpType.StaleFreeDataProductCreateOpType;
  }
}

class StaleFreeDataProductUpdateOperation extends UnimplementedOperation {
  @override
  OpType opType() {
    return OpType.StaleFreeDataProductUpdateOpType;
  }
}

class StaleLeagueDataProductCreateOperation extends UnimplementedOperation {
  @override
  OpType opType() {
    return OpType.StaleLeagueDataProductCreateOpType;
  }
}

class StaleLeagueDataProductUpdateOperation extends UnimplementedOperation {
  @override
  OpType opType() {
    return OpType.StaleLeagueDataProductUpdateOpType;
  }
}

class StaleLeagueCreateOperation extends UnimplementedOperation {
  @override
  OpType opType() {
    return OpType.StaleLeagueCreateOpType;
  }
}

class StaleLeagueUpdateOperation extends UnimplementedOperation {
  @override
  OpType opType() {
    return OpType.StaleLeagueUpdateOpType;
  }
}

class DataMarketCategoryCreateOperation extends UnimplementedOperation {
  @override
  OpType opType() {
    return OpType.DataMarketCategoryCreateOpType;
  }
}

class DataMarketCategoryUpdateOperation extends UnimplementedOperation {
  @override
  OpType opType() {
    return OpType.DataMarketCategoryUpdateOpType;
  }
}

class FreeDataProductCreateOperation extends UnimplementedOperation {
  @override
  OpType opType() {
    return OpType.FreeDataProductCreateOpType;
  }
}

class FreeDataProductUpdateOperation extends UnimplementedOperation {
  @override
  OpType opType() {
    return OpType.FreeDataProductUpdateOpType;
  }
}

class LeagueDataProductCreateOperation extends UnimplementedOperation {
  @override
  OpType opType() {
    return OpType.LeagueDataProductCreateOpType;
  }
}

class LeagueDataProductUpdateOperation extends UnimplementedOperation {
  @override
  OpType opType() {
    return OpType.LeagueDataProductUpdateOpType;
  }
}

class LeagueCreateOperation extends UnimplementedOperation {
  @override
  OpType opType() {
    return OpType.LeagueCreateOpType;
  }
}

class LeagueUpdateOperation extends UnimplementedOperation {
  @override
  OpType opType() {
    return OpType.LeagueUpdateOpType;
  }
}

class DatasourceCopyrightClearOperation extends UnimplementedOperation {
  @override
  OpType opType() {
    return OpType.DatasourceCopyrightClearOpType;
  }
}

class DataTransactionComplainOperation extends UnimplementedOperation {
  @override
  OpType opType() {
    return OpType.DataTransactionComplainOpType;
  }
}