import 'package:flutter/material.dart';
import 'package:table_menu_customer/utils/constants/constants_text.dart';
import 'package:table_menu_customer/utils/responsive.dart';

import '../../../utils/font/text_style.dart';

class FilterItemWidget extends StatelessWidget {
  const FilterItemWidget({super.key,required this.borderColor,required this.containerColor,required this.itemText,required this.textColor,required this.onTap});

  final Color containerColor;
  final Color textColor;
  final Color borderColor;
  final String itemText;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: containerColor,
          border: Border.all(color: borderColor, width: 1),
          borderRadius: const BorderRadius.all(Radius.circular(BORDER_RADIUS)),
        ),
        margin: EdgeInsets.symmetric(horizontal: wp(1.5, context),vertical: hp(1.5, context)),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: wp(1.5,context),vertical: hp(1.5, context)),
          child: Text(itemText,style: textRegularStyle.copyWith(color: textColor),),
        ),
      ),
    );
  }
}


