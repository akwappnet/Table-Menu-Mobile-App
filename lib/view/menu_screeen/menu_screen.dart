import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart' hide Badge;
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:table_menu_customer/utils/assets/assets_utils.dart';
import 'package:table_menu_customer/utils/font/text_style.dart';
import 'package:table_menu_customer/utils/responsive.dart';
import 'package:table_menu_customer/utils/routes/routes_name.dart';
import 'package:table_menu_customer/view/menu_screeen/widget/menu_item_card_widget.dart';
import 'package:table_menu_customer/view_model/notification_provider.dart';

import '../../app_localizations.dart';
import '../../utils/constants/constants_text.dart';
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
    final qrProvider = Provider.of<QRProvider>(context);
    final notificationProvider = Provider.of<NotificationProvider>(context);
    qrProvider.getVisibilityOfMenu();
    return Consumer<MenuProvider>(
      builder: (_, menuProvider, __) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            scrolledUnderElevation: 0.0,
            automaticallyImplyLeading: false,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Consumer<AuthProvider>(
                  builder: (_, authProvider, __) {
                    return Text(
                      "${AppLocalizations.of(context).translate('hello')} ${authProvider.user_name}",
                      style: smallTitleTextStyle.copyWith(
                          fontFamily: fontSemiBold),
                    );
                  },
                ),
                Text(
                  AppLocalizations.of(context).translate('greeting_text'),
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                      color: Colors.grey),
                ),
              ],
            ),
            actions: [
              IconButton(
                onPressed: () {
                  notificationProvider.getAllNotification(context);
                  Navigator.pushNamed(
                      context, RoutesName.NOTIFICATION_SCREEN_ROUTE);
                },
                icon: const Icon(
                  Icons.notifications_none_outlined,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          body: SafeArea(
            child: menuProvider.menuitems.isNotEmpty ||
                    menuProvider.categories.isNotEmpty
                ? (qrProvider.isVisible)
                    ? Container(
                        margin: EdgeInsets.symmetric(
                            vertical: hp(1, context),
                            horizontal: wp(1, context)),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CarouselSlider.builder(
                                itemCount: AssetsUtils.bannerImageList.length,
                                itemBuilder: ((context, index, realIndex) {
                                  return GestureDetector(
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              BORDER_RADIUS),
                                          border: Border.all(
                                            color: Colors.white,
                                          )),
                                      //ClipRRect for image border radius
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                            BORDER_RADIUS),
                                        child: Image.asset(
                                          AssetsUtils.bannerImageList[index],
                                          width: wp(70, context),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    onTap: () {},
                                  );
                                }),
                                options: CarouselOptions(
                                  enlargeCenterPage: true,
                                  height: hp(20, context),
                                  autoPlay: true,
                                  autoPlayInterval: const Duration(seconds: 3),
                                  reverse: false,
                                  enableInfiniteScroll: true,
                                  aspectRatio: 5.0,
                                ),
                              ),
                              SizedBox(height: hp(1, context)),
                              Row(
                                children: [
                                  Text(
                                    "${AppLocalizations.of(context).translate('categories')} (${menuProvider.categories.length})",
                                    style: smallTitleTextStyle,
                                  ),
                                  const Spacer(),
                                  // IconButton(
                                  //   onPressed: () {
                                  //     filtersBottomSheet(context);
                                  //   },
                                  //   icon: Image.asset(
                                  //       AssetsUtils.ASSETS_FILTERS_ICON,
                                  //       height: hp(4, context),
                                  //       width: wp(5, context)),
                                  // )
                                ],
                              ),
                              SizedBox(
                                height: hp(0.5, context),
                              ),
                              SizedBox(
                                height: hp(18, context),
                                child: (menuProvider.loading)
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
                                              menuProvider.selectCategory(-1);
                                              menuProvider.setCategoryName(
                                                  "", context);
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
                                                      const BorderRadius.all(
                                                          Radius.circular(15)),
                                                  color: menuProvider
                                                              .isSelectedIndex ==
                                                          -1
                                                      ? Colors.grey.shade300
                                                      : Colors.white),
                                              child: Column(
                                                children: <Widget>[
                                                  Container(
                                                    margin: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 4),
                                                    child: CircleAvatar(
                                                      radius: 38,
                                                      child: CustomText(
                                                        text:
                                                            AppLocalizations.of(
                                                                    context)
                                                                .translate('a'),
                                                        size: 50,
                                                        weight: FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 2,
                                                  ),
                                                  Text(
                                                    AppLocalizations.of(context)
                                                        .translate('all'),
                                                    style: textBodyStyle,
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
                                              itemCount: menuProvider
                                                  .categories.length,
                                              itemBuilder: (context, index) {
                                                return GestureDetector(
                                                  onTap: () {
                                                    menuProvider
                                                        .selectCategory(index);
                                                    menuProvider
                                                        .setCategoryName(
                                                            menuProvider
                                                                .categories[
                                                                    index]
                                                                .categoryName!,
                                                            context);
                                                  },
                                                  child: Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            left: 8.0,
                                                            right: 8.0,
                                                            top: 8.0),
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            const BorderRadius
                                                                .all(
                                                                Radius.circular(
                                                                    15)),
                                                        color: menuProvider
                                                                    .isSelectedIndex ==
                                                                index
                                                            ? Colors
                                                                .grey.shade200
                                                            : Colors.white),
                                                    child: Column(
                                                      children: <Widget>[
                                                        Container(
                                                          margin:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      4),
                                                          child: CircleAvatar(
                                                            backgroundImage:
                                                                NetworkImage(menuProvider
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
                                                          menuProvider
                                                              .categories[index]
                                                              .categoryName!,
                                                          style: textBodyStyle,
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              }),
                                        ],
                                      ),
                              ),
                              SizedBox(
                                height: hp(1, context),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    AppLocalizations.of(context)
                                        .translate('menu_items'),
                                    style: smallTitleTextStyle,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: hp(1, context),
                              ),
                              Flexible(
                                child: (menuProvider.loading)
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
                                        builder: (context, cartProvider, __) {
                                          return GridView.builder(
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            gridDelegate:
                                                const SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 2,
                                              childAspectRatio: 0.82,
                                            ),
                                            itemCount:
                                                menuProvider.menuitems.length,
                                            shrinkWrap: true,
                                            itemBuilder: (context, index) {
                                              return GestureDetector(
                                                onTap: () {
                                                  Navigator.pushNamed(
                                                      context,
                                                      RoutesName
                                                          .MENU_ITEM_DETAILS_SCREEN_ROUTE,
                                                      arguments: menuProvider
                                                          .menuitems[index]);
                                                },
                                                child: Hero(
                                                  tag:
                                                      "menu-${menuProvider.menuitems[index].id}",
                                                  child: MenuItemGridCard(
                                                    image: menuProvider
                                                        .menuitems[index].image
                                                        .toString(),
                                                    name: menuProvider
                                                        .menuitems[index].name
                                                        .toString(),
                                                    price: double.parse(
                                                        menuProvider
                                                            .menuitems[index]
                                                            .price!),
                                                    rating: double.parse(
                                                        menuProvider
                                                                .menuitems[
                                                                    index]
                                                                .rating ??
                                                            "0.0"),
                                                    isVeg: menuProvider
                                                        .menuitems[index]
                                                        .isVeg!,
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
                        ),
                      )
                    : Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              AppLocalizations.of(context)
                                  .translate('scan_qr_code_text'),
                              style: textBodyStyle,
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
                : Container(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        PlaceholderWidget(
                            title: AppLocalizations.of(context)
                                .translate('placeholder_no_data')),
                      ],
                    ),
                  ),
          ),
        );
      },
    );
  }
}
