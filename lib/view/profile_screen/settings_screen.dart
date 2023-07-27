import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';
import 'package:table_menu_customer/utils/font/text_style.dart';
import 'package:table_menu_customer/view_model/auth_provider.dart';

import '../../utils/responsive.dart';


class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      final auth_provider = Provider.of<AuthProvider>(context, listen: false);
      auth_provider.getUserInfo(context);
      auth_provider.boolPushNotification = auth_provider.userData!.pushNotifications!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
    builder: (context,auth_provider,__){
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text("Settings",style: smallTitleTextStyle,),
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: wp(2, context), vertical: hp(2, context)),
            child: SizedBox(
              child: Column(
                children: [
                  const Divider(),
                  SizedBox(height: hp(1, context),),
                  Row(
                    children: [
                      Text("Push Notification",style: textBodyStyle,),
                      const Spacer(),
                      FlutterSwitch(
                        activeColor: Theme.of(context).primaryColor,
                        width: 50.0,
                        height: 25.0,
                        valueFontSize: 0.0,
                        value: auth_provider.boolPushNotification,
                        borderRadius: 30.0,
                        padding: 3.0,
                        showOnOff: true,
                        onToggle: (value){
                          auth_provider.togglePushNotification(context);
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: hp(1, context),),
                  const Divider(),
                  SizedBox(height: hp(1, context),),
                  GestureDetector(
                    onTap: () {
                      auth_provider.deleteUserInfo(context);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Delete Account?",style: textBodyStyle.copyWith(color: Colors.red),),
                      ],
                    ),
                  ),
                  SizedBox(height: hp(1, context),),
                  const Divider(),
                  SizedBox(height: hp(1, context),),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.symmetric(horizontal: wp(2, context),vertical: hp(1.5, context)),
          child: Text("Created with ❤️ by Wappnet Systems Pvt. Ltd.",style: textSmallRegularStyle,textAlign:TextAlign.center ),
        ),
      );
    },
    );
  }
}
