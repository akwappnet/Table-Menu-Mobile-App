import 'package:flutter/material.dart';
import 'package:table_menu_customer/utils/font/text_style.dart';

import '../../utils/responsive.dart';


class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings",style: smallTitleTextStyle,),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: wp(2, context), vertical: hp(2, context)),
          child: Container(),
        ),
      ),
    );
  }
}
