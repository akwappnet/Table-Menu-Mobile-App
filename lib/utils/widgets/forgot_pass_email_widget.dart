import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_menu_customer/model/custom_result_model.dart';
import 'package:table_menu_customer/utils/widgets/custom_flushbar_widget.dart';
import 'package:table_menu_customer/view_model/auth_provider.dart';

import '../../view/verify_user_screen.dart';
import '../routes/routes_name.dart';
import '../validation/validation.dart';
import 'custom_button.dart';
import 'custom_text.dart';
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
      title: const Center(child: CustomText(text: "Forgot Password", size: 20, weight: FontWeight.w500,)),
      content: Wrap(
        runSpacing: 20.0,
        children: [
          const SizedBox(height: 6,),
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
              textInputAction: TextInputAction.done
            ),
          ),
          SizedBox(
            height: 50,
            width: double.infinity,
            child: CustomButton(
              onPressed: () async {
                if (_form_email.currentState!
                    .validate()) {
                  String email = auth_provider.forgotPassEmailController.text;
                  CustomResultModel? result = await auth_provider.sendVerifiactionMail(email);
                  if(result!.status){
                    CustomFlushbar.showSuccess(context, result.message);
                    Navigator.pushReplacementNamed(
                        context, RoutesName.VERIFY_USER_SCREEN_ROUTE,
                        arguments: true);
                  }else {
                    CustomFlushbar.showError(context, result.message);
                  }
                }
              },
              child: auth_provider.loading ?
              const CircularProgressIndicator(color: Colors.white,)
                  : const CustomText(
                text: "Send OTP",
                size: 18,
                color: Colors.white,
                weight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
