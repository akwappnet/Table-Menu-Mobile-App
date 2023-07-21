import 'package:flutter/material.dart' hide Badge;
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:table_menu_customer/utils/assets/assets_utils.dart';
import 'package:table_menu_customer/utils/routes/routes_name.dart';
import 'package:table_menu_customer/view/menu_screeen/widget/filters_bottom_sheet_widget.dart';
import 'package:table_menu_customer/view/menu_screeen/widget/menu_item_card_widget.dart';
import 'package:table_menu_customer/view_model/notification_provider.dart';

import '../../utils/widgets/custom_text.dart';
import '../../utils/widgets/placeholder_widget.dart';
import '../../view_model/auth_provider.dart';
import '../../view_model/cart_provider.dart';
import '../../view_model/menu_provider.dart';
import '../../view_model/qr_provider.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      Provider.of<AuthProvider>(context, listen: false).getUserInfo(context);
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MenuProvider>().getCategories(context);
      context
          .read<MenuProvider>()
          .getMenuItems(context: context, categoryName: "");
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final qr_provider = Provider.of<QRProvider>(context);
    final notification_provider = Provider.of<NotificationProvider>(context);
    qr_provider.getVisibilityOfMenu();
    return Consumer<MenuProvider>(
      builder: (_, menu_provider, __) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0.0,
            foregroundColor: Colors.white,
            scrolledUnderElevation: 0.0,
            automaticallyImplyLeading: false,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Consumer<AuthProvider>(
                  builder: (_, auth_provider, __) {
                    return Text(
                      "Hello, ${auth_provider.user_name}",
                      style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    );
                  },
                ),
                const Text(
                  "Welcome Back Have A Nice Day",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                      color: Colors.grey),
                ),
              ],
            ),
            actions: [
              IconButton(
                onPressed: () {
                  notification_provider.getAllNotification(context);
                  Navigator.pushNamed(
                      context, RoutesName.NOTIFICATION_SCREEN_ROUTE);
                },
                icon: const Icon(
                  Icons.notifications_none_outlined,
                  color: Colors.black,
                ),
              ),
              Consumer<CartProvider>(
                builder: (_, cart_provider, __) {
                  return IconButton(
                    onPressed: () {
                      cart_provider.getCartItems(context);
                      Navigator.pushNamed(
                          context, RoutesName.CART_SCREEN_ROUTE);
                    },
                    icon: const Icon(
                      Icons.shopping_bag_outlined,
                      color: Colors.black,
                    ),
                  );
                },
              ),
              const SizedBox(
                width: 20.0,
              ),
            ],
          ),
          body: SafeArea(
            child: menu_provider.menuitems.isNotEmpty ||
                    menu_provider.categories.isNotEmpty
                ? (qr_provider.isVisible)
                    ? Container(
                        margin: const EdgeInsets.only(left: 10, top: 15),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Categories (${menu_provider.categories.length})",
                                  style: const TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w500),
                                ),
                                const Spacer(),
                                IconButton(
                                    onPressed: () {
                                      filtersBottomSheet(context);
                                    },
                                    icon: const Icon(Icons.filter_alt_outlined,
                                        color: Colors.black)),
                              ],
                            ),
                            const SizedBox(
                              height: 6.0,
                            ),
                            Flexible(
                              flex: 2,
                              child: (menu_provider.loading)
                                  ? Center(
                                      child: Lottie.asset(
                                        AssetsUtils
                                            .ASSETS_LOADING_PURPLE_ANIMATION,
                                        width: 100,
                                        height: 100,
                                        fit: BoxFit.fill,
                                      ),
                                    )
                                  : ListView(
                                      scrollDirection: Axis.horizontal,
                                      shrinkWrap: true,
                                      children: <Widget>[
                                        GestureDetector(
                                          onTap: () {
                                            menu_provider.selectCategory(-1);
                                            menu_provider.setCategoryName(
                                                "", context);
                                          },
                                          child: Container(
                                            margin: const EdgeInsets.only(
                                                left: 8.0,
                                                right: 8.0,
                                                top: 8.0),
                                            padding: const EdgeInsets.all(8.0),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(15)),
                                                color: menu_provider
                                                            .isSelectedIndex ==
                                                        -1
                                                    ? Colors.grey.shade300
                                                    : Colors.white),
                                            child: Column(
                                              children: <Widget>[
                                                Container(
                                                  margin: const EdgeInsets
                                                      .symmetric(horizontal: 4),
                                                  child: const CircleAvatar(
                                                    radius: 38,
                                                    child: CustomText(
                                                      text: "A",
                                                      size: 50,
                                                      weight: FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 2,
                                                ),
                                                const Text(
                                                  "All",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        ListView.builder(
                                            shrinkWrap: true,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            scrollDirection: Axis.horizontal,
                                            itemCount:
                                                menu_provider.categories.length,
                                            itemBuilder: (context, index) {
                                              return GestureDetector(
                                                onTap: () {
                                                  menu_provider
                                                      .selectCategory(index);
                                                  menu_provider.setCategoryName(
                                                      menu_provider
                                                          .categories[index]
                                                          .categoryName!,
                                                      context);
                                                },
                                                child: Container(
                                                  margin: const EdgeInsets.only(
                                                      left: 8.0,
                                                      right: 8.0,
                                                      top: 8.0),
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          const BorderRadius
                                                              .all(
                                                              Radius.circular(
                                                                  15)),
                                                      color: menu_provider
                                                                  .isSelectedIndex ==
                                                              index
                                                          ? Colors.grey.shade200
                                                          : Colors.white),
                                                  child: Column(
                                                    children: <Widget>[
                                                      Container(
                                                        margin: const EdgeInsets
                                                            .symmetric(
                                                            horizontal: 4),
                                                        child: CircleAvatar(
                                                          backgroundImage:
                                                              NetworkImage(
                                                                  menu_provider
                                                                      .categories[
                                                                          index]
                                                                      .categoryImg
                                                                      .toString()),
                                                          radius: 38,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 2,
                                                      ),
                                                      Text(
                                                        menu_provider
                                                            .categories[index]
                                                            .categoryName!,
                                                        style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 16,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              );
                                            }),
                                      ],
                                    ),
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "Menu Items",
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Expanded(
                              flex: 5,
                              child: (menu_provider.loading)
                                  ? Center(
                                      child: Lottie.asset(
                                        AssetsUtils
                                            .ASSETS_LOADING_PURPLE_ANIMATION,
                                        width: 100,
                                        height: 100,
                                        fit: BoxFit.fill,
                                      ),
                                    )
                                  : Consumer<CartProvider>(
                                      builder: (context, cart_provider, __) {
                                        return GridView.builder(
                                          gridDelegate:
                                              const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount:
                                                2, // Number of columns in the grid
                                            childAspectRatio:
                                                0.82, // Width to height ratio of each item
                                          ),
                                          itemCount:
                                              menu_provider.menuitems.length,
                                          shrinkWrap: true,
                                          itemBuilder: (context, index) {
                                            return GestureDetector(
                                              onTap: () {
                                                Navigator.pushNamed(
                                                    context,
                                                    RoutesName
                                                        .MENU_ITEM_DETAILS_SCREEN_ROUTE,
                                                    arguments: menu_provider
                                                        .menuitems[index]);
                                                // CustomBottomSheet.showCustomModalBottomSheet(
                                                //   plusButton: () {
                                                //     cart_provider.incrementItemQuantity();
                                                //   },
                                                //   minusButton: () {
                                                //     cart_provider.decrementItemQuantity();
                                                //   },
                                                //   onPressed: () async {
                                                //     cart_provider.incrementCartCount();
                                                //     var data = {
                                                //       "menu_item": menu_items[index].id,
                                                //       "quantity": cart_provider.quantity,
                                                //     };
                                                //     CustomResultModel? result = await cart_provider.addCart(data, menu_items[index].id!);
                                                //     cart_provider.setQuantity(1);
                                                //     Navigator.pop(context);
                                                //     if (result!.status) {
                                                //       CustomFlushbar.showSuccess(context, result.message);
                                                //     } else {
                                                //       CustomFlushbar.showError(context, result.message);
                                                //     }
                                                //   },
                                                //   context: context,
                                                //   menuData: menu_items[index],
                                                // );
                                              },
                                              child: Hero(
                                                tag:
                                                    "menu-${menu_provider.menuitems[index].id}",
                                                child: MenuItemGridCard(
                                                  image: menu_provider
                                                      .menuitems[index].image
                                                      .toString(),
                                                  name: menu_provider
                                                      .menuitems[index].name
                                                      .toString(),
                                                  price: double.parse(
                                                      menu_provider
                                                          .menuitems[index]
                                                          .price!),
                                                  rating: double.parse(
                                                      menu_provider
                                                              .menuitems[index]
                                                              .rating ??
                                                          "0.0"),
                                                  isVeg: menu_provider
                                                      .menuitems[index].isVeg!,
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                    ),
                            )
                          ],
                        ),
                      )
                    : Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Scan Qr Code available on your table",
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                Future.delayed(Duration.zero, () {
                                  Navigator.pushNamed(context,
                                      RoutesName.QR_SCANNER_SCREEN_ROUTE);
                                });
                              },
                              icon: const Icon(
                                Icons.qr_code_scanner,
                                size: 35,
                              ),
                            ),
                          ],
                        ),
                      )
                : const Center(child: PlaceholderWidget(title: "NO DATA")),
          ),
        );
      },
    );
  }
}
