import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:table_menu_customer/model/custom_result_model.dart';
import 'package:table_menu_customer/utils/validation/validation.dart';
import 'package:table_menu_customer/utils/widgets/custom_flushbar_widget.dart';
import 'package:table_menu_customer/view/select_photo_options_screen.dart';
import '../model/user_model.dart';
import '../utils/routes/routes_name.dart';
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

  @override
  void dispose() {
    super.dispose();
  }

  final GlobalKey<FormState> _form_key_userinfo = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final auth_provider = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: const Icon(Icons.arrow_back),
                    ),
                  ),
                  const SizedBox(height: 20),
                  widget.userData == null
                      ? const Text(
                          "Enter Your Details",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      : const Text(
                          "Update Your Details",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                  const SizedBox(height: 10),
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
                        radius: const Radius.circular(20.0),
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
                                  ? const Column(
                                      children: [
                                        SizedBox(
                                          height: 6,
                                        ),
                                        CircleAvatar(
                                          backgroundColor: Colors.purple,
                                          radius: 50,
                                          child: Icon(
                                            Icons.account_circle,
                                            size: 50,
                                            color: Colors.white,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Text(
                                          "Upload Profile Photo",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
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
                  Form(
                    key: _form_key_userinfo,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 15),
                      margin: const EdgeInsets.only(top: 20),
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
                          const SizedBox(
                            height: 15,
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
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 50,
                    width: MediaQuery.of(context).size.width * 0.90,
                    child: CustomButton(
                        child: widget.userData == null ?const Text(
                          "Save",
                          style: TextStyle(fontSize: 16),
                        ) : const Text(
                          "Update",
                          style: TextStyle(fontSize: 16),
                        ),
                        onPressed: () async {
                          if (_form_key_userinfo.currentState!.validate()) {
                            if (widget.userData == null) {
                              CustomResultModel? result = await auth_provider.saveUserInfo();
                              if(result!.status){
                                CustomFlushbar.showSuccess(context, result.message);
                                Navigator.pushReplacementNamed(context, RoutesName.HOME_SCREEN_ROUTE);
                              }else {
                                CustomFlushbar.showError(context, result.message);
                              }
                            } else {
                              CustomResultModel? result_update = await auth_provider.updateUserInfo();

                              if(result_update!.status){
                                CustomFlushbar.showSuccess(context, result_update.message);
                                Navigator.of(context).pop();
                              }else {
                                CustomFlushbar.showError(context, result_update.message);
                              }
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