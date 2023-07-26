import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_menu_customer/utils/font/text_style.dart';
import 'package:table_menu_customer/utils/responsive.dart';
import 'package:table_menu_customer/view_model/auth_provider.dart';

class ChangeLanguageScreen extends StatelessWidget {
  const ChangeLanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context,auth_provider,__){
        return Scaffold(
          appBar: AppBar(
            title: Text("Chnage Language", style: titleTextStyle,),
          ),
          body: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: wp(2.5, context), vertical: hp(2, context)),
                  child: const Column(
                    children: [],
                  ),
                ),
              )
          ),
        );
      },
    );
  }
}
