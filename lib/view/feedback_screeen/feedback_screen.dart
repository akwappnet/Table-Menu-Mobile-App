import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:table_menu_customer/utils/responsive.dart';
import 'package:table_menu_customer/utils/widgets/custom_textformfield.dart';
import 'package:table_menu_customer/view/feedback_screeen/widget/add_feedback_dialog.dart';

import '../../utils/font/text_style.dart';
import '../../utils/routes/routes_name.dart';
import '../../utils/validation/validation.dart';
import '../../utils/widgets/custom_button.dart';
import '../../view_model/order_provider.dart';

class FeedbackScreen extends StatelessWidget {
  const FeedbackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Feedback',
          style: smallTitleTextStyle,
        ),
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0.0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Consumer<OrderProvider>(
        builder: (context, order_provider, __) {
          return SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: wp(4, context), vertical: hp(3, context)),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Rate your order",
                          style: smallTitleTextStyle,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: hp(2, context),
                    ),
                    Text(
                      "How was your food?",
                      style: textBodyStyle,
                    ),
                    SizedBox(
                      height: hp(2, context),
                    ),
                    RatingBar.builder(
                      glow: false,
                      initialRating: 3,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, index) {
                        switch (index) {
                          case 0:
                            return const Icon(
                              Icons.sentiment_very_dissatisfied,
                              color: Colors.red,
                            );
                          case 1:
                            return const Icon(
                              Icons.sentiment_dissatisfied,
                              color: Colors.redAccent,
                            );
                          case 2:
                            return const Icon(
                              Icons.sentiment_neutral,
                              color: Colors.amber,
                            );
                          case 3:
                            return const Icon(
                              Icons.sentiment_satisfied,
                              color: Colors.lightGreen,
                            );
                          case 4:
                            return const Icon(
                              Icons.sentiment_very_satisfied,
                              color: Colors.green,
                            );
                            default:
                              return const Icon(
                                Icons.add,
                                color: Colors.transparent,
                              );
                        }
                      },
                      onRatingUpdate: (rating) {
                        order_provider.updateFoodRating(rating);
                      },
                    ),
                    SizedBox(
                      height: hp(2, context),
                    ),
                    Text(
                      "How was service?",
                      style: textBodyStyle,
                    ),
                    SizedBox(
                      height: hp(2, context),
                    ),
                    RatingBar.builder(
                      glow: false,
                      initialRating: 3,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, index) {
                        switch (index) {
                          case 0:
                            return const Icon(
                              Icons.sentiment_very_dissatisfied,
                              color: Colors.red,
                            );
                          case 1:
                            return const Icon(
                              Icons.sentiment_dissatisfied,
                              color: Colors.redAccent,
                            );
                          case 2:
                            return const Icon(
                              Icons.sentiment_neutral,
                              color: Colors.amber,
                            );
                          case 3:
                            return const Icon(
                              Icons.sentiment_satisfied,
                              color: Colors.lightGreen,
                            );
                          case 4:
                            return const Icon(
                              Icons.sentiment_very_satisfied,
                              color: Colors.green,
                            );
                          default:
                            return const Icon(
                              Icons.add,
                              color: Colors.transparent,
                            );
                        }
                      },
                      onRatingUpdate: (rating) {
                        order_provider.updateServiceRating(rating);
                      },
                    ),
                    SizedBox(
                      height: hp(2, context),
                    ),
                    Text(
                      "write your feedback",
                      style: textBodyStyle,
                    ),
                    SizedBox(
                      height: hp(2, context),
                    ),
                    CustomTextFormField().getCustomEditTextArea(
                        maxLines: 5,
                        labelValue: "Feedback",
                        hintValue: "Enter your feedback",
                        controller: order_provider.feedbackController,
                        obscuretext: false,
                        onchanged: (value) {},
                        textInputAction: TextInputAction.done,
                        validator: (value) {
                          return null;
                        }),
                    SizedBox(
                      height: hp(2, context),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: wp(1.5, context), vertical: hp(1.5, context)),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: hp(7.5, context),
          child: CustomButton(
            onPressed: () async {
              Navigator.popAndPushNamed(context, RoutesName.HOME_SCREEN_ROUTE);
            },
            child: Text(
              "Submit",
              style: textBodyStyle.copyWith(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
