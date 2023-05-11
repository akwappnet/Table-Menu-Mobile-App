import 'package:badges/badges.dart';
import 'package:flutter/material.dart' hide Badge;
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:table_menu_customer/res/services/api_endpoints.dart';
import 'package:table_menu_customer/utils/responsive.dart';
import '../utils/widgets/custom_button.dart';
import '../utils/widgets/custom_text.dart';
import '../utils/widgets/plus_minus_button_widget.dart';
import '../utils/widgets/reusable_widget.dart';
import '../view_model/cart_provider.dart';
import '../view_model/order_provider.dart';


class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<Map<String, dynamic>> cartItemList = [];

  @override
  Widget build(BuildContext context) {
    final cart_provider = Provider.of<CartProvider>(context);
    final order_provider = Provider.of<OrderProvider>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Cart'),
        actions: [
          Badge(
            badgeContent: Text(
              "${cart_provider.counter}",
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
            position: BadgePosition.custom(start: 28, bottom: 28),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.shopping_bag_outlined, color: Colors.black,),
            ),
          ),
          const SizedBox(
            width: 20.0,
          ),
        ],
      ),
      body: SafeArea(
        child: StreamBuilder(
          stream: cart_provider.getCartItems().asStream(),
          builder: (context, snapshot){
            if(snapshot.hasData){
              var cart_items = snapshot.data;
              return Center(
                child: Container(
                  margin: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Expanded(
                        child: (cart_items!.isEmpty) ?
                        const Center(
                            child: Text(
                              'Your Cart is Empty',
                              style:
                              TextStyle(fontWeight: FontWeight.bold,
                                  fontSize: 18.0),
                            )) :
                        ListView.builder(
                            shrinkWrap: true,
                            itemCount: cart_items.length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  Card(
                                    color: Colors.purple.shade50,
                                    elevation: 5.0,
                                    child: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .spaceEvenly,
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                           Image.network(
                                            ApiEndPoint.baseImageUrl +cart_items[index].menuItemImage.toString(),
                                            height: 80,
                                            width: 80,
                                          ),
                                          SizedBox(
                                            width: 130,
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                const SizedBox(
                                                  height: 5.0,
                                                ),
                                                RichText(
                                                  overflow: TextOverflow
                                                      .ellipsis,
                                                  maxLines: 1,
                                                  text: TextSpan(
                                                      text: 'Name: ',
                                                      style: TextStyle(
                                                          color: Colors
                                                              .blueGrey
                                                              .shade800,
                                                          fontSize: 16.0),
                                                      children: [
                                                        TextSpan(
                                                            text:
                                                            '${cart_items[index]
                                                                .menuItemName
                                                                .toString()}\n',
                                                            style: const TextStyle(
                                                                fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                      ]
                                                  ),
                                                ),
                                                RichText(
                                                  maxLines: 1,
                                                  text: TextSpan(
                                                      text: 'Price: ' r"₹",
                                                      style: TextStyle(
                                                          color: Colors
                                                              .blueGrey
                                                              .shade800,
                                                          fontSize: 16.0),
                                                      children: [
                                                        TextSpan(
                                                            text:
                                                            '${cart_items[index]
                                                                .menuItemPrice
                                                                .toString()}\n',
                                                            style: const TextStyle(
                                                                fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                      ]),
                                                ),
                                              ],
                                            ),
                                          ),
                                          PlusMinusButtons(
                                            addQuantity: () {
                                              var data = {
                                                "menu_item":44,
                                                "quantity":4
                                              };
                                              cart_provider.updateCart(context, data, cart_items[index].id!);
                                            },
                                            deleteQuantity: () {
                                              var data = {
                                                "menu_item":44,
                                                "quantity":4
                                              };
                                              cart_provider.updateCart(context, data, cart_items[index].id!);
                                            },
                                            text: cart_items.length.toString(),
                                          ),
                                          IconButton(
                                              onPressed: () {
                                                cart_provider
                                                    .deleteCartItem(context,
                                                    cart_items[index]
                                                        .id!);
                                              },
                                              icon: Icon(
                                                Icons.delete,
                                                color: Colors.red.shade800,
                                              )),
                                        ],
                                      ),
                                    ),
                                  ),
                                  // const Spacer(),
                                ],
                              );
                            }),
                      ),
                      ReusableWidget(
                          title: 'Sub-Total',
                          value: r'₹ ' +
                              (cart_items.length
                                  .toStringAsFixed(2) ?? '0')),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        child: CustomButton(
                          onPressed: () {
                            List.generate(cart_items.length, (index) => cartItemList.add(cart_items[index].toJson()));
                            var data = {
                              "user": 1,
                              "table_no":5,
                              "cart_items": cartItemList
                            };
                            order_provider.placeOrder(context, data);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Order Done'),
                                duration: Duration(seconds: 2),
                              ),
                            );
                            Navigator.pop(context);
                          },
                          child: const CustomText(
                            text: "Place Order",
                            color: Colors.white,
                            size: 18.0,
                            weight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            }else {
              return Lottie.asset(
                'assets/lotti_animation/loading_animation.json',
                width: 100,
                height: 100,
                fit: BoxFit.fill,
              );
            }
          },
        ),
      ),
    );
  }
}