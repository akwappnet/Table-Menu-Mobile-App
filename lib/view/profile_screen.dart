import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_menu_customer/repository/user_info_repository.dart';
import 'package:table_menu_customer/utils/responsive.dart';
import 'package:table_menu_customer/utils/widgets/custom_button.dart';
import 'package:table_menu_customer/utils/widgets/custom_text.dart';
import 'package:table_menu_customer/view/login_screen.dart';
import 'package:table_menu_customer/view/user_information_screen.dart';

import '../model/user_model.dart';
import '../res/services/api_endpoints.dart';
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
      Provider.of<AuthProvider>(context, listen: false).getUserInfo();
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
          SharedPreferences preferences = await SharedPreferences
              .getInstance();
          await preferences.remove('token');
          auth_provider.deleteUserInfo(context);
          break;
        case 'Exit':
          exit(0);
          break;
      }
    }
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Profile"),
        actions: <Widget>[
          PopupMenuButton<String>(
            icon: Icon(Icons.menu),
            onSelected: handleClick,
            itemBuilder: (BuildContext context) {
              return {'Delete Account', 'Exit'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Row(
                    children: [
                      Icon(choice == "Delete Account" ? Icons.delete : Icons.exit_to_app),
                      CustomText(text: choice,size: 16,weight: FontWeight.w400,),
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
              stream: auth_provider.getUserInfo().asStream(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var userData = snapshot.data?.userData;
                  uid = userData!.id;
                  String image_url = userData!.profilePhotoUrl! == null
                      ? ""
                      : ApiEndPoint
                      .baseImageUrl + userData!.profilePhotoUrl!;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CachedNetworkImage(
                        fit: BoxFit.fill,
                        imageUrl: image_url,
                        imageBuilder: (context, imageProvider) =>
                            Container(
                              width: 100.0,
                              height: 100.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: imageProvider, fit: BoxFit.cover),
                              ),
                            ),
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) =>
                            Center(
                              child: CircularProgressIndicator(),
                            ),
                        errorWidget: (context, url, error) {
                          return Container();
                        },
                      ),
                      const SizedBox(height: 20),

                      CustomText(text: userData.name!, size: 22,
                        weight: FontWeight.bold,),

                      SizedBox(height: 8,),

                      CustomText(text: userData.phoneNumber!, size: 18,
                        weight: FontWeight.w400,),
                      SizedBox(height: 8,),
                      CustomText(text: userData.email!, size: 18,
                        weight: FontWeight.w400,),
                      SizedBox(height: 8,),
                      SizedBox(
                        height: 50,
                        width: wp(80, context),
                        child: CustomButton(
                          child: CustomText(text: "Update Profile", size: 18, color: Colors.white,),
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => UserInfoScreen(userData),));
                          },),
                      ),
                      SizedBox(height: 8,),
                      SizedBox(
                        height: 50,
                        width: wp(80, context),
                        child: CustomButton(
                          child: CustomText(text: "Logout", size: 18, color: Colors.white,),
                          onPressed: () async {
                            SharedPreferences preferences = await SharedPreferences
                                .getInstance();
                            await preferences.remove('token');
                            Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen(),));
                          },),
                      )
                    ],
                  );
                } else {
                  return Center(child: CircularProgressIndicator(),);
                }
              }
          )),
    );
  }
}