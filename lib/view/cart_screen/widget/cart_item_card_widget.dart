import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:table_menu_customer/utils/constants/constants_text.dart';
import 'package:table_menu_customer/utils/widgets/plus_minus_button_widget.dart';

import '../../../app_localizations.dart';
import '../../../utils/font/text_style.dart';
import '../../../utils/responsive.dart';

class CartItemCard extends StatelessWidget {
  final String imageUrl;
  final String itemName;
  final double price;
  final VoidCallback cancelcallback;
  final VoidCallback addQuantitycallback;
  final VoidCallback removeQuantitycallback;
  final String quantity;

  const CartItemCard(
      {Key? key,
      required this.imageUrl,
      required this.itemName,
      required this.price,
      required this.cancelcallback,
      required this.addQuantitycallback,
      required this.removeQuantitycallback,
      required this.quantity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(BORDER_RADIUS),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              width:
                  wp(20, context), // Replace with the desired width percentage
              height:
                  wp(20, context), // Replace with the desired height percentage
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: wp(1.5, context)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: wp(32, context),
                  child: Text(
                    itemName,
                    style: smallTitleTextStyle,
                    softWrap: true,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '${AppLocalizations.of(context).translate('₹')} ${price.toStringAsFixed(1)}',
                  style: textBodyStyle,
                ),
              ],
            ),
            SizedBox(
              width: wp(2, context),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: cancelcallback,
                  icon: const Icon(
                    Icons.clear,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(
                  height: hp(1, context),
                ),
                PlusMinusButtons(
                    addQuantity: addQuantitycallback,
                    deleteQuantity: removeQuantitycallback,
                    text: quantity),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
