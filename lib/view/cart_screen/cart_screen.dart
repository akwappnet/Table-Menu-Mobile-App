import 'package:flutter/material.dart' hide Badge;
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:table_menu_customer/utils/responsive.dart';
import 'package:table_menu_customer/utils/routes/routes_name.dart';
import 'package:table_menu_customer/utils/widgets/placeholder_widget.dart';
import 'package:table_menu_customer/view/cart_screen/widget/cart_item_card_widget.dart';
import 'package:table_menu_customer/view/cart_screen/widget/cooking_instruction_bottom_sheet_widget.dart';
import 'package:table_menu_customer/view_model/qr_provider.dart';

import '../../app_localizations.dart';
import '../../utils/assets/assets_utils.dart';
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
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CartProvider>().getCartItems(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<OrderProvider>(context, listen: false);
    final qrProvider = Provider.of<QRProvider>(context, listen: false);
    return Consumer<CartProvider>(
      builder: (context, cartProvider, __) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            scrolledUnderElevation: 0.0,
            automaticallyImplyLeading: false,
            title: Text(
              AppLocalizations.of(context).translate('title_cart'),
              style: titleTextStyle,
            ),
          ),
          body: SafeArea(
            child: cartProvider.loading
                ? Center(
                    child: Lottie.asset(
                      AssetsUtils.ASSETS_LOADING_PURPLE_ANIMATION,
                      width: 100,
                      height: 100,
                      fit: BoxFit.fill,
                    ),
                  )
                : cartProvider.cartList.isEmpty
                    ? Container(
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            PlaceholderWidget(
                                title: AppLocalizations.of(context)
                                    .translate('placeholder_cart_text')),
                          ],
                        ),
                      )
                    : SingleChildScrollView(
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: wp(2, context)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    AppLocalizations.of(context)
                                        .translate('my_order'),
                                    style: smallTitleTextStyle,
                                  ),
                                  const Spacer(),
                                  Icon(
                                    Icons.add,
                                    color: Colors.purple.shade400,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.popAndPushNamed(context,
                                          RoutesName.HOME_SCREEN_ROUTE);
                                    },
                                    child: Text(
                                      AppLocalizations.of(context)
                                          .translate('add_items'),
                                      style: textSmallRegularStyle.copyWith(
                                          color: Colors.purple.shade300),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            (cartProvider.cartList.isEmpty)
                                ? Center(
                                    child: Text(
                                    AppLocalizations.of(context)
                                        .translate('placeholder_cart_text'),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.0),
                                  ))
                                : ListView.builder(
                                    shrinkWrap: true,
                                    primary: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: cartProvider.cartList.length,
                                    itemBuilder: (context, index) {
                                      return CartItemCard(
                                          itemName: cartProvider
                                              .cartList[index].menuItemName!,
                                          imageUrl: cartProvider
                                              .cartList[index].menuItemImage!,
                                          price: cartProvider
                                              .cartList[index].menuItemPrice!,
                                          quantity: cartProvider
                                              .cartList[index].quantity
                                              .toString(),
                                          addQuantitycallback: () {
                                            cartProvider
                                                .incrementItemQuantityUpdate(
                                                    cartProvider
                                                        .cartList[index]);
                                            var data = {
                                              "menu_item": cartProvider
                                                  .cartList[index].menuItem,
                                              "quantity": cartProvider
                                                  .cartList[index].quantity
                                            };
                                            cartProvider.updateItemQuantity(
                                                data,
                                                cartProvider
                                                    .cartList[index].id!,
                                                context);
                                          },
                                          removeQuantitycallback: () {
                                            cartProvider
                                                .decrementItemQuantityUpdate(
                                                    cartProvider
                                                        .cartList[index]);
                                            var data = {
                                              "menu_item": cartProvider
                                                  .cartList[index].menuItem,
                                              "quantity": cartProvider
                                                  .cartList[index].quantity
                                            };
                                            cartProvider.updateItemQuantity(
                                                data,
                                                cartProvider
                                                    .cartList[index].id!,
                                                context);
                                          },
                                          cancelcallback: () {
                                            cartProvider.deleteCartItem(
                                                cartProvider
                                                    .cartList[index].id!,
                                                context);
                                          });
                                    }),
                            SizedBox(
                              height: hp(2, context),
                            ),
                            GestureDetector(
                              onTap: () =>
                                  showAddInstructionBottomsheet(context),
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.edit_note_outlined,
                                        color: Colors.black,
                                      ),
                                      SizedBox(
                                        width: wp(0.8, context),
                                      ),
                                      Text(
                                        AppLocalizations.of(context).translate(
                                            'add_cooking_instruction'),
                                        style: textSmallRegularStyle,
                                      ),
                                      const Spacer(),
                                      const Icon(
                                        Icons.arrow_forward_ios_outlined,
                                        color: Colors.black,
                                        size: 18,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: hp(2, context),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: wp(2, context)),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        AppLocalizations.of(context)
                                            .translate('payment'),
                                        style: smallTitleTextStyle,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: hp(2, context),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                          AppLocalizations.of(context)
                                              .translate('sub_total'),
                                          style: textBodyStyle),
                                      const Spacer(),
                                      Text(
                                          "${AppLocalizations.of(context).translate('₹')} ${cartProvider.totalPrice.toStringAsFixed(1)}",
                                          style: textRegularStyle),
                                    ],
                                  ),
                                  SizedBox(
                                    height: hp(2, context),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                          AppLocalizations.of(context)
                                              .translate(
                                                  'gst_restorant_charges'),
                                          style: textBodyStyle),
                                      SizedBox(
                                        width: wp(0.3, context),
                                      ),
                                      GestureDetector(
                                          onTap: () {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  contentPadding:
                                                      EdgeInsets.symmetric(
                                                          horizontal:
                                                              wp(2, context),
                                                          vertical:
                                                              hp(2, context)),
                                                  content: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: [
                                                          SizedBox(
                                                            width:
                                                                wp(2, context),
                                                          ),
                                                          Text(
                                                            AppLocalizations.of(
                                                                    context)
                                                                .translate(
                                                                    'gst_restorant_charges'),
                                                            style:
                                                                textBodyStyle,
                                                          ),
                                                          SizedBox(
                                                            width:
                                                                wp(2, context),
                                                          ),
                                                          GestureDetector(
                                                            onTap: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                            child: const Icon(
                                                              Icons.close,
                                                              size: 20,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: hp(2, context),
                                                      ),
                                                      Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: wp(
                                                                    2,
                                                                    context)),
                                                        child: Row(
                                                          children: [
                                                            Text(
                                                              AppLocalizations.of(
                                                                      context)
                                                                  .translate(
                                                                      'service_charges'),
                                                              style:
                                                                  textSmallRegularStyle
                                                                      .copyWith(
                                                                fontFamily:
                                                                    fontSemiBold,
                                                              ),
                                                            ),
                                                            const Spacer(),
                                                            Text("00.0",
                                                                style:
                                                                    textSmallRegularStyle),
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: wp(
                                                                    2,
                                                                    context)),
                                                        child: Row(
                                                          children: [
                                                            Text(
                                                              AppLocalizations.of(
                                                                      context)
                                                                  .translate(
                                                                      'sgst'),
                                                              style:
                                                                  textSmallRegularStyle
                                                                      .copyWith(
                                                                fontFamily:
                                                                    fontSemiBold,
                                                              ),
                                                            ),
                                                            const Spacer(),
                                                            Text("00.0",
                                                                style:
                                                                    textSmallRegularStyle),
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: wp(
                                                                    2,
                                                                    context)),
                                                        child: Row(
                                                          children: [
                                                            Text(
                                                              AppLocalizations.of(
                                                                      context)
                                                                  .translate(
                                                                      'cgst'),
                                                              style:
                                                                  textSmallRegularStyle
                                                                      .copyWith(
                                                                fontFamily:
                                                                    fontSemiBold,
                                                              ),
                                                            ),
                                                            const Spacer(),
                                                            Text("00.0",
                                                                style:
                                                                    textSmallRegularStyle),
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                          child: const Icon(
                                            Icons.info_outlined,
                                            size: 14,
                                          )),
                                      const Spacer(),
                                      Text(
                                          "${AppLocalizations.of(context).translate('₹')} ${00.0.toStringAsFixed(1)}",
                                          style: textRegularStyle),
                                    ],
                                  ),
                                  const Divider(
                                    color: Colors.grey,
                                  ),
                                  SizedBox(
                                    height: hp(2, context),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                          AppLocalizations.of(context)
                                              .translate('total'),
                                          style: textBodyStyle),
                                      const Spacer(),
                                      Text(
                                          "${AppLocalizations.of(context).translate('₹')} ${cartProvider.totalPrice.toStringAsFixed(1)}",
                                          style: textRegularStyle),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: hp(2, context),
                            ),
                          ],
                        ),
                      ),
          ),
          bottomNavigationBar: cartProvider.cartList.isEmpty
              ? const SizedBox.shrink()
              : Hero(
                  tag: "order_success",
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: wp(1.5, context),
                        vertical: hp(1.5, context)),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      child: CustomButton(
                          onPressed: () async {
                            List.generate(cartProvider.cartList.length,
                                (index) {
                              cartItemList.add({
                                "cart_item_id": cartProvider.cartList[index].id
                              });
                            });
                            var data = {
                              "table_no": qrProvider.table_number,
                              "cart_items": cartItemList,
                              "order_instructions":
                                  orderProvider.cookingInstruction
                            };
                            orderProvider.placeOrder(data, context);
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppLocalizations.of(context)
                                    .translate('place_order'),
                                style:
                                    textBodyStyle.copyWith(color: Colors.white),
                              ),
                              const Spacer(),
                              const Icon(Icons.arrow_forward_ios_outlined),
                            ],
                          )),
                    ),
                  ),
                ),
        );
      },
    );
  }
}
