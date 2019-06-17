import '../api/api.dart';

abstract class BaseRpc {
  void connect();
  Future<dynamic> call(Callable callable);
  void dispose();
}