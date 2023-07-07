import 'package:flutter/material.dart';
import 'package:table_menu_customer/utils/constants/constants_text.dart';
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
      padding: const EdgeInsets.all(6.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(BORDER_RADIUS),

      ),
      child: Row(
        children: [
          IconButton(
            onPressed: deleteQuantity,
            icon: const Icon(Icons.remove),
            color: Colors.grey,
          ),
          SizedBox(
            width: wp(2, context),
            child: CustomText(
              text: text,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ),
          IconButton(
            onPressed: addQuantity,
            icon: const Icon(Icons.add),
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}
