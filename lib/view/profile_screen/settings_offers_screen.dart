import 'package:flutter/material.dart';
import 'package:table_menu_customer/utils/font/text_style.dart';
import 'package:table_menu_customer/utils/responsive.dart';
import 'package:table_menu_customer/view/profile_screen/widget/offer_coupon_card_widget.dart';

class SettingsOffersScreen extends StatelessWidget {
  const SettingsOffersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0.0,
        title: Text("Offers & Discounts", style: titleTextStyle,),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: hp(2, context),horizontal: wp(2.5, context)),
          child: Column(
            children: [
              Row(
                children: [
                  Text("Best offers for you", style: textRegularStyle),
                ],
              ),
              const Divider(),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: 10,
                  itemBuilder: (context,index){
                    return const OfferCouponCard(
                      couponCode: "WAPPNET50",
                      subTitleText: "Save ₹ 50 with this code",
                      titleText: "Flat ₹ 50 OFF"
                    );
                  },
                ),
              ),
            ],
          ),
        )
      ),
    );
  }
}
