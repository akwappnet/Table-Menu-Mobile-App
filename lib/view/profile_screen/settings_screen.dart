import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';
import 'package:table_menu_customer/utils/font/text_style.dart';
import 'package:table_menu_customer/view_model/auth_provider.dart';

import '../../app_localizations.dart';
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
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      authProvider.getUserInfo(context);
      authProvider.boolPushNotification =
          authProvider.userData!.pushNotifications!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, __) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text(
              AppLocalizations.of(context).translate('settings'),
              style: smallTitleTextStyle,
            ),
          ),
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: wp(2, context), vertical: hp(2, context)),
              child: SizedBox(
                child: Column(
                  children: [
                    const Divider(),
                    SizedBox(
                      height: hp(1, context),
                    ),
                    Row(
                      children: [
                        Text(
                          AppLocalizations.of(context)
                              .translate('push_notification'),
                          style: textBodyStyle,
                        ),
                        const Spacer(),
                        FlutterSwitch(
                          activeColor: Theme.of(context).primaryColor,
                          width: 50.0,
                          height: 25.0,
                          valueFontSize: 0.0,
                          value: authProvider.boolPushNotification,
                          borderRadius: 30.0,
                          padding: 3.0,
                          showOnOff: true,
                          onToggle: (value) {
                            authProvider.togglePushNotification(context);
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: hp(1, context),
                    ),
                    const Divider(),
                    SizedBox(
                      height: hp(1, context),
                    ),
                    GestureDetector(
                      onTap: () {
                        authProvider.deleteUserInfo(context);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            AppLocalizations.of(context)
                                .translate('delete_account'),
                            style: textBodyStyle.copyWith(color: Colors.red),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: hp(1, context),
                    ),
                    const Divider(),
                    SizedBox(
                      height: hp(1, context),
                    ),
                  ],
                ),
              ),
            ),
          ),
          bottomNavigationBar: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: wp(2, context), vertical: hp(1.5, context)),
            child: Text(
                AppLocalizations.of(context).translate('footer_message'),
                style: textSmallRegularStyle,
                textAlign: TextAlign.center),
          ),
        );
      },
    );
  }
}
