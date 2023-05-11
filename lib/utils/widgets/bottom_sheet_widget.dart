import 'package:flutter/material.dart';
import 'package:table_menu_customer/model/menuItem_model.dart';
import 'package:table_menu_customer/res/services/api_endpoints.dart';
import 'package:table_menu_customer/utils/responsive.dart';

import 'custom_button.dart';
import 'custom_text.dart';

class CustomBottomSheet {

  static void  showCustomModalBottomSheet(
  {
    required BuildContext context,
    required VoidCallback onPressed,
    required MenuData menuData}
      ){
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context){
          return Container(
            margin: EdgeInsets.all(8.0),
            child: ListView(
              shrinkWrap: true,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.network(ApiEndPoint.baseImageUrl + menuData.image!,height: hp(30, context),width: wp(60, context),),
                  ],
                ),
                Row(
                  children: [
                    CustomText(
                      text: menuData.name!,
                      size: 22,
                      color: Colors.black,
                      weight: FontWeight.bold,
                    ),
                    (menuData.isVeg! == true) ? Image.asset("assets/images/veg-icon.png", height: 50,width: 50,) :
                    Image.asset("assets/images/non-veg-icon.png", height: 50,width: 50,)
                  ],
                ),
                CustomText(
                  text: menuData.ingredients!,
                  size: 16,
                  color: Colors.black,
                ),
                CustomText(
                  text: menuData.description!,
                  size: 18,
                  color: Colors.black,
                  weight: FontWeight.bold,
                ),
                CustomText(
                  text: menuData.price!,
                  size: 20,
                  color: Colors.black,
                ),
                CustomText(
                  text: menuData.name!,
                  size: 22,
                  color: Colors.black,
                  weight: FontWeight.bold,
                ),
                (menuData.isNew! == true) ? const CustomText(
                  text: "new",
                  size: 22,
                  color: Colors.black,
                  weight: FontWeight.bold,
                ) : Container(),
                (menuData.isJain! == true) ? const CustomText(
                  text: "jain",
                  size: 22,
                  color: Colors.black,
                  weight: FontWeight.bold,
                ): Container(),
                (menuData.isSpecial == true) ? const CustomText(
                  text: "special",
                  size: 22,
                  color: Colors.black,
                  weight: FontWeight.bold,
                ) : Container(),
                (menuData.isSweet == true) ? const CustomText(
                  text: "sweet",
                  size: 22,
                  color: Colors.black,
                  weight: FontWeight.bold,
                ): Container(),
                (menuData.isSpicy == true) ? const CustomText(
                  text: "spicy",
                  size: 22,
                  color: Colors.black,
                  weight: FontWeight.bold,
                ): Container(),
                (menuData.isPopular == true) ? const CustomText(
                  text: "popular",
                  size: 22,
                  color: Colors.black,
                  weight: FontWeight.bold,
                ): Container(),
                CustomButton(
                  onPressed: onPressed, child: CustomText(
                  text: "Add to Cart",
                  color: Colors.white,
                ),
                ),
              ],
            ),
          );
        }
    );
  }
}