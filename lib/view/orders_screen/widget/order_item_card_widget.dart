import 'package:flutter/material.dart';
import 'package:table_menu_customer/model/order_model.dart';
import 'package:table_menu_customer/utils/constants/constants_text.dart';
import 'package:table_menu_customer/utils/font/text_style.dart';
import 'package:table_menu_customer/utils/functions/time_format_function.dart';
import 'package:table_menu_customer/utils/responsive.dart';
import 'package:table_menu_customer/utils/widgets/custom_outlined_button.dart';

import '../../../app_localizations.dart';

class OrderItemCardWidget extends StatelessWidget {
  const OrderItemCardWidget(
      {super.key,
      required this.orderData,
      required this.cancelCallback,
      required this.trackOrderCallback});

  final OrderData orderData;
  final VoidCallback cancelCallback;
  final VoidCallback trackOrderCallback;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: wp(2, context), vertical: hp(1.5, context)),
        child: SizedBox(
          width: wp(100, context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "# ${orderData.id}",
                    style: textBodyStyle.copyWith(color: Colors.purple),
                  ),
                  const Spacer(),
                  Text(orderData.orderStatus!,style: textSmallRegularStyle.copyWith(
                    color: Colors.amber
                  ),)
                ],
              ),
              Text(
                formatDateTime(DateTime.parse(orderData.createdAt!)),
                style: textSmallRegularStyle.copyWith(fontFamily: fontSemiBold),
              ),
              SizedBox(height: hp(1.5, context)),
              Row(
                children: [
                  Text(
                    "${orderData.cartItems?.length} ${AppLocalizations.of(context).translate('items')}",
                    style: textSmallRegularStyle,
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "₹ ${orderData.totalPrice}",
                        style: textSmallRegularStyle.copyWith(
                            fontFamily: fontSemiBold),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: hp(0.4, context),
              ),
              Row(
                children: [
                  Flexible(
                    child: Text(
                      formatCartItems(orderData.cartItems),
                      style: smallRegularStyle.copyWith(color: Colors.grey),
                      overflow: TextOverflow.clip,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: hp(1, context),
              ),
              const Divider(),
              Row(
                children: [
                  CustomOutlinedButton(
                      onPressed: trackOrderCallback,
                      child: Row(
                        children: [
                          Text(
                            AppLocalizations.of(context).translate('track_order'),
                            style: textSmallRegularStyle,
                          ),
                          const Icon(Icons.arrow_right_outlined)
                        ],
                      )),
                  const Spacer(),
                  GestureDetector(
                    onTap: cancelCallback,
                    child: Text(
                      AppLocalizations.of(context).translate('cancel?'),
                      style:
                          textSmallRegularStyle.copyWith(color: Colors.purple),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  String formatCartItems(List<CartItems>? cartItems) {
    if (cartItems == null || cartItems.isEmpty) {
      return ''; // Return an empty string if the cartItems list is null or empty
    }

    // Create a list of formatted strings for each item
    List<String> itemStrings =
        cartItems.map((item) => '${item.itemName} x${item.quantity}').toList();

    // Join the list of formatted strings using commas
    return itemStrings.join(', ');
  }
}
