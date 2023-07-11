import 'package:flutter/material.dart';
import 'package:table_menu_customer/utils/constants/api_endpoints.dart';

import '../../../model/order_model.dart';
import '../../../utils/widgets/custom_text.dart';

class OrdersItemListWidget extends StatelessWidget {
  const OrdersItemListWidget({Key? key, required this.ordersItems})
      : super(key: key);
  final List<CartItems> ordersItems;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: ordersItems.length,
      itemBuilder: (context, index) {
        if (ordersItems.isNotEmpty) {
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            child: Card(
              color: Colors.purple.shade50,
              child: ListTile(
                leading: SizedBox(
                  height: 100,
                  width: 100,
                  child: Image.network(
                    ApiEndPoint.orderEndPoint.orderBaseImageUrl +
                        ordersItems[index].itemImage.toString(),
                    height: 100,
                    width: 100,
                  ),
                ),
                title: Column(
                  children: [
                    Row(
                      children: [
                        CustomText(
                          text: "${ordersItems[index].itemName}",
                          size: 16,
                          weight: FontWeight.w500,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                    const Divider(),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          text: "₹ ${ordersItems[index].itemPrice}",
                          size: 16,
                          color: Colors.black,
                        ),
                        CustomText(
                          text: "${ordersItems[index].quantity}",
                          size: 16,
                          color: Colors.black,
                        ),
                        CustomText(
                          text: "₹ ${ordersItems[index].total}",
                          size: 16,
                          color: Colors.black,
                        ),
                      ],
                    ),
                    const Divider(),
                  ],
                ),
              ),
            ),
          );
        } else {
          // TODO display proper placeholder for empty list
          return const Text("NO ITEMS ");
        }
      },
    );
  }
}
