import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:table_menu_customer/utils/constants/api_endpoints.dart';
import 'package:table_menu_customer/utils/constants/constants_text.dart';
import 'package:table_menu_customer/utils/widgets/plus_minus_button_widget.dart';


import '../../../utils/font/text_style.dart';
import '../../../utils/responsive.dart';

class CartItemCard extends StatelessWidget {
  final String imageUrl;
  final String itemName;
  final double price;

  const CartItemCard({
    Key? key,
    required this.imageUrl,
    required this.itemName,
    required this.price,
  }) : super(key: key);

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
              width: wp(20, context), // Replace with the desired width percentage
              height: wp(20, context), // Replace with the desired height percentage
              child: CachedNetworkImage(
                imageUrl: ApiEndPoint.baseImageUrl + imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  itemName,
                  style: smallTitleTextStyle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Text(
                  '₹ ${price.toStringAsFixed(1)}',
                  style: textBodyStyle,
                ),
              ],
            ),
            SizedBox(width: wp(2, context),),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Icon(Icons.clear,color: Colors.grey,),
                SizedBox(height: hp(1, context),),
                PlusMinusButtons(addQuantity: () {}, deleteQuantity: () {}, text: "2"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
