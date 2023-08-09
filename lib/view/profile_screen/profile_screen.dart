import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:table_menu_customer/utils/font/text_style.dart';
import 'package:table_menu_customer/utils/responsive.dart';
import 'package:table_menu_customer/utils/routes/routes_name.dart';
import 'package:table_menu_customer/utils/widgets/custom_button.dart';
import 'package:table_menu_customer/utils/widgets/placeholder_widget.dart';
import 'package:table_menu_customer/view/profile_screen/widget/order_history_card_widget.dart';

import '../../app_localizations.dart';
import '../../utils/assets/assets_utils.dart';
import '../../utils/constants/constants_text.dart';
import '../../utils/functions/time_format_function.dart';
import '../../view_model/auth_provider.dart';
import '../../view_model/order_provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      Provider.of<AuthProvider>(context, listen: false).getUserInfo(context);
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<OrderProvider>().getOrdersHistory(context);
    });
    super.initState();
  }

  String getGreetingMessage() {
    var hour = DateTime.now().hour;

    if (hour >= 0 && hour < 12) {
      return AppLocalizations.of(context).translate('good_morning');
    } else if (hour >= 12 && hour < 17) {
      return AppLocalizations.of(context).translate('good_afternoon');
    } else if (hour >= 17 && hour < 20) {
      return AppLocalizations.of(context).translate('good_evening');
    } else {
      return AppLocalizations.of(context).translate('good_night');
    }
  }

  int? uid;

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, __) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: authProvider.userData != null
              ? AppBar(
                  backgroundColor: Colors.white,
                  automaticallyImplyLeading: false,
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        authProvider.user_name,
                        style:
                            titleTextStyle.copyWith(fontFamily: fontSemiBold),
                      ),
                      Text(
                        getGreetingMessage(),
                        style:
                            textSmallRegularStyle.copyWith(color: Colors.grey),
                      ),
                    ],
                  ),
                  actions: [
                    CircleAvatar(
                      radius: 22,
                      child: CachedNetworkImage(
                        fit: BoxFit.fill,
                        imageUrl: authProvider.userData!.profilePhotoUrl ?? "",
                        imageBuilder: (context, imageProvider) => Container(
                          width: wp(15, context),
                          height: hp(15, context),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: imageProvider, fit: BoxFit.cover),
                          ),
                        ),
                        errorWidget: (context, url, error) {
                          return Container(
                              padding: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.purple.shade200,
                              ),
                              child: const Icon(
                                Icons.person_outline,
                                color: Colors.purple,
                                size: 30,
                              ));
                        },
                      ),
                    ),
                  ],
                )
              : AppBar(
                  automaticallyImplyLeading: false,
                ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: authProvider.userData != null
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Divider(
                          height: 3,
                          color: Colors.black,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context,
                                RoutesName.ACCOUNT_DETAILS_SCREEN_ROUTE);
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: wp(2, context),
                                vertical: hp(1.5, context)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      AppLocalizations.of(context)
                                          .translate('my_account'),
                                      style: textBodyStyle,
                                    ),
                                    Text(
                                      AppLocalizations.of(context)
                                          .translate('my_account_sub_text'),
                                      style: textSmallRegularStyle.copyWith(
                                          color: Colors.grey),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        const Divider(),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context,
                                RoutesName.SETTINGS_OFFERS_SCREEN_ROUTE);
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: wp(2, context),
                                vertical: hp(1.5, context)),
                            child: Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      AppLocalizations.of(context)
                                          .translate('offers_and_discounts'),
                                      style: textBodyStyle,
                                    ),
                                    Text(
                                      AppLocalizations.of(context).translate(
                                          'offers_and_discounts_sub_text'),
                                      style: textSmallRegularStyle.copyWith(
                                          color: Colors.grey),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        const Divider(),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context,
                                RoutesName.CHANGE_LANGUAGE_SCREEN_ROUTE);
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: wp(2, context),
                                vertical: hp(1.5, context)),
                            child: Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      AppLocalizations.of(context)
                                          .translate('change_language'),
                                      style: textBodyStyle,
                                    ),
                                    Text(
                                      AppLocalizations.of(context).translate(
                                          'change_language_sub_text'),
                                      style: textSmallRegularStyle.copyWith(
                                          color: Colors.grey),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        const Divider(),
                        SizedBox(
                          height: hp(2, context),
                        ),
                        Text(
                          AppLocalizations.of(context).translate('past_orders'),
                          style: textRegularStyle.copyWith(color: Colors.grey),
                        ),
                        Consumer<OrderProvider>(
                          builder: (context, orderProvider, __) {
                            return SizedBox(
                              height: hp(12, context),
                              child: orderProvider.orderHistoryList.isNotEmpty
                                  ? ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemCount:
                                          orderProvider.orderHistoryList.length,
                                      itemBuilder: (context, index) {
                                        var order = orderProvider
                                            .orderHistoryList[index];
                                        return Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: wp(1, context)),
                                          child: orderProvider.loading
                                              ? Center(
                                                  child: Lottie.asset(
                                                    AssetsUtils
                                                        .ASSETS_LOADING_PURPLE_ANIMATION,
                                                    width: 100,
                                                    height: 100,
                                                    fit: BoxFit.fill,
                                                  ),
                                                )
                                              : GestureDetector(
                                                  onTap: () {
                                                    Navigator.pushNamed(
                                                        context,
                                                        RoutesName
                                                            .ORDERS_DETAILS_SCREEN_ROUTE,
                                                        arguments: order);
                                                  },
                                                  child: OrderHistoryCard(
                                                      orderId: order.id!,
                                                      orderStatus:
                                                          order.orderStatus!,
                                                      orderTime: getTimeAgo(
                                                          order.createdAt!),
                                                      totalPrice:
                                                          order.totalPrice!),
                                                ),
                                        );
                                      },
                                    )
                                  : Center(
                                      child: Text(
                                      AppLocalizations.of(context)
                                          .translate('no_past_orders'),
                                      style: textSmallMediumStyle,
                                    )),
                            );
                          },
                        ),
                        SizedBox(
                          height: hp(2, context),
                        ),
                        SizedBox(
                          width: wp(40, context),
                          height: hp(7.5, context),
                          child: CustomButton(
                            onPressed: () {
                              authProvider.logout(context);
                            },
                            child: Text(
                              AppLocalizations.of(context).translate('logout'),
                              style:
                                  textBodyStyle.copyWith(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    )
                  : Center(
                      child: PlaceholderWidget(
                          title: AppLocalizations.of(context)
                              .translate('placeholder_no_data'))),
            ),
          ),
        );
      },
    );
  }
}
