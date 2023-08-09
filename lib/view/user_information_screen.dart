import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';
import 'package:table_menu_customer/utils/constants/constants_text.dart';
import 'package:table_menu_customer/utils/font/text_style.dart';
import 'package:table_menu_customer/utils/responsive.dart';
import 'package:table_menu_customer/utils/validation/validation.dart';
import 'package:table_menu_customer/view/select_photo_options_screen.dart';

import '../app_localizations.dart';
import '../model/user_model.dart';
import '../utils/widgets/custom_button.dart';
import '../utils/widgets/custom_textformfield.dart';
import '../view_model/auth_provider.dart';

class UserInfoScreen extends StatefulWidget {
  final UserData? userData;

  const UserInfoScreen([this.userData]);

  @override
  State<UserInfoScreen> createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  @override
  void initState() {
    if (widget.userData == null) {
      // new record
      Future.delayed(Duration.zero, () {
        final authProvider = Provider.of<AuthProvider>(context, listen: false);
        authProvider.nameController.text = "";
        authProvider.phoneNoController.text = "";
      });
    } else {
      // existing record update
      //State Update
      Future.delayed(Duration.zero, () {
        final authProvider = Provider.of<AuthProvider>(context, listen: false);
        authProvider.loadValues(widget.userData!);
      });
    }
    super.initState();
  }

  Future _pickImage(ImageSource source) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    try {
      final image = await ImagePicker().pickImage(source: source);

      final imageTemporary = File(image!.path);

      authProvider.setImagetemp(imageTemporary);
      Navigator.of(context).pop();
    } on Exception {
      Navigator.of(context).pop();
    }
  }

  void _showSelectPhotoOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      builder: (context) => DraggableScrollableSheet(
          initialChildSize: 0.28,
          maxChildSize: 0.4,
          minChildSize: 0.28,
          expand: false,
          builder: (context, scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              child: SelectPhotoOptionsScreen(
                onTap: _pickImage,
              ),
            );
          }),
    );
  }

  final GlobalKey<FormState> _form_key_userinfo = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: widget.userData == null
            ? Text(AppLocalizations.of(context).translate('enter_your_details'),
                style: titleTextStyle)
            : Text(
                AppLocalizations.of(context).translate('update_your_details'),
                style: titleTextStyle),
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0.0,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: hp(2, context), horizontal: wp(2.5, context)),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: hp(2, context)),
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    _showSelectPhotoOptions(context);
                  },
                  child: Center(
                    child: DottedBorder(
                      color: Colors.black,
                      strokeWidth: 1,
                      borderType: BorderType.RRect,
                      radius: const Radius.circular(BORDER_RADIUS),
                      padding: const EdgeInsets.all(8),
                      child: Container(
                          height: 150.0,
                          width: 200.0,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            shape: BoxShape.rectangle,
                          ),
                          child: Center(
                            child: authProvider.temp_image == null
                                ? Column(
                                    children: [
                                      SizedBox(
                                        height: hp(1, context),
                                      ),
                                      const CircleAvatar(
                                        backgroundColor: Colors.purple,
                                        radius: 50,
                                        child: Icon(
                                          Icons.account_circle,
                                          size: 50,
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(
                                        height: hp(2, context),
                                      ),
                                      Text(
                                          AppLocalizations.of(context)
                                              .translate(
                                                  'upload_profile_photo'),
                                          style: textBodyStyle),
                                    ],
                                  )
                                : CircleAvatar(
                                    backgroundImage:
                                        FileImage(authProvider.temp_image),
                                    radius: 80,
                                  ),
                          )),
                    ),
                  ),
                ),
                SizedBox(
                  height: hp(2, context),
                ),
                Form(
                  key: _form_key_userinfo,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        CustomTextFormField().getCustomEditTextArea(
                          obscuretext: false,
                          labelValue: AppLocalizations.of(context)
                              .translate('label_name'),
                          hintValue: AppLocalizations.of(context)
                              .translate('hint_name'),
                          onchanged: (value) {},
                          textInputAction: TextInputAction.next,
                          prefixicon: const Icon(
                            Icons.drive_file_rename_outline,
                            color: Colors.black,
                          ),
                          controller: authProvider.nameController,
                          validator: (value) => validateName(context, value),
                        ),
                        SizedBox(
                          height: hp(2, context),
                        ),
                        IntlPhoneField(
                          decoration: InputDecoration(
                            labelText: AppLocalizations.of(context)
                                .translate('label_phone_no'),
                            border: const OutlineInputBorder(
                                borderSide: BorderSide(),
                                borderRadius: BorderRadius.all(
                                    Radius.circular(BORDER_RADIUS))),
                          ),
                          initialCountryCode: 'IN',
                          textInputAction: TextInputAction.done,
                          controller: authProvider.phoneNoController,
                          onChanged: (phone) {},
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: hp(2, context)),
                SizedBox(
                  height: hp(7.5, context),
                  width: wp(100, context),
                  child: CustomButton(
                      child: widget.userData == null
                          ? Text(
                              AppLocalizations.of(context).translate('save'),
                              style:
                                  textBodyStyle.copyWith(color: Colors.white),
                            )
                          : Text(
                              AppLocalizations.of(context).translate('update'),
                              style:
                                  textBodyStyle.copyWith(color: Colors.white),
                            ),
                      onPressed: () async {
                        if (_form_key_userinfo.currentState!.validate()) {
                          if (widget.userData == null) {
                            authProvider.saveUserInfo(context);
                          } else {
                            authProvider.updateUserInfo(context);
                          }
                        }
                      }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
