import 'package:flutter/material.dart';
import 'package:table_menu_customer/utils/assets/assets_utils.dart';
import 'package:table_menu_customer/utils/responsive.dart';
import 'package:table_menu_customer/utils/routes/routes_name.dart';

import '../utils/font/text_style.dart';
import '../utils/widgets/custom_button.dart';
import 'feedback_screeen/widget/add_feedback_dialog.dart';

class PaymentSuccessfulScreen extends StatelessWidget {
  const PaymentSuccessfulScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Checkout',
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
              Hero(tag: "payment",child: Image.asset(AssetsUtils.ASSETS_ORDER_SUCCESS_IMAGE,height: hp(30, context),width: wp(40, context),)),
              Text("Woohoo!",style: smallTitleTextStyle,),
              SizedBox(height: hp(1, context),),
              Text("Thank you for your payment!", style: smallRegularStyle,),
              SizedBox(height: hp(2, context),),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: wp(1.5, context),vertical: hp(1.5, context)),
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
                        Navigator.pushNamed(context, RoutesName.FEEDBACK_SCREEN_ROUTE);
                      },
                      onClosePressed: () {
                        Navigator.of(context).pop();
                      },
                    );
                  },
                );
              },
              child:  Text("Continue", style: textBodyStyle.copyWith(
                  color: Colors.white
              ),),
          ),
        ),
      ),
    );
  }
}
