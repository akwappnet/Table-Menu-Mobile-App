import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_menu_customer/view_model/order_provider.dart';

import '../../../app_localizations.dart';
import '../../../utils/constants/constants_text.dart';
import '../../../utils/font/text_style.dart';
import '../../../utils/responsive.dart';
import '../../../utils/validation/validation.dart';
import '../../../utils/widgets/custom_text.dart';
import '../../../utils/widgets/custom_textformfield.dart';

void showAddInstructionBottomsheet(BuildContext context) {
  showModalBottomSheet(
    useRootNavigator: true,
    enableDrag: true,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    isDismissible: true,
    context: context,
    builder: (BuildContext context) {
      return Consumer<OrderProvider>(
        builder: (context, orderProvider, __) {
          return Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(BORDER_RADIUS),
                topRight: Radius.circular(BORDER_RADIUS),
              ),
            ),
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: wp(2, context)),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: wp(1, context),
                          ),
                          Text(
                            AppLocalizations.of(context)
                                .translate('special_cooking_instruction'),
                            style: textBodyStyle,
                          ),
                          const Spacer(),
                          IconButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            icon: const Icon(
                              Icons.close,
                              color: Colors.black,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                const Divider(
                  color: Colors.grey,
                ),
                SizedBox(
                  height: hp(1, context),
                ),
                orderProvider.cookingInstruction.isNotEmpty
                    ? Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: wp(2, context)),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: wp(0.5, context),
                              vertical: hp(0.3, context)),
                          decoration: BoxDecoration(
                              color: Colors.transparent,
                              border: Border.all(color: Colors.black, width: 1),
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(BORDER_RADIUS))),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Flexible(
                                child: Text(orderProvider.cookingInstruction,
                                    style: textRegularStyle,
                                    maxLines: 3,
                                    overflow: TextOverflow.clip),
                              ),
                              SizedBox(
                                width: wp(2, context),
                              ),
                              IconButton(
                                icon: const Icon(Icons.close),
                                onPressed: () {
                                  orderProvider.updateCookingInstruction("");
                                },
                              ),
                            ],
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
                SizedBox(
                  height: hp(1, context),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: wp(2, context)),
                  child: SizedBox(
                    width: wp(100, context),
                    height: hp(13, context),
                    child: CustomTextFormField().getCustomEditTextArea(
                        labelValue: AppLocalizations.of(context)
                            .translate('label_cooking_instruction'),
                        hintValue: AppLocalizations.of(context)
                            .translate('hint_cooking_instruction'),
                        controller: orderProvider.instructionController,
                        prefixicon: const Icon(Icons.edit_note_outlined),
                        obscuretext: false,
                        onchanged: (value) {},
                        textInputAction: TextInputAction.done,
                        maxLength: 100,
                        textStyle: textRegularStyle,
                        validator: (value) => validateField(context, value)),
                  ),
                ),
                SizedBox(height: hp(0.5, context)),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: wp(2, context)),
                  child: CustomText(
                      alignment: TextAlign.start,
                      text: AppLocalizations.of(context)
                          .translate('cooking_instruction_text1'),
                      color: Colors.red,
                      size: 12),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: wp(2, context)),
                  child: CustomText(
                    alignment: TextAlign.start,
                    text: AppLocalizations.of(context)
                        .translate('cooking_instruction_text2'),
                    color: Colors.red,
                    size: 12,
                  ),
                ),
                SizedBox(
                  height: hp(2, context),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: wp(2, context)),
                  child: SizedBox(
                    height: hp(7.5, context),
                    width: wp(100, context),
                    child: ElevatedButton(
                      onPressed: () {
                        orderProvider.updateCookingInstruction(
                            orderProvider.instructionController.text);
                        orderProvider.instructionController.clear();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple.shade400,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(BORDER_RADIUS),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        child: Text(
                          AppLocalizations.of(context).translate('add_text'),
                          style: textRegularStyle.copyWith(
                              fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: hp(2, context),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}
