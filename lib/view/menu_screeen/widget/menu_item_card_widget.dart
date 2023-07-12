import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:table_menu_customer/utils/constants/api_endpoints.dart';

import '../../../utils/font/text_style.dart';
import '../../../utils/responsive.dart';

class MenuItemGridCard extends StatelessWidget {
  const MenuItemGridCard({
    Key? key,
    required this.image,
    required this.name,
    required this.price,
    required this.rating,
    required this.isVeg,
  }) : super(key: key);

  final String image;
  final String name;
  final double price;
  final double rating;
  final bool isVeg;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(10.0)),
                child: CachedNetworkImage(
                  imageUrl: ApiEndPoint.baseImageUrl + image,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: hp(18, context),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: titleTextStyle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: hp(1, context)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if ('₹ ${price.toStringAsFixed(1)}'.length <= 8)
                          Flexible(
                            child: Text(
                              '₹ ${price.toStringAsFixed(1)}',
                              style: textSmallRegularStyle.copyWith(
                                color: const Color(0xFF303030),
                                height: 1.4,
                              ),
                            ),
                          )
                        else
                          Text(
                            '₹ ${price.toStringAsFixed(1)}',
                            style: textSmallRegularStyle.copyWith(
                              color: const Color(0xFF303030),
                              height: hp(0.1, context),
                            ),
                          ),
                        if ('₹ ${price.toStringAsFixed(1)}'.length <= 8)
                          Row(
                            children: List.generate(
                              5,
                                  (index) => Icon(
                                Icons.star,
                                size: hp(2.5, context),
                                color: index < rating.floor()
                                    ? Colors.yellow.shade700
                                    : Colors.grey.shade300,
                              ),
                            ),
                          ),
                      ],
                    ),
                    if ('₹ ${price.toStringAsFixed(1)}'.length > 8)
                      Column(
                        children: [
                          Row(
                            children: List.generate(
                              5,
                                  (index) => Icon(
                                Icons.star,
                                size: hp(2.5, context),
                                color: index < rating.floor()
                                    ? Colors.yellow.shade700
                                    : Colors.grey.shade300,
                              ),
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ],
          ),
          if (isVeg)
            Positioned(
              top: hp(1, context),
              right: wp(1, context),
              child: Container(
                padding: EdgeInsets.all(hp(0.5, context)),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Text(
                  'Veg',
                  style: textSmallRegularStyle.copyWith(
                    color: Colors.white,
                    height: 1.2,
                  ),
                ),
              ),
            )
          else
            Positioned(
              top: hp(1, context),
              right: wp(1, context),
              child: Container(
                padding: EdgeInsets.all(hp(0.5, context)),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Text(
                  'Non-Veg',
                  style: textSmallRegularStyle.copyWith(
                    color: Colors.white,
                    height: 1.2,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}