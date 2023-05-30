import 'package:badges/badges.dart';
import 'package:flutter/material.dart' hide Badge;
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:table_menu_customer/model/custom_result_model.dart';
import 'package:table_menu_customer/res/services/api_endpoints.dart';
import 'package:table_menu_customer/utils/assets/assets_utils.dart';
import 'package:table_menu_customer/utils/widgets/custom_flushbar_widget.dart';
import 'package:table_menu_customer/view_model/nav_provider.dart';
import 'package:table_menu_customer/view_model/qr_provider.dart';

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
    final order_provider = Provider.of<OrderProvider>(context, listen: false);
    final qr_provider = Provider.of<QRProvider>(context, listen: false);
    final cart_provider = Provider.of<CartProvider>(context, listen: false);
    final nav_provider = Provider.of<NavProvider>(context, listen: false);
    int userId = 0;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Cart'),
          actions: [
            Consumer<CartProvider>(
              builder: (context, cart_provider, __) {
                return cart_provider.cartList.length != 0 ?  InkWell(
                    onTap: () async{
                      CustomResultModel? result = await cart_provider.deleteAllCartItem(context);
                      if(result!.status){
                        CustomFlushbar.showSuccess(context, result.message);
                      }else {
                        CustomFlushbar.showError(context, result.message);
                      }
                    },
                    child: CustomText(
                      text: "Clear Cart",
                      size: 16,
                      color: Colors.red,
                    )
                ) : SizedBox.shrink();
              },
            ),
            const SizedBox(
              width: 20.0,
            ),
          ],
        ),
        body: SafeArea(
          child: StreamBuilder(
            stream: cart_provider.getCartItems(context).asStream(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var cart_items = snapshot.data;
                return Center(
                  child: Consumer<CartProvider>(
                    builder: (context, cart_provider, __) {
                      return Container(
                        margin: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Expanded(
                              child: (cart_items!.isEmpty)
                                  ? const Center(
                                      child: Text(
                                      'Your Cart is Empty',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.0),
                                    ))
                                  : ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: cart_items.length,
                                      itemBuilder: (context, index) {
                                        return Column(
                                          children: [
                                            Card(
                                              color: Colors.purple.shade50,
                                              elevation: 5.0,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Image.network(
                                                    ApiEndPoint.baseImageUrl +
                                                        cart_items[index]
                                                            .menuItemImage
                                                            .toString(),
                                                    height: 80,
                                                    width: 80,
                                                  ),
                                                  SizedBox(
                                                    width: 130,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
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
                                                                  fontSize:
                                                                      16.0),
                                                              children: [
                                                                TextSpan(
                                                                    text:
                                                                        '${cart_items[index].menuItemName.toString()}\n',
                                                                    style: const TextStyle(
                                                                        fontWeight:
                                                                            FontWeight.bold)),
                                                              ]),
                                                        ),
                                                        RichText(
                                                          maxLines: 1,
                                                          text: TextSpan(
                                                              text: 'Price: '
                                                                  r"₹",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .blueGrey
                                                                      .shade800,
                                                                  fontSize:
                                                                      16.0),
                                                              children: [
                                                                TextSpan(
                                                                    text:
                                                                        '${cart_items[index].totalPrice.toString()}\n',
                                                                    style: const TextStyle(
                                                                        fontWeight:
                                                                            FontWeight.bold)),
                                                              ]),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  PlusMinusButtons(
                                                    addQuantity: () {
                                                      cart_provider
                                                          .incrementItemQuantityUpdate(
                                                              cart_items[
                                                                  index]);
                                                      var data = {
                                                        "menu_item":
                                                            cart_items[index]
                                                                .menuItem,
                                                        "quantity":
                                                            cart_items[index]
                                                                .quantity
                                                      };
                                                      cart_provider
                                                          .updateItemQuantity(
                                                              context,
                                                              data,
                                                              cart_items[index]
                                                                  .id!);
                                                    },
                                                    deleteQuantity: () {
                                                      cart_provider
                                                          .decrementItemQuantityUpdate(
                                                              cart_items[
                                                                  index]);
                                                      var data = {
                                                        "menu_item":
                                                            cart_items[index]
                                                                .menuItem,
                                                        "quantity":
                                                            cart_items[index]
                                                                .quantity
                                                      };
                                                      cart_provider
                                                          .updateItemQuantity(
                                                              context,
                                                              data,
                                                              cart_items[index]
                                                                  .id!);
                                                    },
                                                    text: cart_items[index]
                                                        .quantity
                                                        .toString(),
                                                  ),
                                                  IconButton(
                                                      onPressed: () async {
                                                       CustomResultModel? result = await cart_provider
                                                            .deleteCartItem(
                                                                context,
                                                                cart_items[
                                                                        index]
                                                                    .id!);
                                                       cart_provider
                                                           .decrementCartCount();
                                                        if(result!.status){
                                                          CustomFlushbar.showSuccess(context, result.message);
                                                        }else {
                                                          CustomFlushbar.showError(context, result.message);
                                                        }
                                                      },
                                                      icon: Icon(
                                                        Icons.delete,
                                                        color:
                                                            Colors.red.shade800,
                                                      )),
                                                ],
                                              ),
                                            ),
                                          ],
                                        );
                                      }),
                            ),
                            ReusableWidget(
                                title: 'Sub-Total',
                                value: r'₹ ' +
                                    (cart_provider.totalPrice
                                            .toStringAsFixed(2) ??
                                        '0')),
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: 50,
                              child: CustomButton(
                                onPressed: () async {
                                  List.generate(cart_items.length, (index) {
                                    cartItemList.add(
                                        {"cart_item_id": cart_items[index].id});
                                  });
                                  var data = {
                                    "table_no": qr_provider.table_number,
                                    "cart_items": cartItemList
                                  };
                                  CustomResultModel? result = await order_provider.placeOrder(context, data);
                                  if(result!.status){
                                    cart_provider.clearCart();
                                    nav_provider.changeIndex(1);
                                    Navigator.of(context).pop();
                                    CustomFlushbar.showSuccess(context, result.message);
                                  }else {
                                    CustomFlushbar.showError(context, result.message);
                                  }

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
        ));
  }
}