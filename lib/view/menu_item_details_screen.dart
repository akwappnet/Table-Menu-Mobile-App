import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_menu_customer/utils/assets/assets_utils.dart';
import 'package:table_menu_customer/utils/constants/constants_text.dart';

import '../app_localizations.dart';
import '../model/menuItem_model.dart';
import '../utils/font/text_style.dart';
import '../utils/responsive.dart';
import '../utils/widgets/plus_minus_button_widget.dart';
import '../view_model/cart_provider.dart';
import '../view_model/menu_provider.dart';

class MenuItemDetailsPage extends StatefulWidget {
  final MenuData menuData;

  const MenuItemDetailsPage({Key? key, required this.menuData})
      : super(key: key);

  @override
  State<MenuItemDetailsPage> createState() => _MenuItemDetailsPageState();
}

class _MenuItemDetailsPageState extends State<MenuItemDetailsPage> {

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      Provider.of<MenuProvider>(context, listen: false).getMenuItemByID(widget.menuData.id!,context);
    });
    super.initState();
  }

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
            builder: (context, menu_provider, __) {
              log(widget.menuData.isFavorite.toString());
              log(menu_provider.favToggle.toString());
              return Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.transparent,
                ),
                child: IconButton(
                  icon: Icon(
                    menu_provider.favToggle
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: menu_provider.favToggle ? Colors.red : Colors.black,
                  ),
                  onPressed: () {
                    menu_provider.addToFavoritesMenuItem(
                        widget.menuData.id!, context);
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
                tag: "menu-${widget.menuData.id}",
                child: CachedNetworkImage(
                  imageUrl: widget.menuData.image.toString(),
                  fit: BoxFit.cover,
                  placeholder: (context, url) =>
                      Image.asset(AssetsUtils.ASSETS_PLACEHOLDER_IMAGE),
                  // Show a placeholder while loading
                  errorWidget: (context, url, error) => Image.asset(AssetsUtils
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
                        widget.menuData.name ?? '',
                        style: titleTextStyle.copyWith(fontSize: 24),
                      ),
                      const Spacer(),
                      Text(
                        '${AppLocalizations.of(context).translate('₹')} ${double.parse(widget.menuData.price ?? '').toStringAsFixed(1)}',
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
                          const Icon(Icons.star,
                              color: Colors.yellow, size: 18),
                          const SizedBox(width: 8),
                          Text(
                            '${double.parse(widget.menuData.rating ?? "0").toStringAsFixed(1)} (${widget.menuData.rated ?? 0} rated)',
                            style: textRegularStyle.copyWith(fontSize: 16),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          (widget.menuData.isVeg ?? false)
                              ? const Icon(Icons.circle,
                                  color: Colors.green, size: 18)
                              : const Icon(Icons.circle,
                                  color: Colors.red, size: 18),
                          (widget.menuData.isVeg ?? false)
                              ? Text(
                            AppLocalizations.of(context).translate('veg'),
                                  style:
                                      textRegularStyle.copyWith(fontSize: 16),
                                )
                              : Text(
                            AppLocalizations.of(context).translate('non_veg'),
                                  style:
                                      textRegularStyle.copyWith(fontSize: 16),
                                ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: hp(2, context)),
                  Text(
                    AppLocalizations.of(context).translate('description'),
                    style: textRegularStyle.copyWith(fontSize: 16),
                  ),
                  SizedBox(height: hp(1, context)),
                  Text(
                    widget.menuData.description ?? '',
                    style: textRegularStyle.copyWith(
                        fontSize: 16, color: Colors.grey),
                  ),
                  SizedBox(height: hp(2, context)),
                  Text(
                    AppLocalizations.of(context).translate('ingredients'),
                    style: textRegularStyle.copyWith(fontSize: 16),
                  ),
                  SizedBox(height: hp(1, context)),
                  Text(
                    widget.menuData.ingredients ?? '',
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
        builder: (context, cart_provider, __) {
          return Card(
            elevation: 4,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(15.0),
                  topLeft: Radius.circular(15.0)),
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
                        cart_provider.incrementCartCount();
                        var data = {
                          "menu_item": widget.menuData.id,
                          "quantity": cart_provider.quantity
                        };
                        cart_provider.addCart(
                            data, widget.menuData.id!, context);
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
                          AppLocalizations.of(context).translate('add_to_cart'),
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
