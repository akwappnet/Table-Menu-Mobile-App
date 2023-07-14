import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_menu_customer/utils/font/text_style.dart';
import 'package:table_menu_customer/utils/routes/routes_name.dart';

import '../../utils/constants/api_endpoints.dart';
import '../../utils/responsive.dart';
import '../../view_model/auth_provider.dart';


class SettingsProfileScreen extends StatelessWidget {
  const SettingsProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context,auth_provider,__){
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text("Profile",style: smallTitleTextStyle,),
            backgroundColor: Colors.white,
            actions: [
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: wp(2, context)),
                child: IconButton(onPressed: () {
                  Navigator.pushNamed(context, RoutesName.SETTINGS_SCREEN_ROUTE);
                }, icon: const Icon(Icons.settings)),
              ),
            ],
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: wp(2, context), vertical: hp(2, context)),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                      width: wp(100, context),
                    child: Card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: hp(2, context),),
                          CircleAvatar(
                            radius: 60,
                            child: CachedNetworkImage(
                              fit: BoxFit.fill,
                              imageUrl: ApiEndPoint.baseImageUrl +
                                  auth_provider.userData!.profilePhotoUrl!,
                              imageBuilder: (context, imageProvider) => Container(
                                width: wp(30, context),
                                height: hp(30, context),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: imageProvider, fit: BoxFit.cover),
                                ),
                              ),
                              errorWidget: (context, url, error) {
                                return Container(
                                    padding: const EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: Colors.purple.shade200,
                                    ),
                                    child: const Icon(
                                      Icons.person_outline,
                                      color: Colors.purple,
                                      size: 60,
                                    ));
                              },
                            ),
                          ),
                          SizedBox(height: hp(2, context),),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.perm_identity,color: Colors.black,),
                              SizedBox(width: wp(0.8, context),),
                              Text(auth_provider.user_name,style: textBodyStyle,),
                            ],
                          ),
                          SizedBox(height: hp(2, context),),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.phone,color: Colors.black,),
                              SizedBox(width: wp(0.8, context),),
                              Text(auth_provider.userData!.phoneNumber!,style: textBodyStyle,),
                            ],
                          ),
                          SizedBox(height: hp(2, context),),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.email_outlined,color: Colors.black,),
                              SizedBox(width: wp(0.8, context),),
                              Text(auth_provider.userData!.email!,style: textBodyStyle,),
                            ],
                          ),
                          SizedBox(height: hp(2, context),),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: hp(1.5, context),),
                  GestureDetector(
                    onTap: () {},
                    child: SizedBox(
                      width: wp(100, context),
                      child: Card(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: wp(2, context), vertical: hp(2, context)),
                          child: Row(
                            children: [
                              Text("Favorites Menu Items",style: textBodyStyle,),
                              const Spacer(),
                              const Icon(Icons.arrow_forward_ios,color: Colors.black,),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: hp(1.5, context),),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, RoutesName.USER_INFO_SCREEN_ROUTE,arguments: auth_provider.userData);
                    },
                    child: SizedBox(
                      width: wp(100, context),
                      child: Card(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: wp(2, context), vertical: hp(2, context)),
                          child: Row(
                            children: [
                              Text("Update Profile",style: textBodyStyle,),
                              const Spacer(),
                              const Icon(Icons.arrow_forward_ios,color: Colors.black,),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: hp(1.5, context),),
                  GestureDetector(
                    onTap: () {},
                    child: SizedBox(
                      width: wp(100, context),
                      child: Card(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: wp(2, context), vertical: hp(2, context)),
                          child: Row(
                            children: [
                              Text("Change Password",style: textBodyStyle,),
                              const Spacer(),
                              const Icon(Icons.arrow_forward_ios,color: Colors.black,),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

