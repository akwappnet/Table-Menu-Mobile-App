import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_menu_customer/utils/font/text_style.dart';
import 'package:table_menu_customer/utils/widgets/custom_outlined_button.dart';
import 'package:table_menu_customer/view_model/menu_provider.dart';

import '../../../app_localizations.dart';
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
        builder: (context, menuProvider, __) {
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
                            AppLocalizations.of(context).translate('filters'),
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
                      Text(
                          AppLocalizations.of(context)
                              .translate('select_product_type'),
                          style: textBodyStyle),
                      Wrap(
                        children: [
                          FilterItemWidget(
                            onTap: () {
                              menuProvider.toggleNewFilter();
                            },
                            borderColor: menuProvider.filterOptions.isNew
                                ? Colors.purple
                                : Colors.black,
                            itemText:
                                AppLocalizations.of(context).translate('new'),
                            containerColor: menuProvider.filterOptions.isNew
                                ? Colors.purple
                                : Colors.transparent,
                            textColor: menuProvider.filterOptions.isNew
                                ? Colors.white
                                : Colors.black,
                          ),
                          FilterItemWidget(
                            onTap: () {
                              menuProvider.togglePopularFilter();
                            },
                            borderColor: menuProvider.filterOptions.isPopular
                                ? Colors.purple
                                : Colors.black,
                            itemText: AppLocalizations.of(context)
                                .translate('popular'),
                            containerColor: menuProvider.filterOptions.isPopular
                                ? Colors.purple
                                : Colors.transparent,
                            textColor: menuProvider.filterOptions.isPopular
                                ? Colors.white
                                : Colors.black,
                          ),
                          FilterItemWidget(
                            onTap: () {
                              menuProvider.toggleSpecialFilter();
                            },
                            borderColor: menuProvider.filterOptions.isSpecial
                                ? Colors.purple
                                : Colors.black,
                            itemText: AppLocalizations.of(context)
                                .translate('special'),
                            containerColor: menuProvider.filterOptions.isSpecial
                                ? Colors.purple
                                : Colors.transparent,
                            textColor: menuProvider.filterOptions.isSpecial
                                ? Colors.white
                                : Colors.black,
                          ),
                          FilterItemWidget(
                            onTap: () {
                              menuProvider.toggleVegFilter();
                            },
                            borderColor: menuProvider.filterOptions.isVeg
                                ? Colors.purple
                                : Colors.black,
                            itemText:
                                AppLocalizations.of(context).translate('veg'),
                            containerColor: menuProvider.filterOptions.isVeg
                                ? Colors.purple
                                : Colors.transparent,
                            textColor: menuProvider.filterOptions.isVeg
                                ? Colors.white
                                : Colors.black,
                          ),
                          FilterItemWidget(
                            onTap: () {
                              menuProvider.toggleNonVegFilter();
                            },
                            borderColor: menuProvider.filterOptions.isNonVeg
                                ? Colors.purple
                                : Colors.black,
                            itemText: AppLocalizations.of(context)
                                .translate('non_veg'),
                            containerColor: menuProvider.filterOptions.isNonVeg
                                ? Colors.purple
                                : Colors.transparent,
                            textColor: menuProvider.filterOptions.isNonVeg
                                ? Colors.white
                                : Colors.black,
                          ),
                          FilterItemWidget(
                            onTap: () {
                              menuProvider.toggleSweetFilter();
                            },
                            borderColor: menuProvider.filterOptions.isSweet
                                ? Colors.purple
                                : Colors.black,
                            itemText:
                                AppLocalizations.of(context).translate('sweet'),
                            containerColor: menuProvider.filterOptions.isSweet
                                ? Colors.purple
                                : Colors.transparent,
                            textColor: menuProvider.filterOptions.isSweet
                                ? Colors.white
                                : Colors.black,
                          ),
                          FilterItemWidget(
                            onTap: () {
                              menuProvider.toggleSpicyFilter();
                            },
                            borderColor: menuProvider.filterOptions.isSpicy
                                ? Colors.purple
                                : Colors.black,
                            itemText:
                                AppLocalizations.of(context).translate('spicy'),
                            containerColor: menuProvider.filterOptions.isSpicy
                                ? Colors.purple
                                : Colors.transparent,
                            textColor: menuProvider.filterOptions.isSpicy
                                ? Colors.white
                                : Colors.black,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: hp(2, context),
                      ),
                      Text(AppLocalizations.of(context).translate('rating'),
                          style: textBodyStyle),
                      Wrap(
                        children: [
                          FilterRatingItemWidget(
                            onTap: () {
                              menuProvider.toggleRatingFilter(1);
                            },
                            borderColor:
                                menuProvider.filterOptions.selectedRatings[0]
                                    ? Colors.purple
                                    : Colors.black,
                            itemText: '1',
                            containerColor:
                                menuProvider.filterOptions.selectedRatings[0]
                                    ? Colors.purple
                                    : Colors.transparent,
                            textColor:
                                menuProvider.filterOptions.selectedRatings[0]
                                    ? Colors.white
                                    : Colors.black,
                          ),
                          FilterRatingItemWidget(
                            onTap: () {
                              menuProvider.toggleRatingFilter(2);
                            },
                            borderColor:
                                menuProvider.filterOptions.selectedRatings[1]
                                    ? Colors.purple
                                    : Colors.black,
                            itemText: '2',
                            containerColor:
                                menuProvider.filterOptions.selectedRatings[1]
                                    ? Colors.purple
                                    : Colors.transparent,
                            textColor:
                                menuProvider.filterOptions.selectedRatings[1]
                                    ? Colors.white
                                    : Colors.black,
                          ),
                          FilterRatingItemWidget(
                            onTap: () {
                              menuProvider.toggleRatingFilter(3);
                            },
                            borderColor:
                                menuProvider.filterOptions.selectedRatings[2]
                                    ? Colors.purple
                                    : Colors.black,
                            itemText: '3',
                            containerColor:
                                menuProvider.filterOptions.selectedRatings[2]
                                    ? Colors.purple
                                    : Colors.transparent,
                            textColor:
                                menuProvider.filterOptions.selectedRatings[2]
                                    ? Colors.white
                                    : Colors.black,
                          ),
                          FilterRatingItemWidget(
                            onTap: () {
                              menuProvider.toggleRatingFilter(4);
                            },
                            borderColor:
                                menuProvider.filterOptions.selectedRatings[3]
                                    ? Colors.purple
                                    : Colors.black,
                            itemText: '4',
                            containerColor:
                                menuProvider.filterOptions.selectedRatings[3]
                                    ? Colors.purple
                                    : Colors.transparent,
                            textColor:
                                menuProvider.filterOptions.selectedRatings[3]
                                    ? Colors.white
                                    : Colors.black,
                          ),
                          FilterRatingItemWidget(
                            onTap: () {
                              menuProvider.toggleRatingFilter(5);
                            },
                            borderColor:
                                menuProvider.filterOptions.selectedRatings[4]
                                    ? Colors.purple
                                    : Colors.black,
                            itemText: '5',
                            containerColor:
                                menuProvider.filterOptions.selectedRatings[4]
                                    ? Colors.purple
                                    : Colors.transparent,
                            textColor:
                                menuProvider.filterOptions.selectedRatings[4]
                                    ? Colors.white
                                    : Colors.black,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: hp(2, context),
                      ),
                      Text(AppLocalizations.of(context).translate('price_sort'),
                          style: textBodyStyle),
                      Wrap(
                        children: [
                          FilterItemWidget(
                            onTap: () {
                              if (menuProvider
                                  .filterOptions.sortByPriceHighToLow) {
                                menuProvider.toggleSortByPriceHighToLow();
                                menuProvider.toggleSortByPriceLowToHigh();
                              } else {
                                menuProvider.toggleSortByPriceLowToHigh();
                              }
                            },
                            borderColor:
                                menuProvider.filterOptions.sortByPriceLowToHigh
                                    ? Colors.purple
                                    : Colors.black,
                            itemText: AppLocalizations.of(context)
                                .translate('low_high'),
                            containerColor:
                                menuProvider.filterOptions.sortByPriceLowToHigh
                                    ? Colors.purple
                                    : Colors.transparent,
                            textColor:
                                menuProvider.filterOptions.sortByPriceLowToHigh
                                    ? Colors.white
                                    : Colors.black,
                          ),
                          FilterItemWidget(
                            onTap: () {
                              if (menuProvider
                                  .filterOptions.sortByPriceLowToHigh) {
                                menuProvider.toggleSortByPriceLowToHigh();
                                menuProvider.toggleSortByPriceHighToLow();
                              } else {
                                menuProvider.toggleSortByPriceHighToLow();
                              }
                            },
                            borderColor:
                                menuProvider.filterOptions.sortByPriceHighToLow
                                    ? Colors.purple
                                    : Colors.black,
                            itemText: AppLocalizations.of(context)
                                .translate('high_low'),
                            containerColor:
                                menuProvider.filterOptions.sortByPriceHighToLow
                                    ? Colors.purple
                                    : Colors.transparent,
                            textColor:
                                menuProvider.filterOptions.sortByPriceHighToLow
                                    ? Colors.white
                                    : Colors.black,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: hp(2, context),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: wp(45, context),
                            height: hp(7.5, context),
                            child: CustomOutlinedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                AppLocalizations.of(context)
                                    .translate('clear_filters'),
                                style: textBodyStyle,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: wp(2, context),
                          ),
                          SizedBox(
                            width: wp(45, context),
                            height: hp(7.5, context),
                            child: CustomButton(
                              onPressed: () {
                                // menu_provider.selectCategory(-1);
                                // menu_provider.setCategoryName("", context);
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                AppLocalizations.of(context)
                                    .translate('apply_filters'),
                                style:
                                    textBodyStyle.copyWith(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
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
