import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_menu_customer/utils/assets/assets_utils.dart';
import 'package:table_menu_customer/utils/responsive.dart';
import 'package:table_menu_customer/utils/routes/routes_name.dart';

import '../app_localizations.dart';
import '../utils/font/text_style.dart';
import '../utils/widgets/custom_button.dart';
import '../view_model/order_provider.dart';
import 'feedback_screeen/widget/add_feedback_dialog.dart';

class PaymentSuccessfulScreen extends StatefulWidget {
  const PaymentSuccessfulScreen({super.key, this.orderID});
  final int? orderID;

  @override
  State<PaymentSuccessfulScreen> createState() =>
      _PaymentSuccessfulScreenState();
}

class _PaymentSuccessfulScreenState extends State<PaymentSuccessfulScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      Provider.of<OrderProvider>(context, listen: false)
          .changePaymentStatus(order_id: widget.orderID!, context: context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<OrderProvider>(
      builder: (context, orderProvider, __) {
        return Scaffold(
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
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Hero(
                      tag: "payment",
                      child: Image.asset(
                        AssetsUtils.ASSETS_SUCCESS_IMAGE,
                        height: hp(30, context),
                        width: wp(40, context),
                      )),
                  Text(
                    AppLocalizations.of(context).translate('woohoo_text'),
                    style: smallTitleTextStyle,
                  ),
                  SizedBox(
                    height: hp(1, context),
                  ),
                  Text(
                    AppLocalizations.of(context)
                        .translate('payment_success_message'),
                    style: smallRegularStyle,
                  ),
                  SizedBox(
                    height: hp(2, context),
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: wp(1.5, context), vertical: hp(1.5, context)),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: hp(7.5, context),
              child: CustomButton(
                onPressed: () async {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return CustomDialogBox(
                        addFeedback: () {
                          orderProvider.changePaymentStatus(
                              order_id: widget.orderID!, context: context);
                          Navigator.pushReplacementNamed(
                              context, RoutesName.FEEDBACK_SCREEN_ROUTE,
                              arguments: widget.orderID);
                        },
                        onClosePressed: () {
                          Navigator.of(context).pop();
                        },
                      );
                    },
                  );
                },
                child: Text(
                  AppLocalizations.of(context).translate('continue'),
                  style: textBodyStyle.copyWith(color: Colors.white),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
