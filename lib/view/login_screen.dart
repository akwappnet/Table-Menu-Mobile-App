import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/widgets/custom_button.dart';
import '../view_model/auth_provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController phoneController = TextEditingController();

  final _formKey_auth = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final auth_provider = Provider.of<AuthProvider>(context, listen: true);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 35),
              child: Column(
                children: [
                  Container(
                    width: 200,
                    height: 200,
                    padding: const EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.purple.shade50,
                    ),
                    child: Image.asset(
                      "assets/images/mobile_login.png",
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Register",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Add your phone number. We'll send you a verification code",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black38,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  Form(
                    key: _formKey_auth,
                    child: Column(
                      children: [
                        TextFormField(
                            cursorColor: Colors.purple,
                            controller: phoneController,
                            maxLength: 10,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              String regexPattern =
                                  r'^(?:[+0][1-9])?[0-9]{10}$';
                              RegExp regex = new RegExp(regexPattern);
                              if (!regex.hasMatch(value!)) {
                                return "enter valid phone no";
                              }
                            },
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              errorBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.red, width: 3),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25)),
                              ),
                              hintText: "Enter phone number",
                              border:OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  borderSide:
                                  const BorderSide(color: Colors.black12)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  borderSide:
                                      const BorderSide(color: Colors.black12)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  borderSide:
                                      const BorderSide(color: Colors.black12)),
                              prefixIcon: Container(
                                padding: const EdgeInsets.only(
                                    left: 8.0,
                                    right: 8.0,
                                    top: 12.0,
                                    bottom: 12.0),
                                child: InkWell(
                                  onTap: () {
                                    showCountryPicker(
                                        context: context,
                                        countryListTheme:
                                            const CountryListThemeData(
                                          bottomSheetHeight: 550,
                                        ),
                                        onSelect: (value) {
                                          auth_provider.setCountry(value);
                                        });
                                  },
                                  child: Text(
                                    "${auth_provider.selectedCountry.flagEmoji} + ${auth_provider.selectedCountry.phoneCode}",
                                    style: const TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            )),
                        SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: CustomButton(
                              child: Text(
                                "Login",
                                style: TextStyle(fontSize: 16),
                              ),
                              onPressed: () {
                                if (_formKey_auth.currentState!.validate()) {
                                  sendPhoneNumber();
                                }
                              }),
                        )
                      ],
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

  void sendPhoneNumber() {
    final auth_provider = Provider.of<AuthProvider>(context, listen: false);
    String phoneNumber = phoneController.text.trim();
    // auth_provider.signInWithPhone(
    //     context, "+${auth_provider.selectedCountry.phoneCode}$phoneNumber");
  }
}
