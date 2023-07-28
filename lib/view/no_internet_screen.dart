import 'package:flutter/material.dart';
import 'package:table_menu_customer/utils/assets/assets_utils.dart';
import 'package:table_menu_customer/utils/font/text_style.dart';
import 'package:table_menu_customer/utils/responsive.dart';
import 'package:table_menu_customer/utils/widgets/custom_outlined_button.dart';

import '../app_localizations.dart';
import '../utils/constants/constants_text.dart';

class NoInternetScreen extends StatelessWidget {
  const NoInternetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(AssetsUtils.ASSETS_NO_INTERNET_IMAGE,
            height: hp(30, context),
              width: wp(50, context),
            ),
            Text(
              AppLocalizations.of(context).translate('whoops'),
              style: smallTitleTextStyle.copyWith(
                fontFamily: fontSemiBold
              ),
            ),
            SizedBox(height: hp(1, context)),
            Text(AppLocalizations.of(context).translate('check_internet_message')),
            SizedBox(height: hp(1, context)),
            CustomOutlinedButton(onPressed: () {}, child: Text(AppLocalizations.of(context).translate('try_again'),style: textSmallMediumStyle,)),
          ],
        ),
      ),
    );
  }
}
