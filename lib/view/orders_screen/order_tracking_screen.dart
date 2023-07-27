import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:table_menu_customer/utils/responsive.dart';
import 'package:table_menu_customer/utils/routes/routes_name.dart';

import '../../utils/assets/assets_utils.dart';
import '../../utils/font/text_style.dart';
import '../../utils/widgets/custom_button.dart';
import '../../view_model/order_provider.dart';

class OrderTrackingScreen extends StatefulWidget {
  const OrderTrackingScreen({super.key, this.order_id});

  final int? order_id;

  @override
  State<OrderTrackingScreen> createState() => _OrderTrackingScreenState();
}

class _OrderTrackingScreenState extends State<OrderTrackingScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<OrderProvider>().getSingleOrder(widget.order_id!, context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<OrderProvider>(
      builder: (context, order_provider, __) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Track Order',
                  style: textSmallRegularStyle,
                ),
                Text(
                  order_provider.orderTrackingData?.orderStatus ?? "",
                  style: smallTitleTextStyle.copyWith(
                      color: order_provider.orderTrackingData?.orderStatus ==
                              "pending"
                          ? Colors.amber
                          : Colors.green),
                ),
              ],
            ),
            backgroundColor: Colors.white,
            scrolledUnderElevation: 0.0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.popAndPushNamed(
                    context, RoutesName.HOME_SCREEN_ROUTE);
              },
            ),
          ),
          body: order_provider.orderTrackingData == null ?  Center(
            child: Lottie.asset(
              AssetsUtils.ASSETS_LOADING_PURPLE_ANIMATION,
              width: 100,
              height: 100,
              fit: BoxFit.fill,
            ),
          ) : SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: wp(2, context), vertical: hp(2, context)),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    SizedBox(
                      width: wp(100, context),
                      height: hp(41, context),
                      child: Card(
                        child: Column(
                          children: [
                            Text(
                              "Your order will be ready soon!",
                              style: titleTextStyle,
                            ),
                            SizedBox(
                              height: hp(2, context),
                            ),
                            Lottie.asset(
                              AssetsUtils.ASSETS_FOOD_PREPARING_ANIMATION,
                              width: wp(55, context),
                              height: hp(30, context),
                              fit: BoxFit.cover,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: wp(100, context),
                      child: Card(
                        child: Column(
                          children: [
                            Theme(
                              data: Theme.of(context)
                                  .copyWith(dividerColor: Colors.transparent,
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                hoverColor: Colors.transparent,),
                              child: ExpansionTile(
                                title: Text(
                                  "Order list and prices",
                                  style: textRegularStyle,
                                ),
                                backgroundColor: Colors.transparent,
                                maintainState: true,
                                children: <Widget>[
                                  ListView.builder(
                                    itemCount: order_provider.orderTrackingData!
                                        .orderTrackingCartItems!.length,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      var item = order_provider
                                          .orderTrackingData!
                                          .orderTrackingCartItems![index];
                                      return Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: wp(1, context)),
                                        decoration: const BoxDecoration(
                                          color: Colors.transparent,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            CachedNetworkImage(
                                              imageUrl: item.itemImage ?? "",
                                              imageBuilder:
                                                  (context, imageProvider) =>
                                                      Container(
                                                width: wp(10, context),
                                                height: hp(10, context),
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  image: DecorationImage(
                                                      image: imageProvider),
                                                ),
                                              ),
                                              placeholder: (context, url) =>
                                                  Image.asset(
                                                AssetsUtils
                                                    .ASSETS_PLACEHOLDER_IMAGE,
                                                width: wp(5, context),
                                                height: hp(4, context),
                                              ),
                                              // Show a placeholder while loading
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Image.asset(
                                                AssetsUtils.ASSETS_ERROR_IMAGE,
                                                width: wp(5, context),
                                                height: hp(4, context),
                                              ),
                                            ),
                                            Text(
                                              item.itemName ?? "",
                                              style: textBodyStyle,
                                            ),
                                            Text(
                                              "${item.quantity ?? 0}x",
                                              style: textBodyStyle.copyWith(
                                                  color: Colors.grey),
                                            ),
                                            Text("₹ ${item.itemPrice ?? 0.0}",
                                                style: textRegularStyle),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: hp(2, context),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.add,
                                  color: Colors.purple.shade400,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.popAndPushNamed(
                                        context, RoutesName.HOME_SCREEN_ROUTE);
                                  },
                                  child: Text(
                                    "Add more food items to order",
                                    style: textRegularStyle.copyWith(
                                        color: Colors.purple.shade300),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: hp(3, context),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: wp(2, context),
                                  vertical: hp(1, context)),
                              child: Column(
                                children: [
                                  const Divider(),
                                  Row(
                                    children: [
                                      Text(
                                        "Item total ",
                                        style: textRegularStyle.copyWith(
                                            color: Colors.grey),
                                      ),
                                      const Spacer(),
                                      Text(
                                        "₹ ${order_provider.orderTrackingData?.totalPrice ?? ""}",
                                        style: textBodyStyle.copyWith(
                                            color: Colors.black),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: hp(1, context),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Tax",
                                        style: textRegularStyle.copyWith(
                                            color: Colors.grey),
                                      ),
                                      const Spacer(),
                                      Text(
                                        "₹ 0",
                                        style: textBodyStyle.copyWith(
                                            color: Colors.black),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: hp(1, context),
                                  ),
                                  const Divider(),
                                  SizedBox(
                                    height: hp(1, context),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Total price",
                                        style: textRegularStyle.copyWith(
                                            color: Colors.grey),
                                      ),
                                      const Spacer(),
                                      Text(
                                        "₹ ${order_provider.orderTrackingData?.totalPrice ?? ""}",
                                        style: textBodyStyle.copyWith(
                                            color: Colors.black),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          bottomNavigationBar: Hero(
            tag: "checkout",
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: wp(1.5, context), vertical: hp(1.5, context)),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: hp(7.5, context),
                child: CustomButton(
                  onPressed: () async {
                    String total_price = order_provider.orderTrackingData?.totalPrice ?? "";
                    double totalPriceDouble = double.parse(total_price);
                    String formattedPrice = totalPriceDouble.toInt().toString();
                    Navigator.pushNamed(
                      context,
                      RoutesName.CHECKOUT_SCREEN_ROUTE,
                      arguments: [widget.order_id,formattedPrice],
                    );
                  },
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Check out",
                          style: textBodyStyle.copyWith(color: Colors.white),
                        ),
                        const Spacer(),
                        Text(
                          "₹ ${order_provider.orderTrackingData?.totalPrice ?? ""}",
                          style: textBodyStyle.copyWith(color: Colors.white),
                        ),
                      ],
                    ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
