import 'package:flutter/material.dart' hide Badge;
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:table_menu_customer/model/custom_result_model.dart';
import 'package:table_menu_customer/utils/assets/assets_utils.dart';
import 'package:table_menu_customer/utils/responsive.dart';
import 'package:table_menu_customer/utils/routes/routes_name.dart';
import 'package:table_menu_customer/utils/widgets/custom_flushbar_widget.dart';
import 'package:table_menu_customer/utils/widgets/placeholder_widget.dart';
import 'package:table_menu_customer/view/cart_screen/widget/cart_item_card_widget.dart';
import 'package:table_menu_customer/view/cart_screen/widget/cooking_instruction_bottom_sheet_widget.dart';
import 'package:table_menu_customer/view_model/qr_provider.dart';

import '../../utils/constants/constants_text.dart';
import '../../utils/font/text_style.dart';
import '../../utils/widgets/custom_button.dart';
import '../../view_model/cart_provider.dart';
import '../../view_model/order_provider.dart';

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
    return Scaffold(
      backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          scrolledUnderElevation: 0.0,
          centerTitle: true,
          title: Text('Checkout',style:titleTextStyle,),
        ),
        body: SingleChildScrollView(
          child: SafeArea(
            child: StreamBuilder(
              stream: cart_provider.getCartItems().asStream(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var cart_items = snapshot.data;
                  return Center(
                    child: Consumer<CartProvider>(
                      builder: (context, cart_provider, __) {
                        return cart_provider.cartList.isEmpty ? const PlaceholderWidget(title: "Your cart is empty") : Container(
                          padding: EdgeInsets.symmetric(horizontal: wp(2, context),vertical: hp(2, context)),
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: wp(2, context)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "My Order",
                                      style: smallTitleTextStyle,
                                    ),
                                    const Spacer(),
                                    Icon(Icons.add,color: Colors.purple.shade400,),
                                    GestureDetector(
                                      onTap: () {},
                                      child: Text(
                                        "Add Items",
                                        style: textSmallRegularStyle.copyWith(
                                          color: Colors.purple.shade300
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              (cart_items!.isEmpty)
                                  ? const Center(
                                      child: Text(
                                      'Your Cart is Empty',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.0),
                                    ))
                                  : ListView.builder(
                                    physics: const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: cart_items.length,
                                      itemBuilder: (context, index) {
                                        return CartItemCard(itemName: cart_items[index].menuItemName!,
                                        imageUrl: cart_items[index].menuItemImage!,
                                        price: cart_items[index].menuItemPrice!,);
                                      }),
                              SizedBox(height: hp(2, context),),
                              GestureDetector(
                                onTap: () => showAddInstructionModal(context),
                                child: Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        const Icon(Icons.edit_note_outlined,color: Colors.black,),
                                        SizedBox(width: wp(0.8, context),),
                                        Text("Add cooking instructions",style: textSmallRegularStyle,),
                                        const Spacer(),
                                        const Icon(Icons.arrow_forward_ios_outlined,color: Colors.black,size: 18,),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: hp(2, context),),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: wp(2, context)),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "Payment",
                                          style: smallTitleTextStyle,
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: hp(2, context),),
                                    Row(
                                      children: [
                                        Text("Sub-Total", style: textBodyStyle),
                                        const Spacer(),
                                        Text("₹ ${cart_provider.totalPrice
                                            .toStringAsFixed(1)}", style: textRegularStyle),
                                      ],
                                    ),
                                    SizedBox(height: hp(2, context),),
                                    Row(
                                      children: [
                                        Text("GST and restaurant charges", style: textBodyStyle),
                                        SizedBox(width: wp(0.3, context),),
                                        GestureDetector(onTap:(){
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                contentPadding: EdgeInsets.symmetric(horizontal: wp(2, context),vertical: hp(2, context)),
                                                content: Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                      children: [
                                                        SizedBox(width: wp(2, context),),
                                                        Text("GST and restaurant charges",style: textBodyStyle,),
                                                        SizedBox(width: wp(2, context),),
                                                        GestureDetector(
                                                          onTap: () {
                                                            Navigator.of(context).pop();
                                                          },
                                                          child: const Icon(
                                                            Icons.close,
                                                            size: 20,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: hp(2, context),),
                                                    Padding(
                                                      padding: EdgeInsets.symmetric(horizontal: wp(2, context)),
                                                      child: Row(
                                                        children: [
                                                          Text("Service charges 10%",style: textSmallRegularStyle.copyWith(
                                                            fontFamily: fontSemiBold,
                                                          ),),
                                                          const Spacer(),
                                                          Text("00.0", style : textSmallRegularStyle),
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.symmetric(horizontal: wp(2, context)),
                                                      child: Row(
                                                        children: [
                                                          Text("SGST 6%",style: textSmallRegularStyle.copyWith(
                                                            fontFamily: fontSemiBold,
                                                          ),),
                                                          const Spacer(),
                                                          Text("00.0", style : textSmallRegularStyle),
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.symmetric(horizontal: wp(2, context)),
                                                      child: Row(
                                                        children: [
                                                          Text("CGST 6%",style: textSmallRegularStyle.copyWith(
                                                            fontFamily: fontSemiBold,
                                                          ),),
                                                          const Spacer(),
                                                          Text("00.0", style : textSmallRegularStyle),
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              );
                                            },
                                          );
                                        },child: const Icon(Icons.info_outlined,size: 14,)),
                                        const Spacer(),
                                        Text("₹ ${00.0
                                            .toStringAsFixed(1)}", style: textRegularStyle),
                                      ],
                                    ),
                                    const Divider(
                                      color: Colors.grey,
                                    ),
                                    SizedBox(height: hp(2, context),),
                                    Row(
                                      children: [
                                        Text("Total", style: textBodyStyle),
                                        const Spacer(),
                                        Text("₹ ${cart_provider.totalPrice
                                            .toStringAsFixed(1)}", style: textRegularStyle),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: hp(2, context),),
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
          ),
        ),
      bottomNavigationBar: Hero(
        tag: "order_success",
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: wp(1.5, context),vertical: hp(1.5, context)),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 50,
            child: CustomButton(
                onPressed: () async {
                  List.generate(cart_provider.cartList.length, (index) {
                    cartItemList.add(
                        {"cart_item_id": cart_provider.cartList[index].id});
                  });
                  var data = {
                    "table_no": qr_provider.table_number,
                    "cart_items": cartItemList
                  };
                  CustomResultModel? result =
                  await order_provider.placeOrder(data);
                  if (result!.status) {
                    cart_provider.clearCart();
                    Navigator.pushNamed(context, RoutesName.ORDER_SUCCESSFUL_SCREEN_ROUTE);
                    CustomFlushbar.showSuccess(
                        context, result.message);
                  } else {
                    CustomFlushbar.showError(
                        context, result.message);
                  }
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Place Order", style: textBodyStyle.copyWith(
                        color: Colors.white
                    ),),
                    const Spacer(),
                    const Icon(Icons.arrow_forward_ios_outlined),
                  ],
                )
            ),
          ),
        ),
      ),
    );
  }
}
