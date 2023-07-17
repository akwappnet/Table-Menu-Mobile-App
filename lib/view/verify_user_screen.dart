import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:table_menu_customer/utils/assets/assets_utils.dart';
import 'package:table_menu_customer/utils/constants/constants_text.dart';


import '../utils/font/text_style.dart';
import '../utils/responsive.dart';
import '../utils/widgets/custom_button.dart';
import '../view_model/auth_provider.dart';

class VerifyUserScreen extends StatelessWidget {
  final bool? isRequestForForgotPassword;

  const VerifyUserScreen(this.isRequestForForgotPassword, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: const Icon(Icons.arrow_back),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: hp(2,context), horizontal: wp(4,context)), // Use hp() and wp() for padding
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: wp(40,context), // Adjust the percentage as needed
                    height: wp(40,context), // Using the same percentage to maintain aspect ratio
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.purple.shade50,
                    ),
                    child: Image.asset(
                      AssetsUtils.ASSETS_ENTER_OTP_LOGO,
                    ),
                  ),
                  SizedBox(height: hp(2,context)), // Use hp() for height
                  Text(
                    "Verification",
                    style: titleTextStyle, // Use the defined TextStyle
                  ),
                  SizedBox(height: hp(1,context)), // Use hp() for height
                  Text(
                    "Enter the OTP sent to your Email Address",
                    style: textRegularStyle.copyWith(
                      color: Colors.black38,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: hp(2,context)), // Use hp() for height
                  Pinput(
                    length: 6,
                    showCursor: true,
                    controller: isRequestForForgotPassword == true
                        ? authProvider.forgotPassOTPController
                        : authProvider.activationOTPController,
                    defaultPinTheme: PinTheme(
                      width: wp(12,context), // Use wp() for width
                      height: wp(14,context), // Use wp() for height
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(BORDER_RADIUS),
                        border: Border.all(
                          color: Colors.purple.shade200,
                        ),
                      ),
                      textStyle: textBodyStyle
                    ),
                  ),
                  SizedBox(height: hp(3,context)), // Use hp() for height
                  SizedBox(
                    width: double.infinity,
                    height: hp(7.5,context), // Use hp() for height
                    child: CustomButton(
                      child: Text(
                        "Verify",
                        style: textBodyStyle.copyWith(color: Colors.white),
                      ),
                      onPressed: () async {
                        String activationOtp =
                            authProvider.activationOTPController.text;
                        String forgotPassOtp =
                            authProvider.forgotPassOTPController.text;

                        if (isRequestForForgotPassword == true) {
                          authProvider.verifyForgotOtp(
                            forgotPassOtp,
                            authProvider.forgotPassEmailController.text.toString(),
                            context,
                          );
                        } else {
                          authProvider.verifyUser(
                            activationOtp,
                            authProvider.emailRegisterController.text,
                            context,
                          );
                        }
                      },
                    ),
                  ),
                  SizedBox(height: hp(2,context)), // Use hp() for height
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
