import 'package:flutter/material.dart';
import 'package:table_menu_customer/utils/font/text_style.dart';
import 'package:table_menu_customer/utils/responsive.dart';
import 'package:table_menu_customer/view/profile_screen/widget/offer_coupon_card_widget.dart';

import '../../app_localizations.dart';

class SettingsOffersScreen extends StatelessWidget {
  const SettingsOffersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0.0,
        title: Text(AppLocalizations.of(context).translate('offers_and_discounts'), style: titleTextStyle,),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: hp(2, context),horizontal: wp(2.5, context)),
          child: Column(
            children: [
              Row(
                children: [
                  Text(AppLocalizations.of(context).translate('best_offer_for_you'), style: textRegularStyle),
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
