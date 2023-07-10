import 'package:flutter/material.dart';

import '../../../utils/constants/constants_text.dart';
import '../../../utils/font/text_style.dart';
import '../../../utils/responsive.dart';
import '../../../utils/validation/validation.dart';
import '../../../utils/widgets/custom_text.dart';
import '../../../utils/widgets/custom_textformfield.dart';

void showAddInstructionModal(BuildContext context) {
  TextEditingController instructionController = TextEditingController();
  showModalBottomSheet(
    useRootNavigator: true,
    enableDrag: true,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    isDismissible: true,
    context: context,
    builder: (BuildContext context) {
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
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                SizedBox(width: wp(1, context),),
                Text("Special cooking instructions",style: smallTitleTextStyle,),
                const Spacer(),
                IconButton(onPressed: () {
                  Navigator.of(context).pop();
                }, icon: const Icon(Icons.close,color: Colors.black,),)
              ],
            ),
            const Divider(
              color: Colors.grey,
            ),
            SizedBox(
              height: hp(1, context),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: wp(2, context)),
              child: CustomTextFormField().getCustomEditTextArea(
                  labelValue: "Start Typing",
                  hintValue: "Cooking Instructions",
                  controller: instructionController,
                  prefixicon: const Icon(Icons.edit_note_outlined),
                  obscuretext: false,
                  onchanged: (value){},
                  textInputAction: TextInputAction.done,
                  maxLength: 100,
                  textStyle: textRegularStyle,
                  validator: validateField),
            ),
            SizedBox(height: hp(0.5, context)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: wp(2, context)),
              child: const CustomText(text: "The restorant will try their best to follow your instructions.",color: Colors.red,size: 12),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: wp(2, context)),
              child: const CustomText(text: "However, no cancellation or refund will be possible if your request is not met.",color: Colors.red,size: 12,),
            ),
            SizedBox(height: hp(2, context),),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: wp(2, context)),
              child: ElevatedButton(
                onPressed: () {
                  if (instructionController.text.isNotEmpty) {
                    Navigator.pop(context);
                  }
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
                    'Add',
                    style: textRegularStyle.copyWith(
                        fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ),
            SizedBox(height: hp(2, context),),
          ],
        ),
      );
    },
  );
}