import 'package:flutter/material.dart';
import 'package:table_menu_customer/utils/font/text_style.dart';

import '../../../app_localizations.dart';
import '../../../utils/constants/constants_text.dart';
import '../../../utils/responsive.dart';
import '../../../utils/widgets/custom_text_list_widget.dart';

class OfferCouponCard extends StatelessWidget {
  const OfferCouponCard(
      {super.key,
      required this.titleText,
      required this.subTitleText,
      required this.couponCode,
      this.details});

  final String titleText;
  final String subTitleText;
  final String couponCode;
  final List<dynamic>? details;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.symmetric(
            vertical: hp(1.5, context), horizontal: wp(2, context)),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(BORDER_RADIUS),
          ),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  titleText,
                  style: smallTitleTextStyle.copyWith(fontFamily: fontSemiBold),
                ),
              ],
            ),
            SizedBox(
              height: hp(1, context),
            ),
            Row(
              children: [
                Text(
                  subTitleText,
                  style: smallRegularStyle.copyWith(
                      fontFamily: fontSemiBold, color: Colors.purple),
                )
              ],
            ),
            SizedBox(
              height: hp(1, context),
            ),
            Row(
              children: [
                Expanded(
                  child: Theme(
                    data: Theme.of(context).copyWith(
                      dividerColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                    ),
                    child: ExpansionTile(
                      controlAffinity: ListTileControlAffinity.trailing,
                      title: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(BORDER_RADIUS),
                              ),
                              border: Border.all(color: Colors.grey, width: 1),
                            ),
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              couponCode,
                              style: textSmallRegularStyle,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            AppLocalizations.of(context)
                                .translate('view_details'),
                            style: smallRegularStyle,
                          ),
                        ],
                      ),
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: hp(1, context),
                              horizontal: wp(1, context)),
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              UnorderedList([
                                "this is the description of the coupon code.",
                                "this is the description of the coupon code.",
                                "this is the description of the coupon code.",
                                "this is the description of the coupon code."
                              ])
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
