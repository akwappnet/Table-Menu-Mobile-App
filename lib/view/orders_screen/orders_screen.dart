import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:table_menu_customer/utils/assets/assets_utils.dart';
import 'package:table_menu_customer/utils/responsive.dart';
import 'package:table_menu_customer/utils/routes/routes_name.dart';
import 'package:table_menu_customer/utils/widgets/custom_text.dart';
import 'package:table_menu_customer/utils/widgets/placeholder_widget.dart';
import 'package:table_menu_customer/view/orders_screen/widget/order_item_card_widget.dart';
import 'package:table_menu_customer/view_model/order_provider.dart';

import '../../utils/font/text_style.dart';
import '../../utils/widgets/custom_confirmation_dialog.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<OrderProvider>().getOrders(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        scrolledUnderElevation: 0.0,
        automaticallyImplyLeading: false,
        title: Text(
          'Orders',
          style: titleTextStyle,
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Consumer<OrderProvider>(
            builder: (context, order_provider, __) {
              return order_provider.loading
                  ? Center(
                      child: Lottie.asset(
                        AssetsUtils.ASSETS_LOADING_PURPLE_ANIMATION,
                        width: 100,
                        height: 100,
                        fit: BoxFit.fill,
                      ),
                    )
                  : Column(
                      children: [
                        Expanded(
                          child: (order_provider.orderList.isEmpty)
                              ? Container(
                            alignment: Alignment.center,
                                child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    PlaceholderWidget(title: "No Orders"),
                                  ],
                                ),
                              )
                              : ListView.builder(
                                  itemCount: order_provider.orderList.length,
                                  scrollDirection: Axis.vertical,
                                  itemBuilder: (context, index) {
                                    var order = order_provider.orderList[index];
                                    return OrderItemCardWidget(
                                      orderData: order,
                                      cancelCallback: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return CustomConfirmationDialog(
                                              title: 'Cancel Order',
                                              message:
                                                  'Are you sure you want to Cancel Your Order ?',
                                              onConfirm: () async {
                                                order_provider.cancelOrder(
                                                    order.id!, context);
                                                Navigator.of(context).pop();
                                              },
                                            );
                                          },
                                        );
                                      },
                                      trackOrderCallback: () {
                                        Navigator.pushNamed(
                                            context,
                                            RoutesName
                                                .ORDER_TRACKING_SCREEN_ROUTE,
                                            arguments: order.id);
                                      },
                                    );
                                  },
                                ),
                        ),
                      ],
                    );
            },
          ),
        ),
      ),
    );
  }
}
