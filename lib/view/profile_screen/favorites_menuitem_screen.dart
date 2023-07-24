import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:table_menu_customer/utils/font/text_style.dart';
import 'package:table_menu_customer/utils/responsive.dart';
import 'package:table_menu_customer/view/menu_screeen/widget/menu_item_card_widget.dart';

import '../../utils/assets/assets_utils.dart';
import '../../utils/widgets/placeholder_widget.dart';
import '../../view_model/menu_provider.dart';

class FavoritesMenuItems extends StatefulWidget {
  const FavoritesMenuItems({super.key});

  @override
  State<FavoritesMenuItems> createState() => _FavoritesMenuItemsState();
}

class _FavoritesMenuItemsState extends State<FavoritesMenuItems> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MenuProvider>().getMenuItems(
          context: context, categoryName: "", fillterFavorites: true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MenuProvider>(
      builder: (context, menu_provider, __) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text(
              "Favorites",
              style: titleTextStyle,
            ),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(
                vertical: hp(2, context), horizontal: wp(1, context)),
            child: menu_provider.loading
                ? Center(
                    child: Lottie.asset(
                      AssetsUtils.ASSETS_LOADING_PURPLE_ANIMATION,
                      width: 100,
                      height: 100,
                      fit: BoxFit.fill,
                    ),
                  )
                : Container(
                    margin: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Expanded(
                          child: menu_provider.favMenuitems.isEmpty
                              ? const Center(
                                  child: PlaceholderWidget(
                                      title: "NO FAVORITES MENU ITEMS"))
                              : ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: menu_provider.favMenuitems.length,
                                  itemBuilder: (context, index) {
                                    var favMenuItem =
                                        menu_provider.favMenuitems[index];
                                    return MenuItemGridCard(
                                        image: favMenuItem.image ?? "",
                                        name: favMenuItem.name ?? "",
                                        price: favMenuItem.price != null ?double.parse(favMenuItem.price!) : 0.0,
                                        rating: favMenuItem.rating != null ?
                                            double.parse(favMenuItem.rating!) : 0.0,
                                        isVeg: favMenuItem.isVeg!);
                                  },
                                ),
                        ),
                      ],
                    ),
                  ),
          ),
        );
      },
    );
  }
}
