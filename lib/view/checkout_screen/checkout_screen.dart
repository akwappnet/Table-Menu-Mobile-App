import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_menu_customer/utils/assets/assets_utils.dart';
import 'package:table_menu_customer/utils/routes/routes_name.dart';
import 'package:table_menu_customer/utils/widgets/custom_textformfield.dart';
import 'package:table_menu_customer/view/checkout_screen/widget/add_card_bottom_sheet_widget.dart';
import 'package:table_menu_customer/view/payment_screen/widget/payment_card_widget.dart';
import 'package:table_menu_customer/view_model/order_provider.dart';

import '../../utils/constants/constants_text.dart';
import '../../utils/font/text_style.dart';
import '../../utils/responsive.dart';
import '../../utils/validation/validation.dart';
import '../../utils/widgets/custom_button.dart';
import '../../utils/widgets/custom_text.dart';

class CheckoutScreen extends StatelessWidget {
  CheckoutScreen({super.key});

  final TextEditingController discountCodeController = TextEditingController();
  final TextEditingController tipController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<OrderProvider>(
      builder: (context, order_provider, __) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Checkout',
              style: smallTitleTextStyle,
            ),
            backgroundColor: Colors.white,
            scrolledUnderElevation: 0.0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: wp(2, context), vertical: hp(2, context)),
              child: Hero(
                tag: "checkout",
                child: ListView(
                  children: [
                    SizedBox(
                      width: wp(100, context),
                      child: Card(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: wp(2, context),
                              vertical: hp(1, context)),
                          child: order_provider.card ? const PaymentCardWidget() : Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                AssetsUtils.ASSETS_WALLET_IMAGE,
                                width: wp(30, context),
                                height: hp(20, context),
                              ),
                              SizedBox(
                                height: hp(1.5, context),
                              ),
                              Text(
                                "You don't have any card",
                                style: smallTitleTextStyle,
                              ),
                              SizedBox(
                                height: hp(2, context),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: wp(4, context)),
                                child: CustomText(
                                  text:
                                      "Please add a credit or a debit card in order to ",
                                  style: textSmallRegularStyle.copyWith(
                                      color: Colors.grey),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: wp(4, context)),
                                child: CustomText(
                                  text: "pay your order.",
                                  style: textSmallRegularStyle.copyWith(
                                      color: Colors.grey),
                                ),
                              ),
                              SizedBox(
                                height: hp(2, context),
                              ),
                              GestureDetector(
                                onTap: () {
                                  addNewCardBottomSheet(context,(){
                                    order_provider.visibleCard();
                                    Navigator.pop(context);
                                  });
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.add,
                                      color: Colors.purple.shade400,
                                    ),
                                    Text(
                                      "Add a new card",
                                      style: textSmallRegularStyle.copyWith(
                                          color: Colors.purple.shade400,
                                          fontFamily: fontSemiBold),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: hp(2, context),
                    ),
                    SizedBox(
                      width: wp(100, context),
                      child: Card(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: wp(2, context),
                              vertical: hp(1, context)),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Item total ",
                                    style: textRegularStyle.copyWith(
                                        color: Colors.grey),
                                  ),
                                  const Spacer(),
                                  Text(
                                    "₹ 1000",
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
                                    "₹ 50",
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
                              CustomTextFormField().getCustomEditTextArea(
                                  labelValue: "discount code",
                                  hintValue: "Apply discount code",
                                  controller: discountCodeController,
                                  prefixicon: const Icon(
                                    Icons.percent_outlined,
                                    color: Colors.black,
                                  ),
                                  obscuretext: false,
                                  onchanged: (value) {},
                                  textInputAction: TextInputAction.done,
                                  validator: validateDiscountCode),
                              SizedBox(
                                height: hp(1, context),
                              ),
                              CustomTextFormField().getCustomEditTextArea(
                                  labelValue: "Tips",
                                  hintValue: "Add tips",
                                  controller: tipController,
                                  keyboardType: TextInputType.number,
                                  prefixicon: const Icon(
                                      Icons.currency_rupee_outlined,
                                      color: Colors.black),
                                  obscuretext: false,
                                  onchanged: (value) {},
                                  textInputAction: TextInputAction.done,
                                  validator: validateNotNull),
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
                                    "₹ 1050",
                                    style: textBodyStyle.copyWith(
                                        color: Colors.purple.shade300),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          bottomNavigationBar: Hero(
            tag: "payment",
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: wp(1.5, context), vertical: hp(1.5, context)),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: hp(7.5, context),
                child: CustomButton(
                    onPressed: () async {
                      Navigator.pushNamed(
                          context, RoutesName.PAYMENT_SUCCESSFUL_SCREEN_ROUTE);
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Pay",
                          style: textBodyStyle.copyWith(color: Colors.white),
                        ),
                        const Spacer(),
                        Text(
                          "₹ 1050",
                          style: textBodyStyle.copyWith(color: Colors.white),
                        ),
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
