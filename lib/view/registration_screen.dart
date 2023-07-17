import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_menu_customer/utils/assets/assets_utils.dart';
import 'package:table_menu_customer/utils/widgets/custom_flushbar_widget.dart';


import '../utils/font/text_style.dart';
import '../utils/responsive.dart';
import '../utils/validation/validation.dart';
import '../utils/widgets/custom_button.dart';
import '../utils/widgets/custom_textformfield.dart';
import '../view_model/auth_provider.dart';

class RegistrationScreen extends StatelessWidget {
  RegistrationScreen({Key? key}) : super(key: key);
  final _formKey_register = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final auth_provider = Provider.of<AuthProvider>(context, listen: true);
    ValueNotifier<bool> obsecurePassword = ValueNotifier<bool>(true);
    ValueNotifier<bool> obsecureRepeatPassword = ValueNotifier<bool>(true);
    FocusNode _passwordFocusNode = FocusNode();
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
                  Container(
                    width: wp(40,context), // Adjust the percentage as needed
                    height: wp(40,context), // Using the same percentage to maintain aspect ratio
                    child: Image.asset(AssetsUtils.ASSETS_LOGIN_LOGO),
                  ),
                  Text(
                    "Registration",
                    style: titleTextStyle, // Use the defined TextStyle
                  ),
                  SizedBox(height: hp(1,context)), // Use hp() for height
                  Text(
                    "Enter Your Credentials",
                    style: textSmallRegularStyle.copyWith(
                      color: Colors.black38,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: hp(1,context)), // Use hp() for height
                  Form(
                    key: _formKey_register,
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
                            controller: auth_provider.emailRegisterController,
                            validator: emailValidator,
                            onchanged: (newValue) {},
                          ),
                          SizedBox(height: hp(1,context)), // Use hp() for height
                          ValueListenableBuilder(
                            valueListenable: obsecurePassword,
                            builder: (context, value, child) {
                              return CustomTextFormField().getCustomEditTextArea(
                                labelValue: "Password",
                                hintValue: "Enter Password",
                                obscuretext: obsecurePassword.value,
                                maxLines: 1,
                                textInputAction: TextInputAction.next,
                                focusNode: _passwordFocusNode,
                                onFieldSubmitted: (value) {
                                  _passwordFocusNode.nextFocus();
                                },
                                prefixicon: const Icon(
                                  Icons.password_outlined,
                                  color: Colors.black,
                                ),
                                controller:
                                auth_provider.passwordRegisterController,
                                validator: passwordValidator,
                                onchanged: (newValue) {},
                                icon: InkWell(
                                  splashColor: Colors.transparent,
                                  onTap: () {
                                    obsecurePassword.value =
                                    !obsecurePassword.value;
                                  },
                                  child:  obsecurePassword.value
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
                            valueListenable: obsecureRepeatPassword,
                            builder: (context, value, child) {
                              return CustomTextFormField().getCustomEditTextArea(
                                labelValue: "Confirm Password",
                                hintValue: "Enter Confirm Password",
                                obscuretext: obsecureRepeatPassword.value,
                                maxLines: 1,
                                textInputAction: TextInputAction.done,
                                prefixicon: const Icon(
                                  Icons.password_outlined,
                                  color: Colors.black,
                                ),
                                controller: auth_provider
                                    .repeatePasswordRegisterController,
                                validator: passwordValidator,
                                onchanged: (newValue) {},
                                icon: InkWell(
                                  splashColor: Colors.transparent,
                                  onTap: () {
                                    obsecureRepeatPassword.value =
                                    !obsecureRepeatPassword.value;
                                  },
                                  child:  obsecureRepeatPassword.value
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
                                if (_formKey_register.currentState!.validate()) {
                                  if (auth_provider.passwordRegisterController.text !=
                                      auth_provider.repeatePasswordRegisterController.text) {
                                    CustomFlushbar.showError(
                                        context, "Password doesn't match enter same password");
                                  } else {
                                    var data = {
                                      "email": auth_provider.emailRegisterController.text,
                                      "password": auth_provider.passwordRegisterController.text,
                                    };
                                    auth_provider.userRegisteration(data, context);
                                  }
                                }
                              },
                              child: auth_provider.loading
                                  ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                                  : Text("Register",
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
                                Text(
                                    "Already have an account?",
                                    style: textSmallRegularStyle
                                ),
                                const SizedBox(width: 6),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    "Login",
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