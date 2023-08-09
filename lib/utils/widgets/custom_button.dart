import 'package:flutter/material.dart';
import 'package:table_menu_customer/utils/constants/constants_text.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;
  final Color? backgroundColor;

  const CustomButton(
      {Key? key,
      required this.child,
      required this.onPressed,
      this.backgroundColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
        backgroundColor:
            MaterialStateProperty.all<Color>(backgroundColor ?? Colors.purple),
        overlayColor: MaterialStateProperty.resolveWith(
          (states) {
            return states.contains(MaterialState.pressed)
                ? Colors.purple.shade300
                : null;
          },
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(BORDER_RADIUS),
        )),
      ),
      child: child,
    );
  }
}
