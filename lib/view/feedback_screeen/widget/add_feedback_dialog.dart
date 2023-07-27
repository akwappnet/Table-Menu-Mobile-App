import 'package:flutter/material.dart';
import 'package:table_menu_customer/utils/assets/assets_utils.dart';
import 'package:table_menu_customer/utils/constants/constants_text.dart';

import '../../../utils/font/text_style.dart';
import '../../../utils/responsive.dart';
import '../../../utils/widgets/custom_button.dart';
import '../../../utils/widgets/custom_text.dart';

class CustomDialogBox extends StatelessWidget {
  final VoidCallback onClosePressed;
  final VoidCallback addFeedback;

  const CustomDialogBox({super.key, required this.onClosePressed,required this.addFeedback});


  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(BORDER_RADIUS),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: hp(2, context),horizontal: wp(2, context)),
        child: SizedBox(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: onClosePressed,
                  ),
                ],
              ),
              Image.asset(AssetsUtils.ASSETS_FEEDBACK_ICON_IMAGE,width: wp(30, context),height: hp(20, context),),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Tell us about your experience",
                    style: textBodyStyle,
                  ),
                ],
              ),
              const SizedBox(height: 1.5,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                    text:"We love to hear from you how was the \nwhole experience in our restaurant.",
                    style: textSmallRegularStyle.copyWith(color: Colors.grey),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: wp(1.5, context),vertical: hp(1.5, context)),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: hp(7.5, context),
                  child: CustomButton(
                    onPressed: addFeedback,
                    child:  Text("Add Feedback", style: textBodyStyle.copyWith(
                        color: Colors.white
                    ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

