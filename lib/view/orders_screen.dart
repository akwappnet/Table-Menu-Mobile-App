import 'package:flutter/material.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final FirebaseAuth auth = FirebaseAuth.instance;
    // final CollectionReference ordersCollectionRef = FirebaseFirestore.instance
    //     .collection("UserOrders")
    //     .doc(auth.currentUser?.uid)
    //     .collection("orders");
return Scaffold();
    // return StreamBuilder<QuerySnapshot>(
    //   stream: ordersCollectionRef.snapshots(),
    //   builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    //     var order_data = snapshot.data;
    //     final List<DocumentSnapshot> docs = snapshot.data!.docs;
    //     final DocumentSnapshot<dynamic>? ordersDocSnapshot =
    //         docs.isNotEmpty ? docs.first : null;
    //     final List<dynamic> orderItem =
    //         ordersDocSnapshot?.data()!['cartItemList'];
    //     final int orderItemLength = orderItem.length;
    //
    //     return Expanded(
    //       child: Column(
    //         children: [
    //           snapshot.hasData  ?
    //           ListView.builder(
    //             shrinkWrap: true,
    //             itemCount: order_data?.docs.length,
    //             itemBuilder: (context, index) {
    //               return Column(
    //                 mainAxisAlignment: MainAxisAlignment.start,
    //                 children: [
    //                   Text("table no : ${order_data?.docs[index]["tableNo"]}"),
    //                   Text(
    //                       "payment status : ${order_data?.docs[index]['paymentStatus']}"),
    //                   Text(
    //                       "order status : ${order_data?.docs[index]['orderStatus']}"),
    //                   ListView.builder(
    //                     physics: ClampingScrollPhysics(),
    //                     shrinkWrap: true,
    //                     itemCount: orderItemLength,
    //                     itemBuilder: (context, indexx) {
    //                       var item_data =
    //                           order_data?.docs[index]['cartItemList'][indexx];
    //                       return Column(
    //                         children: [
    //                           Text("item name : ${item_data["itemName"]}"),
    //                         ],
    //                       );
    //                     },
    //                   )
    //                 ],
    //               );
    //             },
    //           ) : const Center(
    //             child: CustomText(
    //               text: "NO ORDERS",
    //               size: 28,
    //               weight: FontWeight.bold,
    //             ),
    //           ),
    //         ],
    //       ),
    //     );
    //   },
    // );
  }
}
