import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:table_menu_customer/view/select_photo_options_screen.dart';
import '../model/user_model.dart';
import '../utils/widgets/custom_button.dart';
import '../utils/widgets/custom_textformfield.dart';
import '../view_model/auth_provider.dart';
import 'home_screen.dart';

class UserInfromationScreen extends StatefulWidget {
  const UserInfromationScreen({super.key});

  @override
  State<UserInfromationScreen> createState() => _UserInfromationScreenState();
}

class _UserInfromationScreenState extends State<UserInfromationScreen> {

  final nameController = TextEditingController();
  final emailController = TextEditingController();

  Future _pickImage(ImageSource source) async {
    final auth_provider = Provider.of<AuthProvider>(context, listen: false);
    try {
      final image = await ImagePicker().pickImage(source: source);

      final imageTemporary = File(image!.path);

      //auth_provider.setImagetemp(imageTemporary);
      Navigator.of(context).pop();
    } on Exception catch (e) {
      print(e);
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
    nameController.dispose();
    emailController.dispose();
  }


  final GlobalKey<FormState> _form_key_userinfo = GlobalKey();
  @override
  Widget build(BuildContext context) {
    final isLoading =
        Provider.of<AuthProvider>(context, listen: true).isLoading;
    final auth_provider = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      body: SafeArea(
        child: isLoading == true
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.purple,
                ),
              )
            : SingleChildScrollView(
                child: Center(
                  child: Padding(
                    padding:EdgeInsets.symmetric(vertical: 25, horizontal: 30),
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
                        const Text(
                          "Enter Your Details",
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
                                    child: //auth_provider.temp_image == null
                                        true ? Column(
                                      children: const [
                                        SizedBox(height: 6,),
                                         CircleAvatar(
                                          backgroundColor: Colors.purple,
                                          radius: 50,
                                          child: Icon(
                                            Icons.account_circle,
                                            size: 50,
                                            color: Colors.white,
                                          ),
                                        ),
                                        SizedBox(height: 8,),
                                        Text(
                                          "Upload Profile Photo",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight:
                                              FontWeight.bold),
                                        ),
                                      ],
                                    )
                                        : CircleAvatar(
                                      //backgroundImage: FileImage(auth_provider.temp_image),
                                      radius: 80,
                                    ),
                                  )
                              ),
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
                                  labelValue: "Name",
                                  hintValue: "Enter Name",
                                  onchanged: (value) {
                                  },
                                  prefixicon: const Icon(
                                    Icons.drive_file_rename_outline,
                                    color: Colors.black,
                                  ),
                                  controller: nameController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Name Field is Required";
                                    }
                                  },
                                ),
                                SizedBox(height: 15,),
                                CustomTextFormField().getCustomEditTextArea(
                                  labelValue: "Email",
                                  hintValue: "Enter Email",
                                  onchanged: (value) {
                                  },
                                  prefixicon: const Icon(
                                    Icons.email_outlined,
                                    color: Colors.black,
                                  ),
                                  keyboardType: TextInputType.emailAddress,
                                  controller: emailController,
                                  validator: (value) {
                                    String regex_pattern =
                                        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                    RegExp regex = new RegExp(regex_pattern);
                                    if (value!.isEmpty) {
                                      return "Email Field is Required";
                                    }else if(!regex.hasMatch(value)){
                                      return "enter valid email";
                                    }
                                  },
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
                            child: Text("Save", style: TextStyle(fontSize: 16),),
                            onPressed: () {
                        if (_form_key_userinfo.currentState!.validate()) {
                          storeData();
                        }
                            }
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }



  // store user data to database
  void storeData() async {
    final auth_provider = Provider.of<AuthProvider>(context, listen: false);
    UserModel userModel = UserModel(
      name: nameController.text.trim(),
      email: emailController.text.trim(),
      profilePic: "",
      createdAt: "",
      phoneNumber: "",
      uid: "",
      customerReview: "",
      customerRating: ""
    );
    // if (auth_provider.temp_image != null) {
    //   auth_provider.saveUserDataToFirebase(
    //     context: context,
    //     userModel: userModel,
    //     profilePic: auth_provider.temp_image,
    //     onSuccess: () {
    //       auth_provider.saveUserDataToSP().then(
    //             (value) => auth_provider.setSignIn().then(
    //                   (value) => Navigator.pushAndRemoveUntil(
    //                       context,
    //                       MaterialPageRoute(
    //                         builder: (context) => const HomeScreen(),
    //                       ),
    //                       (route) => false),
    //                 ),
    //           );
    //     },
    //   );
    // } else {
    //   showsnackbar(context, "Please upload your profile photo");
    // }
  }
}
