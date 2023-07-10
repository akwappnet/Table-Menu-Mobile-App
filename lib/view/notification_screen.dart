import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:table_menu_customer/model/custom_result_model.dart';
import 'package:table_menu_customer/utils/font/text_style.dart';
import 'package:table_menu_customer/utils/widgets/custom_flushbar_widget.dart';
import 'package:table_menu_customer/utils/widgets/custom_text.dart';
import 'package:table_menu_customer/utils/widgets/placeholder_widget.dart';
import 'package:table_menu_customer/view_model/notification_provider.dart';

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
        title: Text("Notification",style: titleTextStyle,),
        centerTitle: true,
        actions: [
          Consumer<NotificationProvider>(
            builder: (context, notificationProvider, __) {
              return
                   InkWell(
                      onTap: () async {
                        CustomResultModel? result = await notificationProvider
                            .deleteAllNotification();
                        if (result!.status) {
                          CustomFlushbar.showSuccess(context, result.message);
                        } else {
                          CustomFlushbar.showError(context, result.message);
                        }
                      },
                      child: notificationProvider.notificationList.isNotEmpty ? const CustomText(
                        text: "Clear All",
                        size: 18,
                        color: Colors.red,
                      ) : const SizedBox.shrink(),);
            },
          ),
          const SizedBox(
            width: 20.0,
          )
        ],
      ),
      body: Padding(
          padding: EdgeInsets.symmetric(
              vertical: hp(2, context), horizontal: wp(1, context)),
          child: StreamBuilder(
            stream:
                notification_provider.getAllNotification().asStream(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var notificationData = snapshot.data;
                return Consumer<NotificationProvider>(
                  builder: (context, notification_provider, __) {
                    return Container(
                      margin: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Expanded(
                              child: notificationData!.isEmpty
                                  ? const Center(
                                      child: PlaceholderWidget(title: "NO NOTIFICATION"))
                                  : ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: notificationData.length,
                                      itemBuilder: (context, index) {
                                        var notification =
                                            notificationData[index];
                                        return Slidable(
                                          key: UniqueKey(),
                                          closeOnScroll: true,
                                          endActionPane: ActionPane(
                                            extentRatio: 0.2,
                                            motion: const BehindMotion(),
                                            children: [
                                              InkWell(
                                                onTap: () async {
                                                  CustomResultModel? result =
                                                      await notification_provider
                                                          .deleteSingleNotification(
                                                              notification.id!);
                                                  if (result!.status) {
                                                    CustomFlushbar.showSuccess(
                                                        context,
                                                        result.message);
                                                  } else {
                                                    CustomFlushbar.showError(
                                                        context,
                                                        result.message);
                                                  }
                                                },
                                                child: Container(
                                                  height: double.infinity,
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal: wp(5, context),
                                                  ),
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: Colors.red,
                                                    borderRadius: BorderRadius
                                                        .only(
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
                                              if(notification.readStatus! == false){
                                                CustomResultModel? result =
                                                await notification_provider
                                                    .markAsReadNotification(
                                                    notification.id!);
                                                if (result!.status) {
                                                  CustomFlushbar.showSuccess(
                                                      context, result.message);
                                                } else {
                                                  CustomFlushbar.showError(
                                                      context, result.message);
                                                }
                                              }else {

                                              }
                                            },
                                            child: Card(
                                              elevation: 3.0,
                                              color: notification.readStatus ==
                                                      true
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
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 4.0),
                                                  child: CustomText(
                                                    text:
                                                        notification.title!,
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
                                                      color: const Color(0xff848285),
                                                    ),
                                                    const SizedBox(
                                                      height: 4,
                                                    ),
                                                    CustomText(
                                                      text:
                                                          getTimeAgo(notification.createdAt!),
                                                      color: const Color(0xff848285),
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
                    );
                  },
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
