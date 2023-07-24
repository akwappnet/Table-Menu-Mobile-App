import 'package:flutter/material.dart';
import 'package:table_menu_customer/utils/assets/assets_utils.dart';
import 'package:table_menu_customer/utils/font/text_style.dart';
import 'package:table_menu_customer/utils/responsive.dart';
import 'package:table_menu_customer/utils/routes/routes_name.dart';
import 'package:table_menu_customer/utils/widgets/custom_button.dart';
import 'package:table_menu_customer/utils/widgets/custom_outlined_button.dart';

class OrderSuccessfulScreen extends StatelessWidget {
  const OrderSuccessfulScreen({super.key,this.order_id});

  final int? order_id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal : wp(20, context)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Hero(tag: "order_success",child: Image.asset(AssetsUtils.ASSETS_SUCCESS_IMAGE,height: hp(22, context),width: wp(40, context),)),
                 SizedBox(height: hp(2, context),),
                Text(
                  "Congratulations!!!",
                  style: titleTextStyle,
                ),
                SizedBox(height: hp(3, context),),
                Text("Your order have been taken and food is being prepared.",
                style: textSmallRegularStyle,
                overflow: TextOverflow.clip,),
                SizedBox(height: hp(5, context),),
                SizedBox(
                  height: hp(8, context),
                  width: wp(40, context),
                  child: CustomButton(child: Text("Track Order", style: textMediumStyle.copyWith(
                    color: Colors.white
                  ),
                  ), onPressed: () {
                    Navigator.pushReplacementNamed(context, RoutesName.ORDER_TRACKING_SCREEN_ROUTE,arguments: order_id,);
                  }),
                ),
                SizedBox(height: hp(4, context),),
                SizedBox(
                  height: hp(8, context),
                  width: wp(55, context),
                  child: CustomOutlinedButton(child: Text("Continue ordering", style: textMediumStyle.copyWith(
                      color: Colors.purple
                  ),
                  ), onPressed: () {
                    Navigator.popAndPushNamed(context, RoutesName.HOME_SCREEN_ROUTE);
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
