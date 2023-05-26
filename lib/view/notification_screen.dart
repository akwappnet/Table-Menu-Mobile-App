import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:table_menu_customer/utils/widgets/custom_text.dart';
import 'package:table_menu_customer/view_model/notification_provider.dart';

import '../utils/assets/assets_utils.dart';
import '../utils/functions/time_to_ago_function.dart';
import '../utils/responsive.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final notification_provider =
        Provider.of<NotificationProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0.0,
        title: Text("notification"),
        actions: [
          Padding(
            padding: EdgeInsets.all(wp(4, context)),
            child: InkWell(
                onTap: () {
                  notification_provider.deleteAllNotification(context);
                },
                child: CustomText(
                  text: "Clear All",
                  size: 18,
                  color: Colors.red,
                )),
          ),
        ],
      ),
      body: Padding(
          padding: EdgeInsets.symmetric(
              vertical: hp(2, context), horizontal: wp(1, context)),
          child: StreamBuilder(
            stream:
                notification_provider.getAllNotification(context).asStream(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var notificationData = snapshot.data;
                return Expanded(
                  child: notificationData!.isNotEmpty ||
                          notificationData != null
                      ? ListView.builder(
                          shrinkWrap: true,
                          itemCount: notificationData?.length,
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            var notification = notificationData?[index];
                            return Slidable(
                              key: UniqueKey(),
                              closeOnScroll: true,
                              endActionPane: ActionPane(
                                extentRatio: 0.2,
                                motion: const BehindMotion(),
                                children: [
                                  InkWell(
                                    onTap: () {
                                      notification_provider
                                          .deleteSingleNotification(
                                              notification!.id!, context);
                                    },
                                    child: Container(
                                      height: double.infinity,
                                      padding: EdgeInsets.symmetric(
                                        horizontal: wp(5, context),
                                      ),
                                      decoration: const BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(12.0),
                                            bottomRight: Radius.circular(12.0)),
                                      ),
                                      child: Icon(Icons.delete_outlined),
                                    ),
                                  )
                                ],
                              ),
                              child: GestureDetector(
                                onTap: () {},
                                child: Card(
                                  elevation: 3.0,
                                  child: ListTile(
                                    leading: Icon(
                                      Icons.circle_notifications_outlined,
                                      size: 40,
                                      color: Colors.purple.shade200,
                                    ),
                                    title: Padding(
                                      padding: const EdgeInsets.only(bottom: 4.0),
                                      child: CustomText(
                                        text: "${notification?.title!}",
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
                                          text: "${notification?.body}",
                                          size: 14,
                                          weight: FontWeight.w400,
                                          color: Color(0xff848285),
                                        ),
                                        SizedBox(height: 4,),
                                        CustomText(
                                          text:
                                              "${getTimeAgo(notification!.createdAt!)}",
                                          color: Color(0xff848285),
                                          size: 12.0,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        )
                      : Center(
                          child: Lottie.asset(
                            AssetsUtils.ASSETS_LOADING_PURPLE_ANIMATION,
                            width: 100,
                            height: 100,
                            fit: BoxFit.fill,
                          ),
                        ),
                );
              } else {
                return const Center(
                    child: Text(
                  'NO NOTIFICATION',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                ));
              }
            },
          )),
    );
  }
}
