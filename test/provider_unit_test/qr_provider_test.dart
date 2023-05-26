import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_menu_customer/view_model/qr_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  late QRProvider qrProviderTest;

  setUp(() {
    qrProviderTest = QRProvider();
  });

  group("QR Provider class tests", () {

    // test 1 initial values are correct

    // test("initial values are correct", () {
    //   expect(qrProviderTest.show_menu, false);
    //   expect(qrProviderTest.table_number, 1);
    // });

    // test 2 setter for setting qr data working properly
    test("set QR data setting data coming from qr properly", () {

      // test data
      var jsonData = {
        "table_no" : 5,
        "show_menu" : true
      }.toString();

      qrProviderTest.getDataFromQR(jsonData);

      // verify
      expect(qrProviderTest.table_number, 5);
      // expect(qrProviderTest.show_menu, true);
    });

    // test 3 sharedprefences value is set and get properly

    test("shared prefs value is setting and getting properly", () async {
      bool show_menu = false;

      // test data

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('qr_scanned', true);
      show_menu = await prefs.getBool("qr_scanned") ?? false;

      // verify
      expect(show_menu, true);
    });

  });

}