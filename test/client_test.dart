import 'package:test/test.dart';
import 'package:gxclient/gxclient.dart';


void main() {
  group('Client', ()
  {

    setUp(() {

    });

    test('Get Public key', () {
      GXCPrivateKey privateKey = GXCPrivateKey.fromString(
          '5K1ravLd96RmdTf8rcGVhtJFS7hqvihwurfV3cdao8QVnkoEkXq');

      // Get the related GXC public key
      GXCPublicKey publicKey = privateKey.toGXCPublicKey();
      // Print the GXC public key
      print(publicKey.toString());
    });

    test('Transfer', ()async {
      Client client = Client('https://testnet.gxchain.org');
      //Client client = Client('wss://testnet.gxchain.org');
      await client.init();
      final from = await client.getAccountByName('spring123');
      final to = await client.getAccountByName('spring456');
      final assets = await client.lookupAssetSymbols(List.from(["GXC"]));

      final key = "5K1ravLd96RmdTf8rcGVhtJFS7hqvihwurfV3cdao8QVnkoEkXq";

      final amount = AssetAmount(10, assets[0].id);
      final fee = AssetAmount(0, assets[0].id);

      final k = from.active.keyAuths.auth.keys.toList()[0];
      final memoKey = to.options.memoKey;
      final memo = Memo(key, memoKey, "1234578912345678901234567890");

      final res = await client.transfer(key, from.id, to.id, amount, fee, null);
      print(res.toString());

      client.close();
    });
  });
}