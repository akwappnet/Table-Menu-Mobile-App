import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_menu_customer/model/custom_result_model.dart';
import 'package:table_menu_customer/utils/assets/assets_utils.dart';
import 'package:table_menu_customer/utils/responsive.dart';
import 'package:table_menu_customer/utils/routes/routes_name.dart';
import 'package:table_menu_customer/utils/widgets/custom_button.dart';
import 'package:table_menu_customer/utils/widgets/custom_flushbar_widget.dart';
import 'package:table_menu_customer/utils/widgets/custom_text.dart';

import '../model/user_model.dart';
import '../res/services/api_endpoints.dart';
import '../utils/widgets/custom_confirmation_dialog.dart';
import '../view_model/auth_provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      Provider.of<AuthProvider>(context, listen: false).getUserInfo(context);
    });
    super.initState();
  }

  int? uid;

  @override
  Widget build(BuildContext context) {
    final auth_provider = Provider.of<AuthProvider>(context, listen: false);
    Future<void> handleClick(String value) async {
      switch (value) {
        case 'Delete Account':
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return CustomConfirmationDialog(
                title: 'Delete Account',
                message: 'Are you sure you want to Delete Your Account ?',
                onConfirm: () async {
                  CustomResultModel? result = await auth_provider.deleteUserInfo(context);

                  if(result!.status){
                    CustomFlushbar.showSuccess(context, result.message);
                    Navigator.popAndPushNamed(context, RoutesName.LOGIN_SCREEN_ROUTE);
                  }else {
                    CustomFlushbar.showError(context, result.message);
                  }
                },
              );
            },
          );
          break;
        case 'Exit':
          exit(0);
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: const Text("Profile"),
        centerTitle: true,
        actions: <Widget>[
          PopupMenuButton<String>(
            icon: const Icon(Icons.menu),
            onSelected: handleClick,
            itemBuilder: (BuildContext context) {
              return {'Delete Account', 'Exit'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Row(
                    children: [
                      Icon(choice == "Delete Account"
                          ? Icons.delete
                          : Icons.exit_to_app),
                      CustomText(
                        text: choice,
                        size: 16,
                        weight: FontWeight.w400,
                      ),
                    ],
                  ),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: Center(
          child: StreamBuilder<UserModel>(
              stream: auth_provider.getUserInfo(context).asStream(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var userData = snapshot.data?.userData;
                  uid = userData!.id;
                  String image_url = ApiEndPoint.baseImageUrl + userData.profilePhotoUrl!;
                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CachedNetworkImage(
                          fit: BoxFit.fill,
                          imageUrl: image_url,
                          imageBuilder: (context, imageProvider) => Container(
                            width: 100.0,
                            height: 100.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: imageProvider, fit: BoxFit.cover),
                            ),
                          ),
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) => const Center(
                            child: CircularProgressIndicator(),
                          ),
                          errorWidget: (context, url, error) {
                            return Container(
                                padding: const EdgeInsets.all(8.0),
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(50),
                                  color: Colors.purple.shade200,),
                                child: const Icon(Icons.person_outline,color: Colors.purple,size: 60,));
                          },
                        ),
                        const SizedBox(height: 20),
                        CustomText(
                          text: userData.name!,
                          size: 22,
                          weight: FontWeight.bold,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        CustomText(
                          text: userData.phoneNumber!,
                          size: 18,
                          weight: FontWeight.w400,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        CustomText(
                          text: userData.email!,
                          size: 18,
                          weight: FontWeight.w400,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        SizedBox(
                          height: 50,
                          width: wp(80, context),
                          child: CustomButton(
                            child: const CustomText(
                              text: "Update Profile",
                              size: 18,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, RoutesName.USER_INFO_SCREEN_ROUTE,
                                  arguments: userData);
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        SizedBox(
                          height: 50,
                          width: wp(80, context),
                          child: CustomButton(
                            child: const CustomText(
                              text: "Logout",
                              size: 18,
                              color: Colors.white,
                            ),
                            onPressed: () async {
                              auth_provider.forceLogout(context);
                            },
                          ),
                        )
                      ],
                    ),
                  );
                } else {
                  return Center(
                    child: Lottie.asset(
                      AssetsUtils.ASSETS_LOADING_PURPLE_ANIMATION,
                      width: 100,
                      height: 100,
                      fit: BoxFit.fill,
                    ),
                  );
                }
              })),
    );
  }
}
