import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:table_menu_customer/utils/widgets/custom_button.dart';

import '../../utils/constants/constants_text.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  var paymentIntent;

  @override
  void initState() {
    super.initState();
    initilize();
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
        ],
      ),
    );
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
                  googlePay: null,
                  applePay: null,
                  merchantDisplayName: 'Table Menu'),)
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
          builder: (_) => const AlertDialog(
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
                    Text("Payment Successfull"),
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
        'payment_method_types[]': 'card'
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
    Stripe.publishableKey = stripePublishableKey;
    await dotenv.load(fileName: "assets/.env");
  }
}
