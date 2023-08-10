import 'package:flutter/material.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';
import 'package:flutter_svg/svg.dart';
import 'package:table_menu_customer/utils/assets/assets_utils.dart';
import 'package:table_menu_customer/utils/constants/constants_text.dart';
import 'package:table_menu_customer/utils/font/text_style.dart';
import 'package:table_menu_customer/utils/responsive.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: OnBoardingSlider(
          headerBackgroundColor: Colors.white,
          finishButtonText: 'Get Started',
          finishButtonStyle: const FinishButtonStyle(
            backgroundColor: Colors.purple,
          ),
          skipTextButton: Text(
            'Skip',
            style: textRegularStyle,
          ),
          trailing: const Text(''),
          background: [
            SvgPicture.asset(
              AssetsUtils.ASSETS_ONBOARDING_BROWSE,
              height: hp(50, context),
              width: wp(50, context),
            ),
            SvgPicture.asset(
              AssetsUtils.ASSETS_ONBOARDING_ORDER,
              height: hp(50, context),
              width: wp(50, context),
            ),
            SvgPicture.asset(
              AssetsUtils.ASSETS_ONBOARDING_ENJOY,
              height: hp(50, context),
              width: wp(50, context),
            ),
          ],
          totalPage: 3,
          speed: 1.8,
          pageBodies: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: wp(8, context)),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: hp(50, context),
                    width: wp(50, context),
                  ),
                  Text(
                    'Browse',
                    style:
                        smallTitleTextStyle.copyWith(fontFamily: fontSemiBold),
                  ),
                  Text(
                    'Discover a world of culinary delights at your fingertips. Explore our extensive menu featuring a wide array of delectable dishes, each prepared to perfection. Swipe through, get inspired, and find your next favorite meal.',
                    style: textSmallRegularStyle,
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: wp(8, context)),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: hp(50, context),
                    width: wp(50, context),
                  ),
                  Text(
                    'Order',
                    style:
                        smallTitleTextStyle.copyWith(fontFamily: fontSemiBold),
                  ),
                  Text(
                    'Satisfy your cravings effortlessly. With just a few taps, you can place your order and have your favorite dishes on their way to you. Customize your choices, select your preferred delivery or pickup options, and get ready to indulge in an exceptional dining experience.',
                    style: textSmallRegularStyle,
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: wp(8, context)),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: hp(50, context),
                    width: wp(50, context),
                  ),
                  Text(
                    'Enjoy!',
                    style:
                        smallTitleTextStyle.copyWith(fontFamily: fontSemiBold),
                  ),
                  Text(
                    "Your culinary journey is about to begin. Delight in the flavors, aromas, and textures that our exquisite dishes bring to your table. Whether you're dining solo, with loved ones, or sharing a meal with friends, relish in the moment and make memories over fantastic food. Your satisfaction is our ultimate goal.",
                    style: textSmallRegularStyle,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
