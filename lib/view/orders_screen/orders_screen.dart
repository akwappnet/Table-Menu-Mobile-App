import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:table_menu_customer/utils/assets/assets_utils.dart';
import 'package:table_menu_customer/utils/responsive.dart';
import 'package:table_menu_customer/utils/widgets/custom_text.dart';
import 'package:table_menu_customer/view/orders_screen/orders_items_list_widget.dart';
import 'package:table_menu_customer/view_model/order_provider.dart';

import '../../utils/widgets/custom_confirmation_dialog.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final order_provider = Provider.of<OrderProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        scrolledUnderElevation: 0.0,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text('My Orders'),
      ),
      body: SafeArea(
        child: StreamBuilder(
          stream: order_provider.getOrders(context).asStream(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var ordersList = snapshot.data;
              print(ordersList);
              return (ordersList!.isEmpty)
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 30,
                          ),
                          Image.asset(
                            AssetsUtils.ASSETS_EMPTY_MENU_PLACEHOLDER,
                            height: 230,
                            width: 230,
                          ),
                          const Text(
                            "No Orders",
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    )
                  : Expanded(
                      child: Consumer<OrderProvider>(
                        builder: (context, order_provider, __) {
                          return ListView.builder(
                            itemCount: ordersList.length,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) {
                              DateTime dateTime =
                                  DateTime.parse(ordersList[index].createdAt!);
                              String formattedDate =
                                  DateFormat('yyyy-MM-dd').format(dateTime);
                              return GestureDetector(
                                onTap: () {},
                                child: Container(
                                  width: wp(100, context),
                                  child: Card(
                                    child: Container(
                                      padding: EdgeInsets.all(8.0),
                                      child: ListTile(
                                        title: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                CustomText(
                                                  text:
                                                      "Order ID #${ordersList[index].id}",
                                                  size: 18,
                                                  color: Colors.purple,
                                                  weight: FontWeight.w500,
                                                ),
                                                const Spacer(),
                                                GestureDetector(
                                                  onTap: () {
                                                    showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return CustomConfirmationDialog(
                                                          title: 'Cancel Order',
                                                          message:
                                                              'Are you sure you want to Cancel Your Order?',
                                                          onConfirm: () {
                                                            order_provider
                                                                .cancelOrder(
                                                                    context,
                                                                    ordersList[
                                                                            index]
                                                                        .id!);
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                        );
                                                      },
                                                    );
                                                  },
                                                  child: Container(
                                                      color:
                                                          Colors.purple.shade50,
                                                      padding:
                                                          EdgeInsets.all(0),
                                                      child: Icon(
                                                        Icons.close,
                                                        color: Colors.red,
                                                      )),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                CustomText(
                                                  text:
                                                      formattedDate.toString(),
                                                  size: 16,
                                                  color: Colors.black,
                                                ),
                                                Spacer(),
                                              ],
                                            ),
                                            ExpansionTile(
                                              leading: CustomText(
                                                text:
                                                    'Order Items (${ordersList[index].cartItems?.length})',
                                                color: Colors.black,
                                                size: 16,
                                              ),
                                              title: Text(""),
                                              childrenPadding:
                                                  EdgeInsets.all(0.0),
                                              children: [
                                                OrdersItemListWidget(
                                                    ordersItems:
                                                        ordersList[index]
                                                            .cartItems!)
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                CustomText(
                                                  text: "Status",
                                                  size: 16,
                                                  color: Colors.black,
                                                ),
                                                Spacer(),
                                                CustomText(
                                                  text:
                                                      "${ordersList[index].orderStatus}",
                                                  size: 18,
                                                  weight: FontWeight.w400,
                                                  color: ordersList[index]
                                                              .orderStatus ==
                                                          "completed"
                                                      ? Colors.green
                                                      : Colors.amber,
                                                ),
                                              ],
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
                        },
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
