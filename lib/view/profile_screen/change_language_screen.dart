import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_menu_customer/AppLanguage.dart';
import 'package:table_menu_customer/utils/font/text_style.dart';
import 'package:table_menu_customer/utils/responsive.dart';
import 'package:table_menu_customer/view_model/auth_provider.dart';

import '../../app_localizations.dart';

class ChangeLanguageScreen extends StatelessWidget {
  const ChangeLanguageScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final app_lanugage = Provider.of<AppLanguage>(context);
    return Consumer<AuthProvider>(
      builder: (context,auth_provider,__){
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text(AppLocalizations.of(context).translate('change_language'), style: titleTextStyle,),
          ),
          body: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: wp(2.5, context), vertical: hp(2, context)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(AppLocalizations.of(context).translate('select_language'), style:textRegularStyle),
                      const Divider(),
                      SizedBox(height: hp(1, context),),
                      GestureDetector(
                        onTap: () {
                          app_lanugage.changeLanguage(const Locale("en"));
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text("English (US)",style: textBodyStyle,),
                            const Spacer(),
                            app_lanugage.appLocal == const Locale("en") ? const Icon(Icons.check_rounded,color: Colors.black,) : const SizedBox.shrink(),
                          ],
                        ),
                      ),
                      SizedBox(height: hp(1, context),),
                      const Divider(),
                      SizedBox(height: hp(1, context),),
                      GestureDetector(
                        onTap: () {
                          app_lanugage.changeLanguage(const Locale("ar"));
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text("Arabic",style: textBodyStyle,),
                            const Spacer(),
                            app_lanugage.appLocal == const Locale("ar") ? const Icon(Icons.check_rounded,color: Colors.black,) : const SizedBox.shrink(),
                          ],
                        ),
                      ),
                      SizedBox(height: hp(1, context),),
                      const Divider(),
                      SizedBox(height: hp(1, context),),
                    ],
                  ),
                ),
              )
          ),
        );
      },
    );
  }
}
