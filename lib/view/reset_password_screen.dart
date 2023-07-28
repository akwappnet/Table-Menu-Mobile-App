import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_menu_customer/utils/assets/assets_utils.dart';

import '../app_localizations.dart';
import '../utils/font/text_style.dart';
import '../utils/responsive.dart';
import '../utils/validation/validation.dart';
import '../utils/widgets/custom_button.dart';
import '../utils/widgets/custom_snack_bar.dart';
import '../utils/widgets/custom_textformfield.dart';
import '../view_model/auth_provider.dart';

class ResetPasswordScreen extends StatelessWidget {
   ResetPasswordScreen({Key? key}) : super(key: key);

  final _formKey_reset_password = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final auth_provider = Provider.of<AuthProvider>(context, listen: true);
    ValueNotifier<bool> obsecurePassword = ValueNotifier<bool>(true);
    ValueNotifier<bool> obsecureRepeatePassword = ValueNotifier<bool>(true);
    FocusNode passwordFocusNode = FocusNode();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        backgroundColor: Colors.white,
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
                    child: Image.asset(AssetsUtils.ASSETS_RESET_PASSWORD_LOGO),
                  ),
                  Text(
                    AppLocalizations.of(context).translate('reset_password'),
                    style: titleTextStyle, // Use the defined TextStyle
                  ),
                  SizedBox(height: hp(1,context)), // Use hp() for height
                  Text(
                    AppLocalizations.of(context).translate('enter_new_credentials'),
                    style: textRegularStyle.copyWith(
                      color: Colors.black38,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: hp(1,context)), // Use hp() for height
                  Form(
                    key: _formKey_reset_password,
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          ValueListenableBuilder(
                            valueListenable: obsecurePassword,
                            builder: (context, value, child) {
                              return CustomTextFormField().getCustomEditTextArea(
                                textInputAction: TextInputAction.next,
                                focusNode: passwordFocusNode,
                                onFieldSubmitted: (value) {
                                  passwordFocusNode.nextFocus();
                                },
                                labelValue: AppLocalizations.of(context).translate('label_password'),
                                hintValue: AppLocalizations.of(context).translate('hint_password'),
                                obscuretext: obsecurePassword.value,
                                maxLines: 1,
                                prefixicon: const Icon(
                                  Icons.password_outlined,
                                  color: Colors.black,
                                ),
                                controller: auth_provider.resetPassController,
                                validator: (value) =>  passwordValidator(context,value),
                                onchanged: (newValue) {},
                                icon: InkWell(
                                  splashColor: Colors.transparent,
                                  onTap: () {
                                    obsecurePassword.value = !obsecurePassword.value;
                                  },
                                  child: obsecurePassword.value
                                      ? const Icon(
                                    Icons.visibility_off_outlined,
                                    color: Colors.black,
                                  )
                                      : const Icon(
                                    Icons.visibility_outlined,
                                    color: Colors.black,
                                  ),
                                ),
                              );
                            },
                          ),
                          SizedBox(height: hp(1,context)), // Use hp() for height
                          ValueListenableBuilder(
                            valueListenable: obsecureRepeatePassword,
                            builder: (context, value, child) {
                              return CustomTextFormField().getCustomEditTextArea(
                                labelValue: AppLocalizations.of(context).translate('label_confirm_password'),
                                hintValue: AppLocalizations.of(context).translate('hint_confirm_password'),
                                obscuretext: obsecureRepeatePassword.value,
                                maxLines: 1,
                                textInputAction: TextInputAction.done,
                                prefixicon: const Icon(
                                  Icons.password_outlined,
                                  color: Colors.black,
                                ),
                                controller: auth_provider.resetrepeatPassController,
                                validator: (value) =>  passwordValidator(context,value),
                                onchanged: (newValue) {},
                                icon: InkWell(
                                  splashColor: Colors.transparent,
                                  onTap: () {
                                    obsecureRepeatePassword.value = !obsecureRepeatePassword.value;
                                  },
                                  child: obsecureRepeatePassword.value
                                      ? const Icon(
                                    Icons.visibility_off_outlined,
                                    color: Colors.black,
                                  )
                                      : const Icon(
                                    Icons.visibility_outlined,
                                    color: Colors.black,
                                  ),
                                ),
                              );
                            },
                          ),
                          SizedBox(height: hp(3,context)), // Use hp() for height
                          SizedBox(
                            height: hp(7.5,context), // Use hp() for height
                            width: double.infinity,
                            child: CustomButton(
                              onPressed: () async {
                                if (_formKey_reset_password.currentState!.validate()) {
                                  if (auth_provider.passwordRegisterController.text !=
                                      auth_provider.repeatePasswordRegisterController.text) {
                                    showsnackbar(context, AppLocalizations.of(context).translate('passowrd_doesnt_match_error_message'));
                                  } else {
                                    String password = auth_provider.resetPassController.text;
                                    String email = auth_provider.forgotPassEmailController.text;
                                    auth_provider.resetPasswordUser(email, password,context);
                                  }
                                }
                              },
                              child: auth_provider.loading
                                  ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                                  : Text(
                                AppLocalizations.of(context).translate('reset_password'),
                                style: textBodyStyle.copyWith(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
