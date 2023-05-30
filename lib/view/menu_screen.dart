import 'package:badges/badges.dart';
import 'package:flutter/material.dart' hide Badge;
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:table_menu_customer/model/custom_result_model.dart';
import 'package:table_menu_customer/repository/menu_repository.dart';
import 'package:table_menu_customer/res/services/api_endpoints.dart';
import 'package:table_menu_customer/utils/assets/assets_utils.dart';
import 'package:table_menu_customer/utils/routes/routes_name.dart';
import 'package:table_menu_customer/utils/widgets/custom_flushbar_widget.dart';
import 'package:table_menu_customer/view_model/notification_provider.dart';

import '../model/category_model.dart';
import '../model/menuItem_model.dart';
import '../utils/responsive.dart';
import '../utils/widgets/bottom_sheet_widget.dart';
import '../utils/widgets/custom_text.dart';
import '../view_model/auth_provider.dart';
import '../view_model/cart_provider.dart';
import '../view_model/menu_provider.dart';
import '../view_model/qr_provider.dart';

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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final MenuRepository _menuRepository = MenuRepository();
    // Future<bool> menuLoaded = _menuRepository.isLoadedMenu();
    final menu_provider = Provider.of<MenuProvider>(context);
    final qr_provider = Provider.of<QRProvider>(context);
    final notification_provider = Provider.of<NotificationProvider>(context);
    qr_provider.getVisibilityOfMenu();
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
              Navigator.pushNamed(context, RoutesName.NOTIFICATION_SCREEN_ROUTE);
            },
            icon: const Icon(
              Icons.notifications_none_outlined,
              color: Colors.black,
            ),
          ),
          Consumer<CartProvider>(
            builder: (_, cart_badge, __) {
              return Badge(
                badgeContent: Text(
                  "${cart_badge.counter}",
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                position: BadgePosition.custom(start: 28, bottom: 28),
                child: IconButton(
                  onPressed: () {
                    cart_badge.getCartItems(context);
                    Navigator.pushNamed(context, RoutesName.CART_SCREEN_ROUTE);
                  },
                  icon: const Icon(
                    Icons.shopping_bag_outlined,
                    color: Colors.black,
                  ),
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
        child: StreamBuilder<List<Data>>(
          stream: menu_provider.getCategories(context).asStream(),
          builder: (context, snapshot) {
            print("bool : ${qr_provider.isVisible}");
            if (snapshot.hasData) {
              var categories = snapshot.data;
              return (qr_provider.isVisible)
                  ? Container(
                      margin: const EdgeInsets.only(left: 10, top: 15),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                "Categories (${categories!.length})",
                                style: const TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 6.0,
                          ),
                          Flexible(
                              flex: 2,
                              child: (categories.isNotEmpty)
                                  ? ListView(
                                      scrollDirection: Axis.horizontal,
                                      shrinkWrap: true,
                                      children: <Widget>[
                                        GestureDetector(
                                          onTap: () {
                                            menu_provider.selectCategory(-1);
                                            menu_provider.setCategoryName("");
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
                                            itemCount: categories.length,
                                            itemBuilder: (context, index) {
                                              return GestureDetector(
                                                onTap: () {
                                                  print(index);
                                                  menu_provider
                                                      .selectCategory(index);
                                                  menu_provider.setCategoryName(
                                                      categories[index]
                                                          .categoryName!);
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
                                                              NetworkImage(ApiEndPoint
                                                                      .baseImageUrl +
                                                                  categories[
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
                                                        categories[index]
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
                                    )
                                  : Container()),
                          const SizedBox(
                            height: 10.0,
                          ),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Menu Items",
                                style: TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          StreamBuilder<List<MenuData>>(
                            stream: menu_provider
                                .getMenuItems(menu_provider.categoryName,context)
                                .asStream(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                var menu_items = snapshot.data;
                                return Expanded(
                                    flex: 5,
                                    child: (menu_items!.isEmpty)
                                        ? Center(
                                            child: Column(
                                              children: [
                                                const SizedBox(
                                                  height: 30,
                                                ),
                                                Image.asset(
                                                  AssetsUtils
                                                      .ASSETS_EMPTY_MENU_PLACEHOLDER,
                                                  height: 230,
                                                  width: 230,
                                                ),
                                                const Text(
                                                  "No Menu Items",
                                                  style: TextStyle(
                                                      fontSize: 22,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                              ],
                                            ),
                                          )
                                        : Consumer<CartProvider>(
                                            builder:
                                                (context, cart_provider, __) {
                                              return ListView.builder(
                                                itemCount: menu_items.length,
                                                scrollDirection: Axis.vertical,
                                                itemBuilder: (context, index) {
                                                  return GestureDetector(
                                                      onTap: () {
                                                        CustomBottomSheet
                                                            .showCustomModalBottomSheet(
                                                                plusButton: () {
                                                                  cart_provider
                                                                      .incrementItemQuantity();
                                                                },
                                                                minusButton:
                                                                    () {
                                                                  cart_provider
                                                                      .decrementItemQuantity();
                                                                },
                                                                onPressed: () async {
                                                                  cart_provider
                                                                      .incrementCartCount();
                                                                  var data = {
                                                                    "menu_item":
                                                                        menu_items[index]
                                                                            .id,
                                                                    "quantity":
                                                                        cart_provider
                                                                            .quantity
                                                                  };
                                                                 CustomResultModel? result = await cart_provider
                                                                      .addCart(
                                                                          context,
                                                                          data,
                                                                          menu_items[index]
                                                                              .id!);
                                                                  cart_provider
                                                                      .setQuantity(
                                                                      1);
                                                                  Navigator.pop(
                                                                      context);
                                                                  if(result!.status){
                                                                    CustomFlushbar.showSuccess(context, result.message);
                                                                  }else {
                                                                    CustomFlushbar.showError(context, result.message);
                                                                  }
                                                                },
                                                                context:
                                                                    context,
                                                                menuData:
                                                                    menu_items[
                                                                        index]);
                                                      },
                                                      child: Container(
                                                        width: wp(100, context),
                                                        child: Card(
                                                          child: Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: ListTile(
                                                              leading: Image.network(ApiEndPoint
                                                                          .baseImageUrl +
                                                                      menu_items[
                                                                              index]
                                                                          .image
                                                                          .toString() ??
                                                                  ''),
                                                              title: Column(
                                                                children: [
                                                                  Row(
                                                                    children: [
                                                                      (menu_items[index].isVeg ==
                                                                              true)
                                                                          ? Image
                                                                              .asset(
                                                                              AssetsUtils.ASSETS_VEG_ICON,
                                                                              height: 40,
                                                                              width: 40,
                                                                            )
                                                                          : Image
                                                                              .asset(
                                                                              AssetsUtils.ASSETS_NON_VEG_ICON,
                                                                              height: 35,
                                                                              width: 35,
                                                                            ),
                                                                      const Spacer(),
                                                                      (menu_items[index].isNew! ==
                                                                              true)
                                                                          ? Container(
                                                                              decoration: BoxDecoration(color: Colors.purple.shade200, borderRadius: const BorderRadius.all(Radius.circular(20))),
                                                                              padding: const EdgeInsets.all(8.0),
                                                                              child: const Text(
                                                                                "New",
                                                                                style: TextStyle(color: Colors.purple, fontSize: 14, fontWeight: FontWeight.bold),
                                                                              ),
                                                                            )
                                                                          : Container()
                                                                    ],
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 6,
                                                                  ),
                                                                  Row(
                                                                    children: [
                                                                      Text(
                                                                        menu_items[index]
                                                                            .name
                                                                            .toString(),
                                                                        style: const TextStyle(
                                                                            fontSize:
                                                                                20,
                                                                            fontWeight:
                                                                                FontWeight.w600,
                                                                            color: Colors.black),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 6,
                                                                  ),
                                                                  Row(
                                                                    children: [
                                                                      Text(
                                                                        menu_items[index]
                                                                            .ingredients
                                                                            .toString(),
                                                                        style:
                                                                            const TextStyle(
                                                                          fontSize:
                                                                              12,
                                                                          color:
                                                                              Colors.grey,
                                                                        ),
                                                                      )
                                                                    ],
                                                                  ),
                                                                  const Divider(
                                                                    height: 3,
                                                                    color: Colors
                                                                        .grey,
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 6,
                                                                  ),
                                                                  Row(
                                                                    children: [
                                                                      Text(
                                                                        "₹ ${menu_items[index].price.toString()}",
                                                                        style: const TextStyle(
                                                                            fontSize:
                                                                                16,
                                                                            fontWeight:
                                                                                FontWeight.bold),
                                                                      ),
                                                                      const Spacer(),
                                                                      (menu_items[index].isSpicy! ==
                                                                              true)
                                                                          ? const Text(
                                                                              "Spicy, ",
                                                                              style: TextStyle(
                                                                                fontSize: 12,
                                                                                color: Colors.grey,
                                                                              ),
                                                                            )
                                                                          : const Text(
                                                                              ""),
                                                                      (menu_items[index].isSweet! ==
                                                                              true)
                                                                          ? const Text(
                                                                              "Sweet, ",
                                                                              style: TextStyle(
                                                                                fontSize: 12,
                                                                                color: Colors.grey,
                                                                              ),
                                                                            )
                                                                          : const Text(
                                                                              ""),
                                                                      (menu_items[index].isSpecial! ==
                                                                              true)
                                                                          ? const Text(
                                                                              "Special, ",
                                                                              style: TextStyle(
                                                                                fontSize: 12,
                                                                                color: Colors.grey,
                                                                              ),
                                                                            )
                                                                          : const Text(
                                                                              ""),
                                                                      (menu_items[index].isPopular! ==
                                                                              true)
                                                                          ? const Text(
                                                                              "Popular ",
                                                                              style: TextStyle(
                                                                                fontSize: 12,
                                                                                color: Colors.grey,
                                                                              ),
                                                                            )
                                                                          : const Text(
                                                                              ""),
                                                                    ],
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 6,
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ));
                                                },
                                              );
                                            },
                                          ));
                              } else {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                            },
                          ),
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
                    );
            } else {
              return Center(
                child: Lottie.asset(
                  AssetsUtils.ASSETS_LOADING_PURPLE_ANIMATION,
                  width: 100,
                  height: 100,
                  fit: BoxFit.fill,
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
