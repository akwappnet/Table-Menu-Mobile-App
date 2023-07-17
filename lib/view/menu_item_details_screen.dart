import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_menu_customer/utils/assets/assets_utils.dart';
import 'package:table_menu_customer/utils/constants/api_endpoints.dart';
import 'package:table_menu_customer/utils/constants/constants_text.dart';
import 'package:table_menu_customer/utils/routes/routes_name.dart';

import '../model/custom_result_model.dart';
import '../model/menuItem_model.dart';
import '../utils/font/text_style.dart';
import '../utils/responsive.dart';
import '../utils/widgets/custom_flushbar_widget.dart';
import '../utils/widgets/plus_minus_button_widget.dart';
import '../view_model/cart_provider.dart';
import '../view_model/menu_provider.dart';

class MenuItemDetailsPage extends StatelessWidget {
  final MenuData menuData;

  const MenuItemDetailsPage({Key? key, required this.menuData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          actions: [
            Consumer<MenuProvider>(
              builder: (context,menu_provider,__){
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.transparent,
                  ),
                  child: IconButton(
                    icon: Icon(
                      menu_provider.favToggle ? Icons.favorite : Icons.favorite_border,
                      color: menu_provider.favToggle ? Colors.red :Colors.black,
                    ),
                    onPressed: () {
                      Provider.of<MenuProvider>(context, listen: false).toggleFavorite();
                    },
                  ),
                );
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: double.infinity,
                height: hp(40, context),
                child: Hero(
                  tag: "menu-${menuData.id}",
                  child: CachedNetworkImage(
                    imageUrl: ApiEndPoint.baseImageUrl +
                        menuData.image.toString() ?? '',
                    fit: BoxFit.cover,
                    placeholder: (context, url) =>
                        Image.asset(AssetsUtils.ASSETS_PLACEHOLDER_IMAGE),
                    // Show a placeholder while loading
                    errorWidget: (context, url, error) =>
                        Image.asset(AssetsUtils
                            .ASSETS_ERROR_IMAGE), // Show an error icon if loading fails
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          menuData.name ?? '',
                          style: titleTextStyle.copyWith(fontSize: 24),
                        ),
                        const Spacer(),
                        Text(
                          '₹ ${double.parse(menuData.price ?? '').toStringAsFixed(
                              1)}',
                          style: textRegularStyle.copyWith(fontSize: 18),
                        ),
                      ],
                    ),
                    SizedBox(height: hp(2, context)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(
                                Icons.star, color: Colors.yellow, size: 18),
                            const SizedBox(width: 8),
                            Text(
                              '${double.parse(menuData.rating ?? "0").toStringAsFixed(1)} (${menuData.rated ?? 0} rated)',
                              style: textRegularStyle.copyWith(fontSize: 16),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            (menuData.isVeg ?? false) ?
                            const Icon(
                                Icons.circle, color: Colors.green, size: 18) :
                            const Icon(Icons.circle, color: Colors.red, size: 18),
                            (menuData.isVeg ?? false) ?
                            Text(
                              ' Veg',
                              style: textRegularStyle.copyWith(fontSize: 16),
                            ) :
                            Text(
                              ' Non-Veg',
                              style: textRegularStyle.copyWith(fontSize: 16),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(
                                Icons.timer, color: Colors.orange, size: 18),
                            const SizedBox(width: 8),
                            Text(
                              ' ${menuData.duration ?? 0} min',
                              style: textRegularStyle.copyWith(fontSize: 16),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: hp(2, context)),
                    Text(
                      'Description:',
                      style: textRegularStyle.copyWith(fontSize: 16),
                    ),
                    SizedBox(height: hp(1, context)),
                    Text(
                      menuData.description ?? '',
                      style: textRegularStyle.copyWith(
                          fontSize: 16, color: Colors.grey),
                    ),
                    SizedBox(height: hp(2, context)),
                    Text(
                      'Ingredients:',
                      style: textRegularStyle.copyWith(fontSize: 16),
                    ),
                    SizedBox(height: hp(1, context)),
                    Text(
                      menuData.ingredients ?? '',
                      style: textRegularStyle.copyWith(
                          fontSize: 16, color: Colors.grey),
                    ),
                    SizedBox(height: hp(2, context)),

                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Consumer<CartProvider>(
          builder: (context,cart_provider,__){
            return Card(
              elevation: 4,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(15.0), topLeft: Radius.circular(15.0)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    PlusMinusButtons(
                      addQuantity: cart_provider.incrementItemQuantity,
                      deleteQuantity: cart_provider.decrementItemQuantity,
                      text: cart_provider.quantity.toString(),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () async {
                          cart_provider
                              .incrementCartCount();
                          var data = {
                            "menu_item": menuData.id,
                            "quantity":
                            cart_provider
                                .quantity
                          };
                          cart_provider.addCart(data,menuData.id!,context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.purple.shade400,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(BORDER_RADIUS),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          child: Text(
                            'Add to Cart',
                            style: textRegularStyle.copyWith(
                                fontSize: 16, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );
  }
}
