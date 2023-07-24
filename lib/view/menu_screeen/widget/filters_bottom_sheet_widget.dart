import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_menu_customer/utils/font/text_style.dart';
import 'package:table_menu_customer/view_model/menu_provider.dart';

import '../../../utils/constants/constants_text.dart';
import '../../../utils/responsive.dart';
import '../../../utils/widgets/custom_button.dart';
import 'filter_list_item_widget.dart';
import 'filter_rating_item_widget.dart';

filtersBottomSheet(context) {
  showModalBottomSheet(
    useRootNavigator: true,
    enableDrag: true,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    isDismissible: true,
    context: context,
    builder: (BuildContext context) {
      return Consumer<MenuProvider>(
        builder: (context, menu_provider, __) {
          return Wrap(
            children: [
              Container(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(BORDER_RADIUS),
                    topRight: Radius.circular(BORDER_RADIUS),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: wp(2, context), vertical: hp(2, context)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Filters",
                            style: smallTitleTextStyle,
                          ),
                          const Spacer(),
                          IconButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              icon: const Icon(
                                Icons.close,
                                color: Colors.black,
                              )),
                        ],
                      ),
                      SizedBox(
                        height: hp(3, context),
                      ),
                      Text("Select product type", style: textBodyStyle),
                      Wrap(
                        children: [
                          FilterItemWidget(
                            onTap: () {
                              menu_provider.toggleNewFilter();
                            },
                            borderColor: menu_provider.filterOptions.isNew
                                ? Colors.purple
                                : Colors.black,
                            itemText: 'New',
                            containerColor: menu_provider.filterOptions.isNew
                                ? Colors.purple
                                : Colors.transparent,
                            textColor: menu_provider.filterOptions.isNew
                                ? Colors.white
                                : Colors.black,
                          ),
                          FilterItemWidget(
                            onTap: () {
                              menu_provider.togglePopularFilter();
                            },
                            borderColor: menu_provider.filterOptions.isPopular
                                ? Colors.purple
                                : Colors.black,
                            itemText: 'Popular',
                            containerColor: menu_provider.filterOptions.isPopular
                                ? Colors.purple
                                : Colors.transparent,
                            textColor: menu_provider.filterOptions.isPopular
                                ? Colors.white
                                : Colors.black,
                          ),
                          FilterItemWidget(
                            onTap: () {
                              menu_provider.toggleSpecialFilter();
                            },
                            borderColor: menu_provider.filterOptions.isSpecial
                                ? Colors.purple
                                : Colors.black,
                            itemText: 'Special',
                            containerColor: menu_provider.filterOptions.isSpecial
                                ? Colors.purple
                                : Colors.transparent,
                            textColor: menu_provider.filterOptions.isSpecial
                                ? Colors.white
                                : Colors.black,
                          ),
                          FilterItemWidget(
                            onTap: () {
                              menu_provider.toggleVegFilter();
                            },
                            borderColor: menu_provider.filterOptions.isVeg
                                ? Colors.purple
                                : Colors.black,
                            itemText: 'Veg',
                            containerColor: menu_provider.filterOptions.isVeg
                                ? Colors.purple
                                : Colors.transparent,
                            textColor: menu_provider.filterOptions.isVeg
                                ? Colors.white
                                : Colors.black,
                          ),
                          FilterItemWidget(
                            onTap: () {
                              menu_provider.toggleNonVegFilter();
                            },
                            borderColor: menu_provider.filterOptions.isNonVeg
                                ? Colors.purple
                                : Colors.black,
                            itemText: 'Non Veg',
                            containerColor: menu_provider.filterOptions.isNonVeg
                                ? Colors.purple
                                : Colors.transparent,
                            textColor: menu_provider.filterOptions.isNonVeg
                                ? Colors.white
                                : Colors.black,
                          ),
                          FilterItemWidget(
                            onTap: () {
                              menu_provider.toggleSweetFilter();
                            },
                            borderColor: menu_provider.filterOptions.isSweet
                                ? Colors.purple
                                : Colors.black,
                            itemText: 'sweet',
                            containerColor: menu_provider.filterOptions.isSweet
                                ? Colors.purple
                                : Colors.transparent,
                            textColor: menu_provider.filterOptions.isSweet
                                ? Colors.white
                                : Colors.black,
                          ),
                          FilterItemWidget(
                            onTap: () {
                              menu_provider.toggleSpicyFilter();
                            },
                            borderColor: menu_provider.filterOptions.isSpicy
                                ? Colors.purple
                                : Colors.black,
                            itemText: 'Spicy',
                            containerColor: menu_provider.filterOptions.isSpicy
                                ? Colors.purple
                                : Colors.transparent,
                            textColor: menu_provider.filterOptions.isSpicy
                                ? Colors.white
                                : Colors.black,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: hp(2, context),
                      ),
                      Text("Rating", style: textBodyStyle),
                      Wrap(
                        children: [
                          FilterRatingItemWidget(
                            onTap: () {
                              menu_provider.toggleRatingFilter(1);
                            },
                            borderColor: menu_provider.filterOptions.selectedRatings[0]
                                ? Colors.purple
                                : Colors.black,
                            itemText: '1',
                            containerColor: menu_provider.filterOptions.selectedRatings[0]
                                ? Colors.purple
                                : Colors.transparent,
                            textColor: menu_provider.filterOptions.selectedRatings[0]
                                ? Colors.white
                                : Colors.black,
                          ),
                          FilterRatingItemWidget(
                            onTap: () {
                              menu_provider.toggleRatingFilter(2);
                            },
                            borderColor: menu_provider.filterOptions.selectedRatings[1]
                                ? Colors.purple
                                : Colors.black,
                            itemText: '2',
                            containerColor: menu_provider.filterOptions.selectedRatings[1]
                                ? Colors.purple
                                : Colors.transparent,
                            textColor: menu_provider.filterOptions.selectedRatings[1]
                                ? Colors.white
                                : Colors.black,
                          ),
                          FilterRatingItemWidget(
                            onTap: () {
                              menu_provider.toggleRatingFilter(3);
                            },
                            borderColor: menu_provider.filterOptions.selectedRatings[2]
                                ? Colors.purple
                                : Colors.black,
                            itemText: '3',
                            containerColor: menu_provider.filterOptions.selectedRatings[2]
                                ? Colors.purple
                                : Colors.transparent,
                            textColor: menu_provider.filterOptions.selectedRatings[2]
                                ? Colors.white
                                : Colors.black,
                          ),
                          FilterRatingItemWidget(
                            onTap: () {
                              menu_provider.toggleRatingFilter(4);
                            },
                            borderColor: menu_provider.filterOptions.selectedRatings[3]
                                ? Colors.purple
                                : Colors.black,
                            itemText: '4',
                            containerColor: menu_provider.filterOptions.selectedRatings[3]
                                ? Colors.purple
                                : Colors.transparent,
                            textColor: menu_provider.filterOptions.selectedRatings[3]
                                ? Colors.white
                                : Colors.black,
                          ),
                          FilterRatingItemWidget(
                            onTap: () {
                              menu_provider.toggleRatingFilter(5);
                            },
                            borderColor: menu_provider.filterOptions.selectedRatings[4]
                                ? Colors.purple
                                : Colors.black,
                            itemText: '5',
                            containerColor: menu_provider.filterOptions.selectedRatings[4]
                                ? Colors.purple
                                : Colors.transparent,
                            textColor: menu_provider.filterOptions.selectedRatings[4]
                                ? Colors.white
                                : Colors.black,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: hp(2, context),
                      ),
                      Text("Price Sort", style: textBodyStyle),
                      Wrap(
                        children: [
                          FilterItemWidget(
                            onTap: () {
                              if(menu_provider.filterOptions.sortByPriceHighToLow){
                                menu_provider.toggleSortByPriceHighToLow();
                                menu_provider.toggleSortByPriceLowToHigh();
                              }else {
                                menu_provider.toggleSortByPriceLowToHigh();
                              }
                            },
                            borderColor: menu_provider.filterOptions.sortByPriceLowToHigh
                                ? Colors.purple
                                : Colors.black,
                            itemText: 'Low - High',
                            containerColor: menu_provider.filterOptions.sortByPriceLowToHigh
                                ? Colors.purple
                                : Colors.transparent,
                            textColor: menu_provider.filterOptions.sortByPriceLowToHigh
                                ? Colors.white
                                : Colors.black,
                          ),
                          FilterItemWidget(
                            onTap: () {
                              if(menu_provider.filterOptions.sortByPriceLowToHigh){
                                menu_provider.toggleSortByPriceLowToHigh();
                                menu_provider.toggleSortByPriceHighToLow();
                              }else {
                                menu_provider.toggleSortByPriceHighToLow();
                              }
                            },
                            borderColor: menu_provider.filterOptions.sortByPriceHighToLow
                                ? Colors.purple
                                : Colors.black,
                            itemText: 'High - Low',
                            containerColor: menu_provider.filterOptions.sortByPriceHighToLow
                                ? Colors.purple
                                : Colors.transparent,
                            textColor: menu_provider.filterOptions.sortByPriceHighToLow
                                ? Colors.white
                                : Colors.black,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: hp(2, context),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: hp(7.5, context),
                        child: CustomButton(
                          onPressed: () {
                            menu_provider.selectCategory(-1);
                            menu_provider.setCategoryName("", context);
                            menu_provider.applyFilters();
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            "Apply filters",
                            style: textBodyStyle.copyWith(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: hp(2, context),
              ),
            ],
          );
        },
      );
    },
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(BORDER_RADIUS),
        topRight: Radius.circular(BORDER_RADIUS),
      ),
    ),
  );
}
