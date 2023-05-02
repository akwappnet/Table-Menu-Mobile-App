import 'package:badges/badges.dart';
import 'package:flutter/material.dart' hide Badge;
import 'package:provider/provider.dart';

import '../view_model/cart_provider.dart';
import '../view_model/order_provider.dart';


class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {

 // FireStoreService fireStoreService = FireStoreService();

  List<Map<String, dynamic>> cartItemList = [];
  // final uuid = Uuid();
  // final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;


  @override
  Widget build(BuildContext context) {
    final cart_provider = Provider.of<CartProvider>(context, listen: true);
    final order_provider = Provider.of<OrderProvider>(context, listen: true);
    cart_provider.getCartCount();
    bool runOnetime = true;
    return Center(
      // child: StreamProvider(
      //   create: (context) => FireStoreService().getCartItems(),
      //   initialData: null,
      //   child: Consumer<List<CartModel>?>(
      //     builder: (_, cart_items, __) {
      //       return Scaffold(
      //           appBar: AppBar(
      //             centerTitle: true,
      //             title: const Text('Cart'),
      //             actions: [
      //               Badge(
      //                 badgeContent: Text(
      //                   "${cart_provider.counter}",
      //                   style: const TextStyle(
      //                       color: Colors.white, fontWeight: FontWeight.bold),
      //                 ),
      //                 position: BadgePosition.custom(start: 28, bottom: 28),
      //                 child: IconButton(
      //                   onPressed: () {},
      //                   icon: const Icon(
      //                     Icons.shopping_bag_outlined, color: Colors.black,),
      //                 ),
      //               ),
      //               const SizedBox(
      //                 width: 20.0,
      //               ),
      //             ],
      //           ),
      //           body: SafeArea(
      //             child: Center(
      //               child: Container(
      //                 margin: const EdgeInsets.all(10),
      //                 child: Column(
      //                   children: [
      //                     Expanded(
      //                         child: (cart_items!.isEmpty) ?
      //                         const Center(
      //                             child: Text(
      //                               'Your Cart is Empty',
      //                               style:
      //                               TextStyle(fontWeight: FontWeight.bold,
      //                                   fontSize: 18.0),
      //                             )) :
      //                         ListView.builder(
      //                             shrinkWrap: true,
      //                             itemCount: cart_items.length,
      //                             itemBuilder: (context, index) {
      //                               return Column(
      //                                 children: [
      //                                   Card(
      //                                     color: Colors.purple.shade50,
      //                                     elevation: 5.0,
      //                                     child: Padding(
      //                                       padding: const EdgeInsets.all(4.0),
      //                                       child: Row(
      //                                         mainAxisAlignment: MainAxisAlignment
      //                                             .spaceEvenly,
      //                                         mainAxisSize: MainAxisSize.max,
      //                                         children: [
      //                                           cart_items[index].itemImage == ""
      //                                               ? Image.asset(
      //                                             "assets/images/veg-icon.png",
      //                                             height: 80, width: 80,)
      //                                               : Image.network(
      //                                             cart_items[index].itemImage
      //                                                 .toString(),
      //                                             height: 80,
      //                                             width: 80,
      //                                           ),
      //                                           SizedBox(
      //                                             width: 130,
      //                                             child: Column(
      //                                               crossAxisAlignment:
      //                                               CrossAxisAlignment.start,
      //                                               children: [
      //                                                 const SizedBox(
      //                                                   height: 5.0,
      //                                                 ),
      //                                                 RichText(
      //                                                   overflow: TextOverflow
      //                                                       .ellipsis,
      //                                                   maxLines: 1,
      //                                                   text: TextSpan(
      //                                                       text: 'Name: ',
      //                                                       style: TextStyle(
      //                                                           color: Colors
      //                                                               .blueGrey
      //                                                               .shade800,
      //                                                           fontSize: 16.0),
      //                                                       children: [
      //                                                         TextSpan(
      //                                                             text:
      //                                                             '${cart_items[index]
      //                                                                 .itemName
      //                                                                 .toString()}\n',
      //                                                             style: const TextStyle(
      //                                                                 fontWeight:
      //                                                                 FontWeight
      //                                                                     .bold)),
      //                                                       ]
      //                                                   ),
      //                                                 ),
      //                                                 RichText(
      //                                                   maxLines: 1,
      //                                                   text: TextSpan(
      //                                                       text: 'Price: ' r"₹",
      //                                                       style: TextStyle(
      //                                                           color: Colors
      //                                                               .blueGrey
      //                                                               .shade800,
      //                                                           fontSize: 16.0),
      //                                                       children: [
      //                                                         TextSpan(
      //                                                             text:
      //                                                             '${cart_items[index]
      //                                                                 .initialPrice
      //                                                                 .toString()}\n',
      //                                                             style: const TextStyle(
      //                                                                 fontWeight:
      //                                                                 FontWeight
      //                                                                     .bold)),
      //                                                       ]),
      //                                                 ),
      //                                               ],
      //                                             ),
      //                                           ),
      //                                           PlusMinusButtons(
      //                                             addQuantity: () {
      //                                               cart_provider.addQuantity(
      //                                                   cartId: cart_items[index]
      //                                                       .cartId,
      //                                                   itemId: cart_items[index]
      //                                                       .itemId!,
      //                                                   itemName: cart_items[index]
      //                                                       .itemName,
      //                                                   initialPrice: cart_items[index]
      //                                                       .initialPrice,
      //                                                   itemPrice: cart_items[index]
      //                                                       .initialPrice,
      //                                                   itemQuantity: cart_items[index]
      //                                                       .itemQuantity,
      //                                                   itemImage: cart_items
      //                                                   [index].itemImage,
      //                                                   itemDescription: cart_items[index]
      //                                                       .itemDescription,
      //                                                   itemIngredients: cart_items[index]
      //                                                       .itemIngredients,
      //                                                   table_no: cart_items[index]
      //                                                       .table_no
      //                                               );
      //                                             },
      //                                             deleteQuantity: () {
      //                                               cart_provider.deleteQuantity(
      //                                                   cartId: cart_items[index]
      //                                                       .cartId!,
      //                                                   itemId: cart_items[index]
      //                                                       .itemId!,
      //                                                   itemName: cart_items[index]
      //                                                       .itemName,
      //                                                   initialPrice: cart_items[index]
      //                                                       .initialPrice,
      //                                                   itemPrice: cart_items[index]
      //                                                       .initialPrice,
      //                                                   itemQuantity: cart_items[index]
      //                                                       .itemQuantity,
      //                                                   itemImage: cart_items
      //                                                   [index].itemImage,
      //                                                   itemDescription: cart_items[index]
      //                                                       .itemDescription,
      //                                                   itemIngredients: cart_items[index]
      //                                                       .itemIngredients,
      //                                                   table_no: cart_items[index]
      //                                                       .table_no
      //                                               );
      //                                             },
      //                                             text: cart_items[index]
      //                                                 .itemQuantity.toString(),
      //                                           ),
      //                                           IconButton(
      //                                               onPressed: () {
      //                                                 cart_provider
      //                                                     .removeItem(
      //                                                     cart_items[index]
      //                                                         .cartId!,
      //                                                     cart_items[index]
      //                                                         .itemId!);
      //                                               },
      //                                               icon: Icon(
      //                                                 Icons.delete,
      //                                                 color: Colors.red.shade800,
      //                                               )),
      //                                         ],
      //                                       ),
      //                                     ),
      //                                   ),
      //                                   // const Spacer(),
      //                                 ],
      //                               );
      //                             }),
      //                     ),
      //                     ReusableWidget(
      //                         title: 'Sub-Total',
      //                         value: r'₹ ' +
      //                             (cart_provider.totalPrice
      //                                 .toStringAsFixed(2) ?? '0')),
      //                   ],
      //                 ),
      //               ),
      //             ),
      //           ),
      //           bottomNavigationBar: CustomButton(
      //             onPressed: () {
      //               List.generate(cart_items.length, (index) => cartItemList.add(cart_items[index].toMap()));
      //               order_provider.addOrder(
      //                 paymentStatus: "pending",
      //                 createdAt: DateTime.now().toString(),
      //                 orderId: uuid.v4(),
      //                 orderStatus: "ordered",
      //                 tableNo: cart_items[0].table_no,
      //                 userId:  _firebaseAuth.currentUser!.uid,
      //                 cartItemList: cartItemList
      //               );
      //               ScaffoldMessenger.of(context).showSnackBar(
      //                 const SnackBar(
      //                   content: Text('Order Done'),
      //                   duration: Duration(seconds: 2),
      //                 ),
      //               );
      //               Navigator.pop(context);
      //             },
      //             child: const CustomText(
      //               text: "Place Order",
      //               color: Colors.white,
      //               size: 18.0,
      //               weight: FontWeight.bold,
      //             ),
      //           )
      //       );
      //       },
      //   ),
      // ),
    );
  }
}