import 'package:flutter/material.dart';
import 'package:table_menu_customer/utils/constants/constants_text.dart';
import 'package:table_menu_customer/utils/font/text_style.dart';
import 'package:table_menu_customer/utils/responsive.dart';
import 'package:table_menu_customer/utils/widgets/custom_text.dart';

class PlusMinusButtons extends StatelessWidget {
  final VoidCallback deleteQuantity;
  final VoidCallback addQuantity;
  final String text;

  const PlusMinusButtons({
    Key? key,
    required this.addQuantity,
    required this.deleteQuantity,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(

      decoration: BoxDecoration(
        color: Colors.purple.shade400,
        borderRadius: BorderRadius.circular(BORDER_RADIUS),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: deleteQuantity,
            icon: const Icon(Icons.remove),
            color: Colors.white,
          ),
          SizedBox(
            width: wp(6.5, context),
            child: CustomText(
              text: text,
              alignment: TextAlign.center,
              style: textBodyStyle.copyWith(
                color: Colors.white
              )
            ),
          ),
          IconButton(
            onPressed: addQuantity,
            icon: const Icon(Icons.add),
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
