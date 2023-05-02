import 'package:flutter/material.dart';
import 'package:table_menu_customer/utils/responsive.dart';

import 'custom_button.dart';
import 'custom_text.dart';

class CustomBottomSheet {

  static void  showCustomModalBottomSheet(
  {
    required BuildContext context,
    required VoidCallback onPressed,
    required String image_url,
    required String menu_item_name,
    required String menu_item_ingredients,
    required String menu_item_description,
    required String menu_item_price,
    required bool isVeg,
    required bool isNew,
    required bool isSpicy,
    required bool isJain,
    required bool isSpecial,
    required bool isSweet,
    required bool isPopular}
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
                    Image.network(image_url,height: hp(30, context),width: wp(60, context),),
                  ],
                ),
                Row(
                  children: [
                    CustomText(
                      text: menu_item_name,
                      size: 22,
                      color: Colors.black,
                      weight: FontWeight.bold,
                    ),
                    (isVeg == true) ? Image.asset("assets/images/veg-icon.png", height: 50,width: 50,) :
                    Image.asset("assets/images/non-veg-icon.png", height: 50,width: 50,)
                  ],
                ),
                CustomText(
                  text: menu_item_ingredients,
                  size: 16,
                  color: Colors.black,
                ),
                CustomText(
                  text: menu_item_description,
                  size: 18,
                  color: Colors.black,
                  weight: FontWeight.bold,
                ),
                CustomText(
                  text: menu_item_price,
                  size: 20,
                  color: Colors.black,
                ),
                CustomText(
                  text: menu_item_name,
                  size: 22,
                  color: Colors.black,
                  weight: FontWeight.bold,
                ),
                (isNew == true) ? const CustomText(
                  text: "new",
                  size: 22,
                  color: Colors.black,
                  weight: FontWeight.bold,
                ) : Container(),
                (isJain == true) ? const CustomText(
                  text: "jain",
                  size: 22,
                  color: Colors.black,
                  weight: FontWeight.bold,
                ): Container(),
                (isSpecial == true) ? const CustomText(
                  text: "special",
                  size: 22,
                  color: Colors.black,
                  weight: FontWeight.bold,
                ) : Container(),
                (isSweet == true) ? const CustomText(
                  text: "sweet",
                  size: 22,
                  color: Colors.black,
                  weight: FontWeight.bold,
                ): Container(),
                (isSpicy == true) ? const CustomText(
                  text: "spicy",
                  size: 22,
                  color: Colors.black,
                  weight: FontWeight.bold,
                ): Container(),
                (isPopular == true) ? const CustomText(
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