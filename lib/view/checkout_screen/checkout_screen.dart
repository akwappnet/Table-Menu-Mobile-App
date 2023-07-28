import 'dart:developer';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:confetti/confetti.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart' hide Card;
import 'package:provider/provider.dart';
import 'package:table_menu_customer/utils/routes/routes_name.dart';
import 'package:table_menu_customer/utils/widgets/custom_textformfield.dart';
import 'package:table_menu_customer/view_model/order_provider.dart';

import '../../app_localizations.dart';
import '../../utils/constants/constants_text.dart';
import '../../utils/font/text_style.dart';
import '../../utils/responsive.dart';
import '../../utils/validation/validation.dart';
import '../../utils/widgets/custom_button.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key, this.arguments});

  final List<dynamic>? arguments;

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final TextEditingController discountCodeController = TextEditingController();
  final TextEditingController tipController = TextEditingController();
  late ConfettiController _confettiController = ConfettiController();

  var paymentIntent;

  @override
  void initState() {
    super.initState();
    _confettiController =
        ConfettiController(duration: const Duration(milliseconds: 3));
    initilize();
  }

  void initilize() async {
    Stripe.publishableKey = stripePublishableKey;
    Stripe.merchantIdentifier = "";
    Stripe.instance.applySettings();
    Stripe.setReturnUrlSchemeOnAndroid = true;
    await dotenv.load(fileName: "assets/.env");
  }

  @override
  Widget build(BuildContext context) {
    String totalAmount = widget.arguments?[1];
    return Consumer<OrderProvider>(
      builder: (context, order_provider, __) {
        return Stack(
          children: [
            Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                title: Text(
                  AppLocalizations.of(context).translate('checkout'),
                  style: smallTitleTextStyle,
                ),
                backgroundColor: Colors.white,
                scrolledUnderElevation: 0.0,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
              body: SafeArea(
                child: Stack(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: wp(2, context), vertical: hp(2, context)),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(
                              width: wp(100, context),
                              child: Hero(
                                tag: "checkout",
                                child: Card(
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: wp(2, context),
                                        vertical: hp(1, context)),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              AppLocalizations.of(context)
                                                  .translate('item_total'),
                                              style: textRegularStyle.copyWith(
                                                  color: Colors.grey),
                                            ),
                                            const Spacer(),
                                            Text(
                                              "${AppLocalizations.of(context).translate('₹')} $totalAmount",
                                              style: textBodyStyle.copyWith(
                                                  color: Colors.black),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: hp(1, context),
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              AppLocalizations.of(context)
                                                  .translate('tax'),
                                              style: textRegularStyle.copyWith(
                                                  color: Colors.grey),
                                            ),
                                            const Spacer(),
                                            Text(
                                              "${AppLocalizations.of(context).translate('₹')} 00",
                                              style: textBodyStyle.copyWith(
                                                  color: Colors.black),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: hp(1, context),
                                        ),
                                        const Divider(),
                                        SizedBox(
                                          height: hp(1, context),
                                        ),
                                        CustomTextFormField()
                                            .getCustomEditTextArea(
                                                labelValue: AppLocalizations.of(
                                                        context)
                                                    .translate(
                                                        'label_discount_code'),
                                                hintValue: AppLocalizations.of(
                                                        context)
                                                    .translate(
                                                        'hint_discount_code'),
                                                controller:
                                                    discountCodeController,
                                                prefixicon: const Icon(
                                                  Icons.percent_outlined,
                                                  color: Colors.black,
                                                ),
                                                obscuretext: false,
                                                onchanged: (value) {},
                                                textInputAction:
                                                    TextInputAction.done,
                                                validator: (value) =>
                                                validateDiscountCode(context,value)),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: wp(1.5, context)),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              GestureDetector(
                                                  onTap: () {
                                                    _confettiController.play();
                                                    setState(() {});
                                                    AwesomeDialog(
                                                      context: context,
                                                      btnOkText:
                                                          AppLocalizations.of(
                                                                  context)
                                                              .translate(
                                                                  'woohoo_text'),
                                                      dialogType:
                                                          DialogType.success,
                                                      animType:
                                                          AnimType.rightSlide,
                                                      title: AppLocalizations
                                                              .of(context)
                                                          .translate(
                                                              'congratulations'),
                                                      desc: '${AppLocalizations.of(
                                                                  context)
                                                              .translate(
                                                                  'discount_success_desc1')} ${AppLocalizations.of(
                                                                  context)
                                                              .translate('₹')} ${AppLocalizations.of(
                                                                  context)
                                                              .translate('discount_success_desc2')}',
                                                      btnOkOnPress: () {},
                                                    ).show();
                                                    Future.delayed(
                                                        const Duration(
                                                            seconds: 2), () {
                                                      _confettiController
                                                          .stop();
                                                    });
                                                  },
                                                  child: Text(
                                                    AppLocalizations.of(context).translate('apply'),
                                                    style: textSmallRegularStyle
                                                        .copyWith(
                                                            color:
                                                                Colors.purple),
                                                  )),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: hp(1, context),
                                        ),
                                        CustomTextFormField()
                                            .getCustomEditTextArea(
                                                labelValue: AppLocalizations.of(context).translate('label_tips'),
                                                hintValue: AppLocalizations.of(context).translate('hint_tips'),
                                                controller: tipController,
                                                keyboardType:
                                                    TextInputType.number,
                                                prefixicon: const Icon(
                                                    Icons
                                                        .currency_rupee_outlined,
                                                    color: Colors.black),
                                                obscuretext: false,
                                                onchanged: (value) {},
                                                textInputAction:
                                                    TextInputAction.done,
                                                validator: (value) {
                                                  return null;
                                                }),
                                        const Divider(),
                                        SizedBox(
                                          height: hp(1, context),
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              AppLocalizations.of(context).translate('total_price'),
                                              style: textRegularStyle.copyWith(
                                                  color: Colors.grey),
                                            ),
                                            const Spacer(),
                                            Text(
                                              "${AppLocalizations.of(context).translate('₹')} $totalAmount",
                                              style: textBodyStyle.copyWith(
                                                  color:
                                                      Colors.purple.shade300),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              bottomNavigationBar: Hero(
                tag: "payment",
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: wp(1.5, context), vertical: hp(1.5, context)),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: hp(7.5, context),
                    child: CustomButton(
                        onPressed: () async {
                          await makePayment();
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppLocalizations.of(context).translate('pay'),
                              style:
                                  textBodyStyle.copyWith(color: Colors.white),
                            ),
                            const Spacer(),
                            Text(
                              "${AppLocalizations.of(context).translate('₹')} $totalAmount",
                              style:
                                  textBodyStyle.copyWith(color: Colors.white),
                            ),
                          ],
                        )),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: ConfettiWidget(
                confettiController: _confettiController,
                colors: const [
                  Colors.amber,
                  Colors.red,
                  Colors.green,
                  Colors.blue,
                  Colors.purple,
                ],
                maxBlastForce: 20,
                gravity: 0.1,
                blastDirectionality: BlastDirectionality.explosive,
                shouldLoop: false,
                numberOfParticles: 50,
              ),
            )
          ],
        );
      },
    );
  }

  Future<void> makePayment() async {
    try {
      paymentIntent = await createPaymentIntent(widget.arguments![1], 'INR');

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
                    name: CollectionMode.always,
                    email: CollectionMode.always,
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

  displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet().then((value) {
        paymentIntent = null;
        Navigator.pushReplacementNamed(
            context, RoutesName.PAYMENT_SUCCESSFUL_SCREEN_ROUTE,
            arguments: widget.arguments![0]);
      }).onError((error, stackTrace) {
        log("exception 2 :$error");
        log("reason :$stackTrace");
      });
    } on StripeException catch (e) {
      log('Error is:---> $e');
      log("exception 3 :$e");
    } catch (e) {
      log('$e');
    }
  }
}
