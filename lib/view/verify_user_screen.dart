import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:table_menu_customer/model/custom_result_model.dart';
import 'package:table_menu_customer/utils/assets/assets_utils.dart';
import 'package:table_menu_customer/utils/widgets/custom_flushbar_widget.dart';

import '../utils/routes/routes_name.dart';
import '../utils/widgets/custom_button.dart';
import '../view_model/auth_provider.dart';

class VerifyUserScreen extends StatefulWidget {
  final bool? isRequestForForgotPassword;

  const VerifyUserScreen([this.isRequestForForgotPassword]);

  @override
  State<VerifyUserScreen> createState() => _VerifyUserScreenState();
}

class _VerifyUserScreenState extends State<VerifyUserScreen> {
  @override
  Widget build(BuildContext context) {
    final auth_provider = Provider.of<AuthProvider>(context, listen: true);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 30),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: const Icon(Icons.arrow_back),
                    ),
                  ),
                  Container(
                    width: 200,
                    height: 200,
                    padding: const EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.purple.shade50,
                    ),
                    child: Image.asset(
                      AssetsUtils.ASSETS_ENTER_OTP_LOGO,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Verification",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Enter the OTP send to your Email Address",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black38,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  Pinput(
                    length: 6,
                    showCursor: true,
                    controller: widget.isRequestForForgotPassword == true
                        ? auth_provider.forgotPassOTPController
                        : auth_provider.activationOTPController,
                    defaultPinTheme: PinTheme(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.purple.shade200,
                        ),
                      ),
                      textStyle: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    child: CustomButton(
                      child: const Text(
                        "Verify",
                        style: TextStyle(fontSize: 16),
                      ),
                      onPressed: () async {
                        String activationOtp =
                            auth_provider.activationOTPController.text;
                        String forgotPassOtp =
                            auth_provider.forgotPassOTPController.text;
                        if (widget.isRequestForForgotPassword == true) {
                         CustomResultModel? result_forgot_pass = await auth_provider.verifyForgotOtp(forgotPassOtp);

                         if(result_forgot_pass!.status){
                           CustomFlushbar.showSuccess(context, result_forgot_pass.message);
                           Navigator.pushReplacementNamed(
                               context, RoutesName.RESET_PASSWORD_SCREEN_ROUTE);
                         }else {
                           CustomFlushbar.showError(context, result_forgot_pass.message);
                         }
                        } else {
                          CustomResultModel? result = await auth_provider.verifyUser(activationOtp);
                          if(result!.status){
                            CustomFlushbar.showSuccess(context, result.message);
                            Navigator.pushReplacementNamed(context, RoutesName.LOGIN_SCREEN_ROUTE);
                          }else {
                            CustomFlushbar.showError(context, result.message);
                          }
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
