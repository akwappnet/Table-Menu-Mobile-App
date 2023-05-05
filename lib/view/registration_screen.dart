import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_menu_customer/utils/widgets/custom_snack_bar.dart';
import 'package:table_menu_customer/utils/widgets/custom_text.dart';
import 'package:table_menu_customer/view/login_screen.dart';

import '../utils/validation/validation.dart';
import '../utils/widgets/custom_button.dart';
import '../utils/widgets/custom_textformfield.dart';
import '../view_model/auth_provider.dart';


class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey_register = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final auth_provider = Provider.of<AuthProvider>(context, listen: true);
    ValueNotifier<bool> obsecurePassword = ValueNotifier<bool>(true);
    ValueNotifier<bool> obsecureRepeatePassword = ValueNotifier<bool>(true);
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 25),
                child: Column(children: [
                  Container(
                    width: 200,
                    height: 200,
                    padding: const EdgeInsets.all(20.0),
                    child: Image.asset("assets/images/mobile_login.png"),
                  ),
                  const Text(
                    "Registration",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
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
                    height: 10,
                  ),
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
                            controller: auth_provider.emailRegisterController,
                            validator: emailValidator,
                            onchanged: (newValue) {},
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          ValueListenableBuilder(
                            valueListenable: obsecurePassword,
                            builder: (context, value, child) {
                              return CustomTextFormField().getCustomEditTextArea(
                                  labelValue: "Password",
                                  hintValue: "Enter Password",
                                  obscuretext: obsecurePassword.value,
                                  maxLines: 1,
                                  prefixicon: const Icon(
                                    Icons.password_outlined,
                                    color: Colors.black,
                                  ),
                                  controller: auth_provider.passwordRegisterController,
                                  validator: passwordValidator,
                                  onchanged: (newValue) {},
                                  iconButton: IconButton(
                                    onPressed: () {
                                      obsecurePassword.value = !obsecurePassword.value;
                                    },
                                    icon: obsecurePassword.value ?
                                    const Icon(
                                      Icons.visibility_off_outlined,
                                      color: Colors.black,
                                    ) :
                                    const Icon(
                                      Icons.visibility_outlined,
                                      color: Colors.black,
                                    ),
                                  )
                              );
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          ValueListenableBuilder(
                            valueListenable: obsecureRepeatePassword,
                            builder: (context, value, child) {
                              return CustomTextFormField().getCustomEditTextArea(
                                  labelValue: "Confirm Password",
                                  hintValue: "Enter Confirm Password",
                                  obscuretext: obsecureRepeatePassword.value,
                                  maxLines: 1,
                                  prefixicon: const Icon(
                                    Icons.password_outlined,
                                    color: Colors.black,
                                  ),
                                  controller: auth_provider.repeatePasswordRegisterController,
                                  validator: passwordValidator,
                                  onchanged: (newValue) {},
                                  iconButton: IconButton(
                                    onPressed: () {
                                      obsecureRepeatePassword.value = !obsecureRepeatePassword.value;
                                    },
                                    icon: obsecureRepeatePassword.value ?
                                    const Icon(
                                      Icons.visibility_off_outlined,
                                      color: Colors.black,
                                    ) :
                                    const Icon(
                                      Icons.visibility_outlined,
                                      color: Colors.black,
                                    ),
                                  )
                              );
                            },
                          ),
                          SizedBox(height: 8,),
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                CustomText(
                                    text: "Already have an account?",
                                  color: Colors.black,
                                  size: 14,
                                ),
                                SizedBox(width: 6,),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen(),));
                                  },
                                  child: CustomText(
                                    text: "Login",
                                    color: Colors.purple,
                                    size: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 8,),
                          SizedBox(
                            height: 50,
                            width: double.infinity,
                            child: CustomButton(
                              onPressed: () async {
                                if (_formKey_register.currentState!
                                    .validate()) {
                                  if(auth_provider.passwordRegisterController.text != auth_provider.repeatePasswordRegisterController.text){
                                    showsnackbar(context, "Password doesn't match enter same password");
                                  }else {
                                    String email = auth_provider.emailRegisterController.text;
                                    String password = auth_provider.passwordRegisterController.text;
                                    auth_provider.userRegisteration(email, password, context);
                                  }
                                }
                              },
                              child: auth_provider.loading ?
                              const CircularProgressIndicator(color: Colors.white,)
                                  : const CustomText(
                                text: "Register",
                                size: 18,
                                color: Colors.white,
                                weight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ]),
              ),
            ),
          )
      ),
    );
  }
}
