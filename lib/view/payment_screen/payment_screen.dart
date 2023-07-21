import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:pay/pay.dart';
import 'package:table_menu_customer/utils/widgets/custom_button.dart';

import '../../utils/constants/constants_text.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  var paymentIntent;

  late final Pay _payClient;

  String defaultGooglePay = '''{
  "provider": "google_pay",
  "data": {
    "environment": "TEST",
    "apiVersion": 2,
    "apiVersionMinor": 0,
    "allowedPaymentMethods": [
      {
        "type": "CARD",
        "tokenizationSpecification": {
          "type": "PAYMENT_GATEWAY",
          "parameters": {
            "gateway": "example",
            "gatewayMerchantId": "gatewayMerchantId"
          }
        },
        "parameters": {
          "allowedCardNetworks": ["VISA", "MASTERCARD"],
          "allowedAuthMethods": ["PAN_ONLY", "CRYPTOGRAM_3DS"],
          "billingAddressRequired": true,
          "billingAddressParameters": {
            "format": "FULL",
            "phoneNumberRequired": true
          }
        }
      }
    ],
    "merchantInfo": {
      "merchantId": "01234567890123456789",
      "merchantName": "Example Merchant Name"
    },
    "transactionInfo": {
      "countryCode": "US",
      "currencyCode": "USD"
    }
  }
}''';

  @override
  void initState() {
    super.initState();
    initilize();
    _payClient = Pay({
      PayProvider.google_pay: PaymentConfiguration.fromJsonString(
          defaultGooglePay),
    });
  }

  static const _paymentItems = [
    PaymentItem(
        label: 'Total',
        amount: '10',
        status: PaymentItemStatus.final_price,
        type: PaymentItemType.total
    )
  ];

  void onGooglePayResult(paymentResult) {
    debugPrint(paymentResult.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomButton(
              child: const Text("Make Payment"),
              onPressed: () async {
                await makePayment();
              }),
          FutureBuilder<bool>(
            future: _payClient.userCanPay(PayProvider.google_pay),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.data == true) {
                  return RawGooglePayButton(
                      type: GooglePayButtonType.pay,
                      onPressed: onGooglePayPressed);
                } else {
                  return const SizedBox();
                  // userCanPay returned false
                  // Consider showing an alternative payment method
                }
              } else {
                return const SizedBox();
                // The operation hasn't finished loading
                // Consider showing a loading indicator
              }
            },
          ),
        ],
      ),
    );
  }

  void onGooglePayPressed() async {
    final result = await _payClient.userCanPay(
      PayProvider.google_pay,
    );
    log("message -> $result");

    final test = await _payClient.showPaymentSelector(PayProvider.google_pay, _paymentItems);
    log("test -> $test");
  }

  Future<void> makePayment() async {
    try {
      paymentIntent = await createPaymentIntent('10', 'INR');

      //STEP 2: Initialize Payment Sheet
      await Stripe.instance
          .initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
            paymentIntentClientSecret: paymentIntent!['client_secret'],
            style: ThemeMode.light,
            customerId: paymentIntent!['customer'],
            customerEphemeralKeySecret: paymentIntent!['ephemeralKey'],
            billingDetails: const BillingDetails(
                name: "",
                phone: "",
                email: "",
                address: Address(
                    city: "",
                    country: '',
                    line1: '',
                    line2: '',
                    postalCode: '',
                    state: '')),
            billingDetailsCollectionConfiguration:
            const BillingDetailsCollectionConfiguration(
                attachDefaultsToPaymentMethod: true,
                name: CollectionMode.automatic,
                address: AddressCollectionMode.automatic,
                email: CollectionMode.automatic,
                phone: CollectionMode.automatic),
            // applePay: const PaymentSheetApplePay(
            //   merchantCountryCode: "IN",
            // ),
            googlePay: const PaymentSheetGooglePay(
              merchantCountryCode: "IN",
              currencyCode: "INR",
              testEnv: true,
            ),
            merchantDisplayName: 'Table Menu'),
      )
          .then((value) {
        log("Success");
      });
      displayPaymentSheet();
    } catch (err) {
      throw Exception(err);
    }
  }

  displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet().then((value) {
        showDialog(
          context: context,
          builder: (_) =>
          const AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Icon(
                        Icons.check_circle,
                        color: Colors.green,
                      ),
                    ),
                    Text("Payment Successful"),
                  ],
                ),
              ],
            ),
          ),
        );
        // TODO: update payment intent to null
        paymentIntent = null;
      }).onError((error, stackTrace) {
        String ss = "exception 2 :$error";
        String s2 = "reason :$stackTrace";
      });
    } on StripeException catch (e) {
      print('Error is:---> $e');
      String ss = "exception 3 :$e";
    } catch (e) {
      log('$e');
    }
  }

  createPaymentIntent(String amount, String currency) async {
    try {
      //Request body
      var data = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': ['card'],
      };

      //Make post request to Stripe
      var response = await Dio().post(
        'https://api.stripe.com/v1/payment_intents',
        options: Options(
          headers: {
            'Authorization': 'Bearer ${dotenv.env['STRIPE_SECRET']}',
            'Content-Type': 'application/x-www-form-urlencoded'
          },
        ),
        data: data,
      );
      return response.data;
    } catch (err) {
      throw Exception(err.toString());
    }
  }

  calculateAmount(String amount) {
    final calculatedAmount = (int.parse(amount)) * 100;
    return calculatedAmount.toString();
  }

  void initilize() async {
    Stripe.instance.isPlatformPaySupportedListenable.addListener(() {
    });
    Stripe.instance.canAddToWallet("1234");
    Stripe.publishableKey = stripePublishableKey;
    Stripe.merchantIdentifier = "";
    Stripe.instance.applySettings();
    Stripe.setReturnUrlSchemeOnAndroid = true;
    await dotenv.load(fileName: "assets/.env");
  }
}
