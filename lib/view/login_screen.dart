import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:table_menu_customer/model/custom_result_model.dart';
import 'package:table_menu_customer/model/user_model.dart';
import 'package:table_menu_customer/utils/assets/assets_utils.dart';
import 'package:table_menu_customer/utils/routes/routes_name.dart';
import 'package:table_menu_customer/utils/validation/validation.dart';
import 'package:table_menu_customer/utils/widgets/custom_flushbar_widget.dart';

import '../utils/widgets/custom_button.dart';
import '../utils/widgets/custom_text.dart';
import '../utils/widgets/custom_textformfield.dart';
import '../utils/widgets/forgot_pass_email_widget.dart';
import '../view_model/auth_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey_login = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final auth_provider = Provider.of<AuthProvider>(context, listen: true);
    ValueNotifier<bool> obsecurePassword = ValueNotifier<bool>(true);
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 35, vertical: 25),
                child: Column(children: [
                  Container(
                    width: 200,
                    height: 200,
                    padding: const EdgeInsets.all(20.0),
                    child: Image.asset(AssetsUtils.ASSETS_LOGIN_LOGO),
                  ),
                  const Text(
                    "Login",
                    style:
                    TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Enter Your Credentials",
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.black38,
                        fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Form(
                    key: _formKey_login,
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          CustomTextFormField().getCustomEditTextArea(
                            labelValue: "Email",
                            hintValue: "Enter Email",
                            obscuretext: false,
                            maxLines: 1,
                            keyboardType: TextInputType.emailAddress,
                            prefixicon: const Icon(
                              Icons.email_outlined,
                              color: Colors.black,
                            ),
                            textInputAction: TextInputAction.next,
                            controller: auth_provider.emailLoginController,
                            validator: emailValidator,
                            onchanged: (newValue) {},
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          ValueListenableBuilder(
                            valueListenable: obsecurePassword,
                            builder: (context, value, child) {
                              return CustomTextFormField()
                                  .getCustomEditTextArea(
                                  labelValue: "Password",
                                  hintValue: "Enter Password",
                                  obscuretext: obsecurePassword.value,
                                  maxLines: 1,
                                  textInputAction: TextInputAction.done,
                                  prefixicon: const Icon(
                                    Icons.password_outlined,
                                    color: Colors.black,
                                  ),
                                  controller: auth_provider
                                      .passwordLoginController,
                                  validator: passwordValidator,
                                  onchanged: (newValue) {},
                                  iconButton: IconButton(
                                    onPressed: () {
                                      obsecurePassword.value =
                                      !obsecurePassword.value;
                                    },
                                    icon: obsecurePassword.value
                                        ? const Icon(
                                      Icons.visibility_off_outlined,
                                      color: Colors.black,
                                    )
                                        : const Icon(
                                      Icons.visibility_outlined,
                                      color: Colors.black,
                                    ),
                                  ));
                            },
                          ),
                          const SizedBox(
                            height: 8,
                          ),
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
                                        });
                                  },
                                  child: const CustomText(
                                    text: "Forgot Password",
                                    color: Colors.purple,
                                    size: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          SizedBox(
                            height: 50,
                            width: double.infinity,
                            child: CustomButton(
                              onPressed: () async {
                                if (_formKey_login.currentState!.validate()) {
                                  CustomResultModel? result = await auth_provider
                                      .userLogin(
                                      auth_provider.emailLoginController.text,
                                      auth_provider
                                          .passwordLoginController.text,
                                      );
                                  if (result!.optionalBool!) {
                                    if (result.status) {
                                      CustomFlushbar.showSuccess(
                                          context, result.message);
                                      Navigator.pushReplacementNamed(context,
                                          RoutesName.HOME_SCREEN_ROUTE);
                                    } else {
                                      CustomFlushbar.showError(
                                          context, result.message);
                                    }
                                  } else {
                                    if (result.status) {
                                      CustomFlushbar.showSuccess(
                                          context, result.message);
                                      Navigator.pushReplacementNamed(
                                          context,
                                          RoutesName.USER_INFO_SCREEN_ROUTE,arguments: null);
                                    } else {
                                      CustomFlushbar.showError(
                                          context, result.message);
                                    }
                                  }
                                }
                              },
                              child: auth_provider.loading ?
                              const CircularProgressIndicator(
                                color: Colors.white,
                              )
                              : const CustomText(
                                text: "Login",
                                size: 18,
                                color: Colors.white,
                                weight: FontWeight.w400,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                const CustomText(
                                  text: "Don't have an account?",
                                  color: Colors.black,
                                  size: 14,
                                ),
                                const SizedBox(
                                  width: 6,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(context,
                                        RoutesName.REGISTER_SCREEN_ROUTE);
                                  },
                                  child: const CustomText(
                                    text: "Register",
                                    color: Colors.purple,
                                    size: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ]),
              ),
            ),
          )),
    );
  }
}
