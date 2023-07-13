import 'package:flutter/material.dart';

import '../../../utils/constants/constants_text.dart';
import '../../../utils/font/text_style.dart';
import '../../../utils/responsive.dart';

class FilterRatingItemWidget extends StatelessWidget {
  const FilterRatingItemWidget({super.key,required this.borderColor,required this.containerColor,required this.itemText,required this.textColor,required this.onTap});

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
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.star,color: Colors.amber,),
              SizedBox(width: wp(0.5, context),),
              Text(itemText,style: textRegularStyle.copyWith(color: textColor),),
              SizedBox(width: wp(0.7, context),),
            ],
          ),
        ),
      ),
    );
  }
}
