import 'dart:async';
import 'dart:convert';

import 'package:logging/logging.dart';
import 'package:web_socket_channel/io.dart';
import '../api/api.dart';
import 'base_rpc.dart';

class WssRpc extends BaseRpc{
  final Logger log = Logger("WssRpc");
  static const int NORMAL_CLOSURE_STATUS = 1005;
  static const int NORMAL_CLOSURE_STATUS2 = 1000;
  static const int GOING_AWAY_STATUS = 1001;
  int _currentId = 0;
  final _completers = <int, Completer<dynamic>>{};
  final _callClassMap = <int, Type>{};

  String url;

  WssRpc(this.url) {
    Logger.root.level = Level.ALL;
    Logger.root.onRecord.listen((rec){
      print('${rec.level}::${rec.time}::${rec.message}');
    });
  }

  IOWebSocketChannel _channel;

  void connect() async {
    log.info("Connecting to $url...");
    try {
      _channel = IOWebSocketChannel.connect(url);
      _channel.stream.listen((str) {
        Map json = jsonDecode(str);
        onData(json);
      }, onError: (error, StackTrace stackTrace) {
        log.severe("onError:$error, stackTrace:$stackTrace");
        _onDisconnect(true);
      }, onDone: () async {
        if(_channel != null) {
          var code = _channel.closeCode;
          var msg = _channel.closeReason;
          log.warning("onDone: msg=$msg, code=$code");
          _onDisconnect(code != NORMAL_CLOSURE_STATUS && code != NORMAL_CLOSURE_STATUS2);
        }
        _onDisconnect(false);
      }, cancelOnError: true);
    } catch (e) {
      log.severe("Open error:$e");
    }
    log.info("Conected to $url");
  }

  @override
  Future<dynamic> call(Callable callable) async {
    if (_channel != null && _channel.sink != null) {
      var call = callable.toCall(++_currentId, false);
      log.info("-> ${call.toJson()}");
      final completer = Completer<dynamic>.sync();
      _completers[_currentId] = completer;
      _callClassMap[_currentId] = callable.runtimeType;
      var json = jsonEncode(call);
      _channel.sink.add(json);
      return completer.future;
    } else {
      throw Exception('Connection has not yet been established');
    }
  }

  void onData(str) {
    log.info("<- $str");
    Response response = Response.fromJson(str);
    _completers.remove(response.id)?.complete(str);
    handleRpcResponce(response, str);
  }

  void handleRpcResponce(Response response, str) {
    Type callClass = _callClassMap.remove(response.id);
    if (callClass != null) {}
  }

  bool isConnected() {
    return _channel != null;
  }

  void _onDisconnect(bool tryReconnect) {
    log.info("onDisconnect with tryReconnect = $tryReconnect");
    _currentId = 0;
    if (tryReconnect) {
      Future.delayed(const Duration(seconds: 1), () => connect());
    }
  }

  @override
  void dispose() {
    log.info("dispose...");
    if (_channel != null) {
      _channel.sink.close(NORMAL_CLOSURE_STATUS);
      _channel = null;
    }
  }
}
