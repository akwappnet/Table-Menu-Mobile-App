import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:table_menu_customer/utils/assets/assets_utils.dart';
import 'package:table_menu_customer/utils/responsive.dart';
import 'package:table_menu_customer/utils/widgets/custom_text.dart';
import 'package:table_menu_customer/view_model/order_provider.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final order_provider = Provider.of<OrderProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text('My Orders'),
      ),
      body: SafeArea(
        child: StreamBuilder(
          stream: order_provider.getOrders().asStream(),
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
                              return GestureDetector(
                                onTap: () {},
                                child: Container(
                                  width: wp(100, context),
                                  child: Card(
                                    child: Container(
                                      padding: EdgeInsets.all(8.0),
                                      child: ListTile(
                                        leading: Image.asset(
                                          AssetsUtils.ASSETS_TABLE_MENU_LOGO,
                                          height: 100,
                                          width: 100,
                                        ),
                                        title: Column(
                                          children: [
                                            Row(
                                              children: [
                                                CustomText(
                                                  text:
                                                      "# ${ordersList[index].tableNo}",
                                                  size: 18,
                                                  color: Colors.purple,
                                                  weight: FontWeight.w500,
                                                ),
                                                const Spacer(),
                                                GestureDetector(
                                                  onTap: () {},
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
                                            const CustomText(
                                              text: "Item Name",
                                              size: 16,
                                              weight: FontWeight.w500,
                                              color: Colors.grey,
                                            ),
                                            const Divider(),
                                            const Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                CustomText(
                                                  text: "Price",
                                                  size: 14,
                                                  color: Colors.grey,
                                                ),
                                                CustomText(
                                                  text: "Quantity",
                                                  size: 14,
                                                  color: Colors.grey,
                                                ),
                                                CustomText(
                                                  text: "Total",
                                                  size: 14,
                                                  color: Colors.grey,
                                                ),
                                              ],
                                            ),
                                            const Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                CustomText(
                                                  text: "₹ 1000",
                                                  size: 16,
                                                  color: Colors.black,
                                                ),
                                                CustomText(
                                                  text: "6",
                                                  size: 16,
                                                  color: Colors.black,
                                                ),
                                                CustomText(
                                                  text: "6000",
                                                  size: 16,
                                                  color: Colors.black,
                                                ),
                                              ],
                                            ),
                                            const Divider(),
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
                                                  size: 16,
                                                  color: Colors.grey,
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
