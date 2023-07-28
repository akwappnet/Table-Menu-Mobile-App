import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_menu_customer/utils/assets/assets_utils.dart';
import 'package:table_menu_customer/utils/routes/routes_name.dart';
import 'package:table_menu_customer/utils/validation/validation.dart';

import '../app_localizations.dart';
import '../utils/font/text_style.dart';
import '../utils/responsive.dart';
import '../utils/widgets/custom_button.dart';
import '../utils/widgets/custom_textformfield.dart';
import '../utils/widgets/forgot_pass_email_widget.dart';
import '../view_model/auth_provider.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final _formKey_login = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final auth_provider = Provider.of<AuthProvider>(context, listen: true);
    ValueNotifier<bool> obsecurePassword = ValueNotifier<bool>(true);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: wp(4,context), vertical: hp(2,context)),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: wp(40,context), // Adjust the percentage as needed
                    height: wp(40,context), // Using the same percentage to maintain aspect ratio
                    child: Image.asset(AssetsUtils.ASSETS_LOGIN_LOGO),
                  ),
                  Text(
                    AppLocalizations.of(context).translate('Login'),
                    style: titleTextStyle,
                  ),
                  SizedBox(height: hp(2,context)),
                  Text(
                    AppLocalizations.of(context).translate('enter_your_credentials'),
                    style: textRegularStyle.copyWith(
                      color: Colors.black38,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: hp(2,context)), // Use hp() for height
                  Form(
                    key: _formKey_login,
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          CustomTextFormField().getCustomEditTextArea(
                            labelValue: AppLocalizations.of(context).translate('label_email'),
                            hintValue: AppLocalizations.of(context).translate('hint_email'),
                            obscuretext: false,
                            maxLines: 1,
                            keyboardType: TextInputType.emailAddress,
                            prefixicon: const Icon(
                              Icons.email_outlined,
                              color: Colors.black,
                            ),
                            textInputAction: TextInputAction.next,
                            controller: auth_provider.emailLoginController,
                            validator: (value) =>  emailValidator(context,value),
                            onchanged: (newValue) {},
                          ),
                          SizedBox(height: hp(2,context)), // Use hp() for height
                          ValueListenableBuilder(
                            valueListenable: obsecurePassword,
                            builder: (context, value, child) {
                              return CustomTextFormField().getCustomEditTextArea(
                                labelValue: AppLocalizations.of(context).translate('label_password'),
                                hintValue: AppLocalizations.of(context).translate('hint_password'),
                                obscuretext: obsecurePassword.value,
                                maxLines: 1,
                                textInputAction: TextInputAction.done,
                                prefixicon: const Icon(
                                  Icons.password_outlined,
                                  color: Colors.black,
                                ),
                                controller: auth_provider.passwordLoginController,
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
                                  )
                              );
                            },
                          ),
                          SizedBox(height: hp(1,context)), // Use hp() for height
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return const ForgotPassEmailWidget();
                                      },
                                    );
                                  },
                                  child: Text( AppLocalizations.of(context).translate('forgot_password'),
                                    style: textSmallRegularStyle.copyWith(color: Colors.purple),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: hp(1,context)), // Use hp() for height
                          SizedBox(
                            height: hp(7.5,context), // Use hp() for height
                            width: double.infinity,
                            child: CustomButton(
                              onPressed: () async {
                                if (_formKey_login.currentState!.validate()) {
                                  auth_provider.userLogin(
                                    auth_provider.emailLoginController.text,
                                    auth_provider.passwordLoginController.text,
                                    context,
                                  );
                                }
                              },
                              child: auth_provider.loading
                                  ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                                  : Text(AppLocalizations.of(context).translate('login'),
                                style: textBodyStyle.copyWith(color: Colors.white),
                              ),
                            ),
                          ),
                          SizedBox(height: hp(1,context)), // Use hp() for height
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(AppLocalizations.of(context).translate('dont_have_a_account'),
                                    style: textSmallRegularStyle
                                ),
                                const SizedBox(width: 6),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      RoutesName.REGISTER_SCREEN_ROUTE,
                                    );
                                  },
                                  child: Text(AppLocalizations.of(context).translate('register'),
                                    style: textSmallRegularStyle.copyWith(color: Colors.purple),
                                  ),
                                ),
                              ],
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