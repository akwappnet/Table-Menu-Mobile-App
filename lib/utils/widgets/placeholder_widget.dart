import 'package:flutter/material.dart';

import '../assets/assets_utils.dart';
import '../font/text_style.dart';
import '../responsive.dart';


class PlaceholderWidget extends StatelessWidget {
  const PlaceholderWidget({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            AssetsUtils.ASSETS_EMPTY_MENU_PLACEHOLDER,
            height: hp(45, context),
            width: wp(55, context),
          ),
          Text(
            title,
            style: smallTitleTextStyle,
          ),
        ],
      ),
    );
  }
}
