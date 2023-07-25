import 'package:flutter/material.dart';
import 'package:table_menu_customer/utils/font/text_style.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Help & Support",style: titleTextStyle,),
      ),
      body: const SafeArea(
        child: Center(
          child: SizedBox(),
        ),
      ),
    );
  }
}
