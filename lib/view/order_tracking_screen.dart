import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:table_menu_customer/utils/responsive.dart';
import 'package:table_menu_customer/utils/routes/routes_name.dart';

import '../utils/assets/assets_utils.dart';
import '../utils/font/text_style.dart';
import '../utils/widgets/custom_button.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Track Order',
              style: textSmallRegularStyle,
            ),
            Text(
              'Status',
              style: smallTitleTextStyle.copyWith(color: Colors.green),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0.0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.popAndPushNamed(context, RoutesName.HOME_SCREEN_ROUTE);
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: wp(2, context), vertical: hp(2, context)),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                SizedBox(
                  width: wp(100, context),
                  height: hp(41, context),
                  child: Card(
                    child: Column(
                      children: [
                        Text(
                          "Your order will be ready in ",
                          style: titleTextStyle,
                        ),
                        SizedBox(
                          height: hp(2, context),
                        ),
                        Text(
                          "10 minutes",
                          style: textBodyStyle.copyWith(color: Colors.amber),
                        ),
                        Lottie.asset(
                          AssetsUtils.ASSETS_FOOD_PREPARING_ANIMATION,
                          width: wp(55, context),
                          height: hp(30, context),
                          fit: BoxFit.cover,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: wp(100, context),
                  child: Card(
                    child: Column(
                      children: [
                      Theme(
                        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                        child: ExpansionTile(title: Text("Order list and prices",style: textRegularStyle,),
                          backgroundColor: Colors.transparent,
                          maintainState: true,
                          children: <Widget>[
                            ListView.builder(
                              itemCount: 5,
                              shrinkWrap: true,
                              itemBuilder: (context,index){
                                return Container(
                                  padding: EdgeInsets.symmetric(horizontal: wp(2, context),vertical: hp(1, context)),
                                  decoration: const BoxDecoration(
                                    color: Colors.transparent,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      CachedNetworkImage(
                                        fit: BoxFit.fill,
                                        imageUrl: "",
                                        imageBuilder: (context, imageProvider) => Container(
                                          width: wp(3, context),
                                          height: hp(3, context),
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
                                              child: const Icon(Icons.person_outline,color: Colors.purple,size: 25,));
                                        },
                                      ),
                                      Text("menu Item 1",style: textBodyStyle,),
                                      Text("2x",style: textBodyStyle.copyWith(color: Colors.grey),),
                                      Text("₹ 100",style: textRegularStyle),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                        SizedBox(height: hp(2, context),),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.add,color: Colors.purple.shade400,),
                            GestureDetector(
                              onTap: () {
                                Navigator.popAndPushNamed(context, RoutesName.HOME_SCREEN_ROUTE);
                              },
                              child: Text(
                                "Add more food items to order",
                                style: textRegularStyle.copyWith(
                                    color: Colors.purple.shade300
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: hp(3, context),),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: wp(2, context),vertical: hp(1, context)),
                          child: Column(
                            children: [
                              const Divider(),
                              Row(
                                children: [
                                  Text("Item total ",style: textRegularStyle.copyWith(
                                      color: Colors.grey
                                  ),),
                                  const Spacer(),
                                  Text("₹ 1000",style: textBodyStyle.copyWith(color: Colors.black),),
                                ],
                              ),
                              SizedBox(height: hp(1, context),),
                              Row(
                                children: [
                                  Text("Tax",style: textRegularStyle.copyWith(
                                      color: Colors.grey
                                  ),),
                                  const Spacer(),
                                  Text("₹ 50",style: textBodyStyle.copyWith(color: Colors.black),),
                                ],
                              ),
                              SizedBox(height: hp(1, context),),
                              const Divider(),
                              SizedBox(height: hp(1, context),),
                              Row(
                                children: [
                                  Text("Total price", style: textRegularStyle.copyWith(
                                      color: Colors.grey
                                  ),),
                                  const Spacer(),
                                  Text("₹ 1050",style: textBodyStyle.copyWith(color: Colors.black),),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Hero(
        tag: "checkout",
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: wp(1.5, context),vertical: hp(1.5, context)),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: hp(7.5, context),
            child: CustomButton(
                onPressed: () async {
                  Navigator.pushNamed(context, RoutesName.CHECKOUT_SCREEN_ROUTE);
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Check out", style: textBodyStyle.copyWith(
                        color: Colors.white
                    ),),
                    const Spacer(),
                    Text("₹ 1050",style: textBodyStyle.copyWith(color: Colors.white),),
                  ],
                )
            ),
          ),
        ),
      ),
    );
  }
}