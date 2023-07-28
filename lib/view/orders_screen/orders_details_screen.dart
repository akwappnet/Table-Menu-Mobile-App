import 'package:flutter/material.dart';
import 'package:table_menu_customer/utils/font/text_style.dart';
import 'package:table_menu_customer/utils/responsive.dart';

import '../../app_localizations.dart';
import '../../model/order_model.dart';
import '../../utils/constants/constants_text.dart';
import '../../utils/functions/time_format_function.dart';
import '../../utils/widgets/custom_button.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({super.key,required this.orderData});

  final OrderData orderData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).translate('order_details'),style: titleTextStyle,),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: wp(2, context),vertical: hp(2, context)),
          child: Card(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: wp(2, context), vertical: hp(1.5, context)),
              child: SizedBox(
                width: wp(100, context),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "# ${orderData.id}",
                          style: textBodyStyle.copyWith(color: Colors.purple),
                        ),
                        const Spacer(),
                        Text(orderData.orderStatus!,style: textSmallRegularStyle.copyWith(
                            color: Colors.green
                        ),)
                      ],
                    ),
                    Text(
                      formatDateTime(DateTime.parse(orderData.createdAt!)),
                      style: textSmallRegularStyle.copyWith(fontFamily: fontSemiBold),
                    ),
                    SizedBox(height: hp(1.5, context)),
                    Text(AppLocalizations.of(context).translate('ordered_by'),style: textSmallRegularStyle.copyWith(color: Colors.grey),),
                    SizedBox(height: hp(0.5, context),),
                    Text(orderData.customerName!,style: textSmallRegularStyle.copyWith(fontFamily: fontSemiBold)),
                    SizedBox(height: hp(1, context),),
                    Text(AppLocalizations.of(context).translate('payment_method'),style: textSmallRegularStyle.copyWith(color: Colors.grey),),
                    SizedBox(height: hp(0.5, context),),
                    Text("Card",style: textSmallRegularStyle.copyWith(fontFamily: fontSemiBold)),
                    SizedBox(height: hp(1.5, context),),
                    const Divider(color: Colors.grey,),
                    SizedBox(height: hp(1, context),),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: orderData.cartItems?.length,
                      itemBuilder: (context,index){
                        var cartItem = orderData.cartItems?[index];
                        return Row(
                          children: [
                            Text("${cartItem?.itemName}  x${cartItem?.quantity}",style: textSmallRegularStyle.copyWith(fontFamily: fontSemiBold)),
                            const Spacer(),
                            Text("${AppLocalizations.of(context).translate('₹')} ${cartItem?.total}",style: textSmallRegularStyle.copyWith(fontFamily: fontSemiBold)),
                          ],
                        );
                      },
                    ),
                    SizedBox(height: hp(1.5, context),),
                    const Divider(color: Colors.grey,),
                    Row(
                      children: [
                        Text(
                          AppLocalizations.of(context).translate('item_total'),
                          style: textRegularStyle.copyWith(
                              color: Colors.grey),
                        ),
                        const Spacer(),
                        Text(
                          "${ AppLocalizations.of(context).translate('₹')} ${orderData.totalPrice}",
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
                          AppLocalizations.of(context).translate('tax'),
                          style: textRegularStyle.copyWith(
                              color: Colors.grey),
                        ),
                        const Spacer(),
                        Text(
                          "${ AppLocalizations.of(context).translate('₹')} 00",
                          style: textBodyStyle.copyWith(
                              color: Colors.black),
                        ),
                      ],
                    ),
                    SizedBox(height: hp(1, context),),
                    Row(
                      children: [
                        Text(
                          AppLocalizations.of(context).translate('tip'),
                          style: textRegularStyle.copyWith(
                              color: Colors.grey),
                        ),
                        const Spacer(),
                        Text(
                          "${AppLocalizations.of(context).translate('₹')} 00",
                          style: textBodyStyle.copyWith(
                              color: Colors.black),
                        ),
                      ],
                    ),
                    SizedBox(height: hp(1, context),),
                    Row(
                      children: [
                        Text(
                          AppLocalizations.of(context).translate('paid'),
                          style: textRegularStyle.copyWith(fontFamily: fontSemiBold),
                        ),
                        const Spacer(),
                        Text(
                          "${AppLocalizations.of(context).translate('₹')} ${orderData.totalPrice}",
                          style: textBodyStyle.copyWith(
                              color: Colors.black),
                        ),
                      ],
                    ),
                    SizedBox(height: hp(1, context),),
                    const Divider(color: Colors.grey,),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar:  Padding(
        padding: EdgeInsets.symmetric(
            horizontal: wp(1.5, context), vertical: hp(1.5, context)),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: hp(7.5, context),
          child: CustomButton(
            onPressed: () {},
            child: Text(
              AppLocalizations.of(context).translate('re_order'),
              style: textBodyStyle.copyWith(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
