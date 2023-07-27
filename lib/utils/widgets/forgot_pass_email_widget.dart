import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_menu_customer/utils/font/text_style.dart';
import 'package:table_menu_customer/view_model/auth_provider.dart';

import '../validation/validation.dart';
import 'custom_button.dart';
import 'custom_textformfield.dart';

class ForgotPassEmailWidget extends StatefulWidget {
  const ForgotPassEmailWidget({Key? key}) : super(key: key);

  @override
  State<ForgotPassEmailWidget> createState() => _ForgotPassEmailWidgetState();
}

class _ForgotPassEmailWidgetState extends State<ForgotPassEmailWidget> {
  final _form_email = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final auth_provider = Provider.of<AuthProvider>(context);
    return AlertDialog(
      title: Center(
        child: Text(
          "Forgot Password",
          style: textBodyStyle,
        ),
      ),
      content: Wrap(
        runSpacing: 20.0,
        children: [
          const SizedBox(
            height: 6,
          ),
          Form(
            key: _form_email,
            child: CustomTextFormField().getCustomEditTextArea(
                labelValue: "Email",
                hintValue: "Enter Email",
                obscuretext: false,
                maxLines: 1,
                keyboardType: TextInputType.emailAddress,
                prefixicon: const Icon(
                  Icons.email_outlined,
                  color: Colors.black,
                ),
                controller: auth_provider.forgotPassEmailController,
                validator: emailValidator,
                onchanged: (newValue) {},
                textInputAction: TextInputAction.done),
          ),
          SizedBox(
            height: 50,
            width: double.infinity,
            child: CustomButton(
              onPressed: () {
                if (_form_email.currentState!.validate()) {
                  String email = auth_provider.forgotPassEmailController.text;
                  auth_provider.sendVerifiactionMail(email,context);
                }
              },
              child: auth_provider.loading
                  ? const CircularProgressIndicator(
                      color: Colors.white,
                    )
                  : Text("Send OTP",
                style: textBodyStyle.copyWith(color: Colors.white),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
