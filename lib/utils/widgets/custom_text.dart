import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double? size;
  final Color? color;
  final FontWeight? weight;
  final TextStyle? style;

  const CustomText({super.key,
    required this.text,
    this.size,
    this.color,
    this.style,
    this.weight});


  @override
  Widget build(BuildContext context) {
    return RichText(
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        text: text,
        style: style ?? TextStyle(fontSize: size ?? 16, color: color ?? Colors.black, fontWeight: weight ?? FontWeight.normal),
      ),
    );
  }
}
