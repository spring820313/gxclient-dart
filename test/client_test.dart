import 'package:test/test.dart';
import 'package:gxclient/gxclient.dart';

void main() {
  group('Client', ()
  {

    setUp(() {

    });

    test('Get Info', () {
      Account account = Account('1', 10);
      print(account.toString());
    });
  });
}