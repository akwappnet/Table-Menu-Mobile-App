import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:table_menu_customer/utils/font/text_style.dart';
import 'package:table_menu_customer/utils/widgets/custom_text.dart';
import 'package:table_menu_customer/utils/widgets/placeholder_widget.dart';
import 'package:table_menu_customer/view_model/notification_provider.dart';

import '../utils/assets/assets_utils.dart';
import '../utils/functions/time_to_ago_function.dart';
import '../utils/responsive.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<NotificationProvider>(
      builder: (context, notification_provider, __) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            scrolledUnderElevation: 0.0,
            title: Text(
              "Notification",
              style: titleTextStyle,
            ),
            centerTitle: true,
            actions: [
              InkWell(
                onTap: () async {
                  notification_provider.deleteAllNotification(context);
                },
                child: notification_provider.notificationList.isNotEmpty
                    ? const CustomText(
                        text: "Clear All",
                        size: 18,
                        color: Colors.red,
                      )
                    : const SizedBox.shrink(),
              ),
              const SizedBox(
                width: 20.0,
              )
            ],
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(
                vertical: hp(2, context), horizontal: wp(1, context)),
            child: notification_provider.loading
                ? Center(
                    child: Lottie.asset(
                      AssetsUtils.ASSETS_LOADING_PURPLE_ANIMATION,
                      width: 100,
                      height: 100,
                      fit: BoxFit.fill,
                    ),
                  )
                : Container(
                    margin: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Expanded(
                            child: notification_provider.notificationList.isEmpty
                                ? const Center(
                                    child: PlaceholderWidget(
                                        title: "NO NOTIFICATION"))
                                : ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: notification_provider.notificationList.length,
                                    itemBuilder: (context, index) {
                                      var notification =
                                          notification_provider.notificationList[index];
                                      return Slidable(
                                        key: UniqueKey(),
                                        closeOnScroll: true,
                                        endActionPane: ActionPane(
                                          extentRatio: 0.2,
                                          motion: const BehindMotion(),
                                          children: [
                                            InkWell(
                                              onTap: () async {
                                                notification_provider
                                                    .deleteSingleNotification(
                                                        notification.id!,
                                                        context);
                                              },
                                              child: Container(
                                                height: double.infinity,
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: wp(5, context),
                                                ),
                                                decoration: const BoxDecoration(
                                                  color: Colors.red,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topRight:
                                                              Radius.circular(
                                                                  12.0),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  12.0)),
                                                ),
                                                child: const Icon(
                                                    Icons.delete_outlined),
                                              ),
                                            )
                                          ],
                                        ),
                                        child: GestureDetector(
                                          onTap: () async {
                                            if (notification.readStatus! ==
                                                false) {
                                              notification_provider
                                                  .markAsReadNotification(
                                                      notification.id!,
                                                      context);
                                            } else {}
                                          },
                                          child: Card(
                                            elevation: 3.0,
                                            color:
                                                notification.readStatus == true
                                                    ? Colors.grey.shade300
                                                    : Colors.white,
                                            child: ListTile(
                                              leading: Icon(
                                                Icons
                                                    .circle_notifications_outlined,
                                                size: 40,
                                                color: Colors.purple.shade200,
                                              ),
                                              title: Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 4.0),
                                                child: CustomText(
                                                  text: notification.title!,
                                                  size: 16.0,
                                                  weight: FontWeight.w600,
                                                ),
                                              ),
                                              subtitle: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  CustomText(
                                                    text:
                                                        "${notification.body}",
                                                    size: 14,
                                                    weight: FontWeight.w400,
                                                    color:
                                                        const Color(0xff848285),
                                                  ),
                                                  const SizedBox(
                                                    height: 4,
                                                  ),
                                                  CustomText(
                                                    text: getTimeAgo(
                                                        notification
                                                            .createdAt!),
                                                    color:
                                                        const Color(0xff848285),
                                                    size: 12.0,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  )),
                      ],
                    ),
                  ),
          ),
        );
      },
    );
  }
}
