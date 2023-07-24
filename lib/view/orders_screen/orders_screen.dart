import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:table_menu_customer/utils/assets/assets_utils.dart';
import 'package:table_menu_customer/utils/responsive.dart';
import 'package:table_menu_customer/utils/widgets/custom_text.dart';
import 'package:table_menu_customer/view/orders_screen/widget/orders_items_list_widget.dart';
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
        title: Text('Orders', style: titleTextStyle,),
      ),
      body: SafeArea(
        child: Center(
          child: Consumer<OrderProvider>(
            builder: (context, order_provider, __) {
              return order_provider.loading ?
              Center(
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
                      child: (order_provider.orderList.isEmpty) ? Center(
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
                      ) : ListView.builder(
                        itemCount: order_provider.orderList.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          var order = order_provider.orderList[index];
                          DateTime dateTime =
                          DateTime.parse(order.createdAt!);
                          String formattedDate =
                          DateFormat('yyyy-MM-dd').format(dateTime);
                          return GestureDetector(
                            onTap: () {},
                            child: SizedBox(
                              width: wp(100, context),
                              child: Card(
                                child: Container(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ListTile(
                                    title: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          children: [
                                            CustomText(
                                              text:
                                              "Order ID #${order.id}",
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
                                                      'Are you sure you want to Cancel Your Order ?',
                                                      onConfirm: () async {
                                                        order_provider
                                                            .cancelOrder(order.id!, context);
                                                        Navigator.of(context)
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
                                                  const EdgeInsets.all(0),
                                                  child: const Icon(
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
                                            const Spacer(),
                                          ],
                                        ),
                                        ExpansionTile(
                                          leading: CustomText(
                                            text:
                                            'Order Items (${order.cartItems?.length})',
                                            color: Colors.black,
                                            size: 16,
                                          ),
                                          title: const Text(""),
                                          childrenPadding:
                                          const EdgeInsets.all(0.0),
                                          children: [
                                            OrdersItemListWidget(
                                                ordersItems:order.cartItems!)
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            const CustomText(
                                              text: "Status",
                                              size: 16,
                                              color: Colors.black,
                                            ),
                                            const Spacer(),
                                            CustomText(
                                              text:
                                              "${order.orderStatus}",
                                              size: 18,
                                              weight: FontWeight.w400,
                                              color: order.orderStatus ==
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
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
