import 'package:flutter/material.dart';
import 'package:table_menu_customer/utils/assets/assets_utils.dart';
import 'package:table_menu_customer/utils/font/text_style.dart';
import 'package:table_menu_customer/utils/responsive.dart';
import 'package:table_menu_customer/utils/widgets/custom_button.dart';

class OrderHistoryCard extends StatelessWidget {
  const OrderHistoryCard(
      {super.key,
      required this.orderId,
      required this.orderStatus,
      required this.orderTime,
      required this.totalPrice});

  final int orderId;
  final String orderStatus;
  final String orderTime;
  final String totalPrice;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: wp(2, context),vertical: hp(1, context)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(AssetsUtils.ASSETS_ORDER_HISTORY_IMAGE),
            SizedBox(width: wp(2, context),),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "# $orderId",
                  style: textRegularStyle.copyWith(color: Colors.purple),
                ),
                SizedBox(
                  height: hp(2, context),
                ),
                Text(
                  "₹ $totalPrice",
                  style: textRegularStyle,
                ),
              ],
            ),
            SizedBox(
              width: wp(6, context),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  orderStatus,
                  style: textSmallRegularStyle.copyWith(
                    color: Colors.green
                  ),
                ),
                SizedBox(
                  height: hp(3, context),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(orderTime, style: smallRegularStyle.copyWith(color: Colors.grey)),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
