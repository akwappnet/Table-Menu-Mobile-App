import 'package:flutter/material.dart';
import 'package:table_menu_customer/utils/constants/constants_text.dart';

class CustomOutlinedButton extends StatelessWidget {
  const CustomOutlinedButton({super.key,required this.onPressed,required this.child, this.backgroundColor});

  final VoidCallback onPressed;
  final Widget child;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(backgroundColor ?? Colors.transparent),
        shape: MaterialStateProperty.all(RoundedRectangleBorder(side: const BorderSide(color: Colors.purple,width: 2,),borderRadius: BorderRadius.circular(BORDER_RADIUS))),
      ),
      child : child,
    );
  }
}
