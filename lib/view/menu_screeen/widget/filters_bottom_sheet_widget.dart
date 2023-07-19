import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
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
                              menu_provider.toggleBool();
                            },
                            borderColor: menu_provider.toogleBoolean
                                ? Colors.purple
                                : Colors.black,
                            itemText: 'New',
                            containerColor: menu_provider.toogleBoolean
                                ? Colors.purple
                                : Colors.transparent,
                            textColor: menu_provider.toogleBoolean
                                ? Colors.white
                                : Colors.black,
                          ),
                          FilterItemWidget(
                            onTap: () {
                              menu_provider.toggleBool();
                            },
                            borderColor: menu_provider.toogleBoolean
                                ? Colors.purple
                                : Colors.black,
                            itemText: 'Popular',
                            containerColor: menu_provider.toogleBoolean
                                ? Colors.purple
                                : Colors.transparent,
                            textColor: menu_provider.toogleBoolean
                                ? Colors.white
                                : Colors.black,
                          ),
                          FilterItemWidget(
                            onTap: () {
                              menu_provider.toggleBool();
                            },
                            borderColor: menu_provider.toogleBoolean
                                ? Colors.purple
                                : Colors.black,
                            itemText: 'Special',
                            containerColor: menu_provider.toogleBoolean
                                ? Colors.purple
                                : Colors.transparent,
                            textColor: menu_provider.toogleBoolean
                                ? Colors.white
                                : Colors.black,
                          ),
                          FilterItemWidget(
                            onTap: () {
                              menu_provider.toggleBool();
                            },
                            borderColor: menu_provider.toogleBoolean
                                ? Colors.purple
                                : Colors.black,
                            itemText: 'Veg',
                            containerColor: menu_provider.toogleBoolean
                                ? Colors.purple
                                : Colors.transparent,
                            textColor: menu_provider.toogleBoolean
                                ? Colors.white
                                : Colors.black,
                          ),
                          FilterItemWidget(
                            onTap: () {
                              menu_provider.toggleBool();
                            },
                            borderColor: menu_provider.toogleBoolean
                                ? Colors.purple
                                : Colors.black,
                            itemText: 'Non Veg',
                            containerColor: menu_provider.toogleBoolean
                                ? Colors.purple
                                : Colors.transparent,
                            textColor: menu_provider.toogleBoolean
                                ? Colors.white
                                : Colors.black,
                          ),
                          FilterItemWidget(
                            onTap: () {
                              menu_provider.toggleBool();
                            },
                            borderColor: menu_provider.toogleBoolean
                                ? Colors.purple
                                : Colors.black,
                            itemText: 'sweet',
                            containerColor: menu_provider.toogleBoolean
                                ? Colors.purple
                                : Colors.transparent,
                            textColor: menu_provider.toogleBoolean
                                ? Colors.white
                                : Colors.black,
                          ),
                          FilterItemWidget(
                            onTap: () {
                              menu_provider.toggleBool();
                            },
                            borderColor: menu_provider.toogleBoolean
                                ? Colors.purple
                                : Colors.black,
                            itemText: 'Spicy',
                            containerColor: menu_provider.toogleBoolean
                                ? Colors.purple
                                : Colors.transparent,
                            textColor: menu_provider.toogleBoolean
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
                              menu_provider.toggleBool();
                            },
                            borderColor: menu_provider.toogleBoolean
                                ? Colors.purple
                                : Colors.black,
                            itemText: '1',
                            containerColor: menu_provider.toogleBoolean
                                ? Colors.purple
                                : Colors.transparent,
                            textColor: menu_provider.toogleBoolean
                                ? Colors.white
                                : Colors.black,
                          ),
                          FilterRatingItemWidget(
                            onTap: () {
                              menu_provider.toggleBool();
                            },
                            borderColor: menu_provider.toogleBoolean
                                ? Colors.purple
                                : Colors.black,
                            itemText: '2',
                            containerColor: menu_provider.toogleBoolean
                                ? Colors.purple
                                : Colors.transparent,
                            textColor: menu_provider.toogleBoolean
                                ? Colors.white
                                : Colors.black,
                          ),
                          FilterRatingItemWidget(
                            onTap: () {
                              menu_provider.toggleBool();
                            },
                            borderColor: menu_provider.toogleBoolean
                                ? Colors.purple
                                : Colors.black,
                            itemText: '3',
                            containerColor: menu_provider.toogleBoolean
                                ? Colors.purple
                                : Colors.transparent,
                            textColor: menu_provider.toogleBoolean
                                ? Colors.white
                                : Colors.black,
                          ),
                          FilterRatingItemWidget(
                            onTap: () {
                              menu_provider.toggleBool();
                            },
                            borderColor: menu_provider.toogleBoolean
                                ? Colors.purple
                                : Colors.black,
                            itemText: '4',
                            containerColor: menu_provider.toogleBoolean
                                ? Colors.purple
                                : Colors.transparent,
                            textColor: menu_provider.toogleBoolean
                                ? Colors.white
                                : Colors.black,
                          ),
                          FilterRatingItemWidget(
                            onTap: () {
                              menu_provider.toggleBool();
                            },
                            borderColor: menu_provider.toogleBoolean
                                ? Colors.purple
                                : Colors.black,
                            itemText: '5',
                            containerColor: menu_provider.toogleBoolean
                                ? Colors.purple
                                : Colors.transparent,
                            textColor: menu_provider.toogleBoolean
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
                              menu_provider.toggleBool();
                            },
                            borderColor: menu_provider.toogleBoolean
                                ? Colors.purple
                                : Colors.black,
                            itemText: 'Low - High',
                            containerColor: menu_provider.toogleBoolean
                                ? Colors.purple
                                : Colors.transparent,
                            textColor: menu_provider.toogleBoolean
                                ? Colors.white
                                : Colors.black,
                          ),
                          FilterItemWidget(
                            onTap: () {
                              menu_provider.toggleBool();
                            },
                            borderColor: menu_provider.toogleBoolean
                                ? Colors.purple
                                : Colors.black,
                            itemText: 'High - Low',
                            containerColor: menu_provider.toogleBoolean
                                ? Colors.purple
                                : Colors.transparent,
                            textColor: menu_provider.toogleBoolean
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
