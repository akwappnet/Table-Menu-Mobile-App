import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:table_menu_customer/utils/constants/constants_text.dart';
import 'package:table_menu_customer/utils/font/text_style.dart';
import 'package:table_menu_customer/utils/responsive.dart';
import 'package:table_menu_customer/utils/validation/validation.dart';
import 'package:table_menu_customer/view/select_photo_options_screen.dart';
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
        final auth_provider = Provider.of<AuthProvider>(context, listen: false);
        auth_provider.nameController.text = "";
        auth_provider.phoneNoController.text = "";
      });
    } else {
      // existing record update
      //State Update
      Future.delayed(Duration.zero, () {
        final auth_provider = Provider.of<AuthProvider>(context, listen: false);
        auth_provider.loadValues(widget.userData!);
      });
    }
    super.initState();
  }

  Future _pickImage(ImageSource source) async {
    final auth_provider = Provider.of<AuthProvider>(context, listen: false);
    try {
      final image = await ImagePicker().pickImage(source: source);

      final imageTemporary = File(image!.path);

      auth_provider.setImagetemp(imageTemporary);
      Navigator.of(context).pop();
    } on Exception catch (e) {
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
    final auth_provider = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: const Icon(Icons.arrow_back),
        ),
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0.0,
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: hp(2, context), horizontal: wp(4, context)),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  const SizedBox(height: 20),
                  widget.userData == null
                      ? Text(
                          "Enter Your Details",
                          style: titleTextStyle
                        )
                      : Text(
                          "Update Your Details",
                          style: titleTextStyle
                        ),
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30)),
                              shape: BoxShape.rectangle,
                            ),
                            child: Center(
                              child: auth_provider.temp_image == null
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
                                          "Upload Profile Photo",
                                          style: textBodyStyle
                                        ),
                                      ],
                                    )
                                  : CircleAvatar(
                                      backgroundImage:
                                          FileImage(auth_provider.temp_image),
                                      radius: 80,
                                    ),
                            )),
                      ),
                    ),
                  ),
                  SizedBox(height: hp(2, context),),
                  Form(
                    key: _form_key_userinfo,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: [
                          CustomTextFormField().getCustomEditTextArea(
                            obscuretext: false,
                            labelValue: "Name",
                            hintValue: "Enter Name",
                            onchanged: (value) {},
                            textInputAction: TextInputAction.next,
                            prefixicon: const Icon(
                              Icons.drive_file_rename_outline,
                              color: Colors.black,
                            ),
                            controller: auth_provider.nameController,
                            validator: validateName,
                          ),
                          SizedBox(
                            height: hp(2, context),
                          ),
                          CustomTextFormField().getCustomEditTextArea(
                            obscuretext: false,
                            labelValue: "Phone No",
                            hintValue: "Enter Phone No",
                            onchanged: (value) {},
                            maxLength: 10,
                            textInputAction: TextInputAction.done,
                            prefixicon: const Icon(
                              Icons.phone,
                              color: Colors.black,
                            ),
                            keyboardType: TextInputType.phone,
                            controller: auth_provider.phoneNoController,
                            validator: phoneValidator,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: hp(2, context)),
                  SizedBox(
                    height: hp(7.5, context),
                    width: MediaQuery.of(context).size.width * 0.90,
                    child: CustomButton(
                        child: widget.userData == null ? Text(
                          "Save",
                          style: textBodyStyle.copyWith(color: Colors.white),
                        ) : Text(
                          "Update",
                          style: textBodyStyle.copyWith(color: Colors.white),
                        ),
                        onPressed: () async {
                          if (_form_key_userinfo.currentState!.validate()) {
                            if (widget.userData == null) {
                              auth_provider.saveUserInfo(context);
                            } else {
                              auth_provider.updateUserInfo(context);
                            }
                          }
                        }),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}