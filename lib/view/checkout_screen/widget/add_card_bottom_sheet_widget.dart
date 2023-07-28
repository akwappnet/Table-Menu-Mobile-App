import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:table_menu_customer/utils/validation/validation.dart';
import 'package:table_menu_customer/utils/widgets/custom_button.dart';
import 'package:table_menu_customer/utils/widgets/custom_textformfield.dart';
import 'package:table_menu_customer/view_model/order_provider.dart';

import '../../../utils/constants/constants_text.dart';
import '../../../utils/font/text_style.dart';
import '../../../utils/responsive.dart';


addNewCardBottomSheet(context,VoidCallback onAddNewCard) {
  showModalBottomSheet(
    useRootNavigator: true,
    enableDrag: true,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    isDismissible: true,
    context: context,
    builder: (BuildContext context) {
      return Consumer<OrderProvider>(
        builder: (context, order_provider, __) {
          return Wrap(
            children: [
              Container(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(BORDER_RADIUS),
                    topRight: Radius.circular(BORDER_RADIUS),
                  ),
                ),
                child: Form(
                  key: order_provider.formKey_cards,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: wp(2, context),vertical: hp(2, context)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Add new card",
                              style: smallTitleTextStyle,
                            ),
                            IconButton(
                              splashRadius: 20,
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              icon: const Icon(Icons.close, color: Colors.black,),
                            )
                          ],
                        ),
                        SizedBox(
                          height: hp(2, context),
                        ),
                        CustomTextFormField().getCustomEditTextArea(
                            labelValue: "Card holder name",
                            hintValue: "Enter card holder name",
                            controller: order_provider.cardHolderNameController,
                            obscuretext: false,
                            onchanged: (value) {},
                            textInputAction: TextInputAction.next,
                            validator: (value) => validateName(context,value)),
                        SizedBox(
                          height: hp(2,context),
                        ),
                        CustomTextFormField().getCustomEditTextArea(
                            labelValue: "Card number",
                            hintValue: "Enter card number",
                            controller: order_provider.cardNumberController,
                            obscuretext: false,
                            maxLength: 16,
                            onchanged: (value) {},
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.number,
                            validator: (value) => cardValidator(context,value)),
                        SizedBox(
                          height: hp(1,context),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              flex: 1,
                              child: CustomTextFormField().getCustomEditTextArea(
                                  labelValue: "Expiry date",
                                  hintValue: "MM/YYYY",
                                  controller: order_provider.expiryDateController,
                                  obscuretext: false,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'[0-9/]')),
                                    _MonthYearInputFormatter(),
                                  ],
                                  onchanged: (value) {},
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.number,
                                  validator: (value) => expiryDateValidation(context,value)),
                            ),
                            SizedBox(width: wp(5,context)),
                            Flexible(
                              flex: 1,
                              child: CustomTextFormField().getCustomEditTextArea(
                                  labelValue: "CVV",
                                  hintValue: "Enter CVV",
                                  controller: order_provider.cvvController,
                                  obscuretext: false,
                                  onchanged: (value) {},
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.number,
                                  validator: (value) => cvvValidation(context,value)),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: hp(1,context),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: wp(1.5, context),vertical: hp(1.5, context)),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: hp(7.5, context),
                            child: CustomButton(
                                onPressed: onAddNewCard,
                                child: Text("Add new card", style: textBodyStyle.copyWith(
                                    color: Colors.white
                                ),),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: hp(2,context),
              ),
            ],
          );
        },
      );
    },
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(BORDER_RADIUS),
        topRight: Radius.circular(BORDER_RADIUS),
      ),
    ),
  );
}


class _MonthYearInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final text = newValue.text;

    if (text.length > 7) {
      return oldValue;
    }

    if (text.length == 3 && text[2] != '/') {
      final formattedValue = text.replaceRange(2, 2, '/');
      return newValue.copyWith(
        text: formattedValue,
        selection: TextSelection.collapsed(
          offset: formattedValue.length,
        ),
      );
    }
    return newValue;
  }
}