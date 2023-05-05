import 'package:badges/badges.dart';
import 'package:flutter/material.dart' hide Badge;
import 'package:provider/provider.dart';
import '../utils/responsive.dart';
import '../view_model/auth_provider.dart';
import '../view_model/cart_provider.dart';
import '../view_model/menu_provider.dart';
import '../view_model/qr_provider.dart';
import 'cart_screen.dart';


class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {



  @override
  Widget build(BuildContext context) {
    final auth_provider = Provider.of<AuthProvider>(context, listen: false);
    auth_provider.getUserInfo();
    final menu_provider = Provider.of<MenuProvider>(context, listen: false);
    final cart_provider = Provider.of<CartProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        foregroundColor: Colors.white,
        scrolledUnderElevation: 0.0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Hello, ${auth_provider.userModel?.userData?.name}",
              style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black
              ),),
            const Text("Welcome Back Have A Nice Day",
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w300,
                  color: Colors.grey
              ),
            ),
          ],
        ),
        actions: [
          Consumer<CartProvider>(
            builder: (_,cart_badge,__){
              cart_provider.getCartCount();
              return Badge(
                badgeContent: Text(
                  "${cart_badge.counter}",
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                position: BadgePosition.custom(start: 28, bottom: 28),
                child: IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CartScreen()));
                  },
                  icon: const Icon(Icons.shopping_bag_outlined, color: Colors.black,),
                ),
              );
            },
          ),
          const SizedBox(
            width: 20.0,
          ),
        ],
      ),
      body: SafeArea(
        child: Consumer<QRProvider>(
          builder: (_, qr_value, __) {
            return Container();
            // return StreamProvider(
            //   create : (context) => FireStoreService().getCategories(),
            //   initialData: null,
            //   child: Consumer<List<CategoryModel>?>(
            //     builder: (_, categories, __) {
            //       return (qr_value.show_menu == true) ?
            //       Container(
            //         margin: const EdgeInsets.only(left: 10, top: 15),
            //         child: Column(
            //           children: [
            //             Row(
            //               children: [
            //                 Text(
            //                   "Categories (${categories!.length})",
            //                   style: const TextStyle(
            //                       fontSize: 22, fontWeight: FontWeight.w500),
            //                 ),
            //               ],
            //             ),
            //             const SizedBox(
            //               height: 6.0,
            //             ),
            //             Flexible(
            //                 flex: 2,
            //                 child: (categories.isNotEmpty)
            //                     ? ListView(
            //                   scrollDirection: Axis.horizontal,
            //                   shrinkWrap: true,
            //                   children: <Widget>[
            //                     GestureDetector(
            //                       onTap: () {
            //                         menu_provider.selectCategory(-1);
            //                       },
            //                       child: Container(
            //                         margin: const EdgeInsets.only(
            //                             left: 8.0,
            //                             right: 8.0,
            //                             top: 8.0),
            //                         padding: const EdgeInsets.all(8.0),
            //                         decoration: BoxDecoration(
            //                             borderRadius:
            //                             const BorderRadius.all(
            //                                 Radius.circular(
            //                                     15)),
            //                             color: menu_provider
            //                                 .isSelectedIndex ==
            //                                 -1
            //                                 ? Colors.grey.shade300
            //                                 : Colors.white),
            //                         child: Column(
            //                           children: <Widget>[
            //                             Container(
            //                               margin: const EdgeInsets
            //                                   .symmetric(
            //                                   horizontal: 4),
            //                               child: const CircleAvatar(
            //                                 radius: 38,
            //                                 child: CustomText(
            //                                   text: "A",
            //                                   size: 50,
            //                                   weight: FontWeight.bold,
            //                                 ),
            //                               ),
            //                             ),
            //                             const SizedBox(
            //                               height: 2,
            //                             ),
            //                             const Text(
            //                               "All",
            //                               style: TextStyle(
            //                                 fontWeight:
            //                                 FontWeight.bold,
            //                                 fontSize: 16,
            //                               ),
            //                             )
            //                           ],
            //                         ),
            //                       ),
            //                     ),
            //                     ListView.builder(
            //                         shrinkWrap: true,
            //                         physics: const NeverScrollableScrollPhysics(),
            //                         scrollDirection: Axis.horizontal,
            //                         itemCount: categories.length,
            //                         itemBuilder: (context, index) {
            //                           return GestureDetector(
            //                             onTap: () {
            //                               print(index);
            //                               menu_provider.selectCategory(index);
            //                               menu_provider.setCategoryName(
            //                                   categories[index].categoryName!);
            //                             },
            //                             child: Container(
            //                               margin: const EdgeInsets.only(
            //                                   left: 8.0, right: 8.0, top: 8.0),
            //                               padding: const EdgeInsets.all(8.0),
            //                               decoration: BoxDecoration(
            //                                   borderRadius: const BorderRadius
            //                                       .all(Radius.circular(15)),
            //                                   color: menu_provider
            //                                       .isSelectedIndex == index
            //                                       ? Colors.grey.shade200
            //                                       : Colors.white
            //                               ),
            //                               child: Column(
            //                                 children: <Widget>[
            //                                   Container(
            //                                     margin: const EdgeInsets
            //                                         .symmetric(
            //                                         horizontal: 4),
            //                                     child: CircleAvatar(
            //                                       backgroundImage: NetworkImage(
            //                                           categories[index]
            //                                               .categoryImage
            //                                               .toString()),
            //                                       radius: 38,
            //                                     ),
            //                                   ),
            //                                   const SizedBox(
            //                                     height: 2,
            //                                   ),
            //                                   Text(
            //                                     categories[index].categoryName!,
            //                                     style: const TextStyle(
            //                                       fontWeight: FontWeight.bold,
            //                                       fontSize: 16,
            //                                     ),
            //                                   )
            //                                 ],
            //                               ),
            //                             ),
            //                           );
            //                         }
            //                     ),
            //                   ],
            //                 )
            //                     : Container()
            //             ),
            //             const SizedBox(height: 10.0,),
            //             Row(
            //               mainAxisAlignment: MainAxisAlignment.start,
            //               children: const [
            //                 Text(
            //                   "Menu Items",
            //                   style: TextStyle(
            //                       fontSize: 22, fontWeight: FontWeight.w500),
            //                 ),
            //               ],
            //             ),
            //             const SizedBox(
            //               height: 8,
            //             ),
            //             StreamProvider(
            //              create : (context) => FireStoreService().getMenuItems(),
            //               initialData: null,
            //               child: Consumer<List<MenuItemModel>?>(
            //                 builder: (_, menu_items, __) {
            //                   print(menu_items);
            //                   return (qr_value.show_menu == true) ?
            //                   Expanded(
            //                       flex: 5,
            //                       child: (menu_items!.isEmpty)
            //                           ? Center(
            //                         child: Column(
            //                           children: [
            //                             const SizedBox(
            //                               height: 30,
            //                             ),
            //                             Image.asset(
            //                               "assets/images/empty-menu.png",
            //                               height: 230,
            //                               width: 230,
            //                             ),
            //                             const Text(
            //                               "No Menu",
            //                               style: TextStyle(
            //                                   fontSize: 22,
            //                                   fontWeight: FontWeight.w400),
            //                             ),
            //                           ],
            //                         ),
            //                       )
            //                           : ListView.builder(
            //                         itemCount: menu_items.length,
            //                         scrollDirection: Axis.vertical,
            //                         itemBuilder: (context, index) {
            //                           return GestureDetector(
            //                             onTap: () {
            //                               CustomBottomSheet
            //                                   .showCustomModalBottomSheet(
            //                                 onPressed: () {
            //                                   final FirebaseAuth _firebaseAuth = FirebaseAuth
            //                                       .instance;
            //                                   String userId = _firebaseAuth
            //                                       .currentUser!.uid;
            //                                   cart_provider.addCartData(
            //                                       cartId: userId,
            //                                       itemId: menu_items[index].menuId,
            //                                       table_no: qr_value.table_number,
            //                                       itemName: menu_items[index].menuName,
            //                                       initialPrice: menu_items[index].menuPrice,
            //                                       itemPrice: menu_items[index].menuPrice,
            //                                       itemQuantity: cart_provider.quantity,
            //                                       itemImage: menu_items[index].menuImage,
            //                                       itemDescription: menu_items[index].menuDescription,
            //                                       itemIngredients: menu_items[index].menuIngredients
            //                                   ).then((value) {
            //                                     Navigator.pop(context);
            //                                     print("cart data is added");
            //                                   });
            //                                 },
            //                                 context: context,
            //                                 image_url: menu_items[index]
            //                                     .menuImage.toString(),
            //                                 menu_item_name: menu_items[index]
            //                                     .menuName.toString(),
            //                                 menu_item_description: menu_items[index]
            //                                     .menuDescription.toString(),
            //                                 menu_item_ingredients: menu_items[index]
            //                                     .menuIngredients.toString(),
            //                                 menu_item_price: menu_items[index]
            //                                     .menuPrice.toString(),
            //                                 isVeg: menu_items[index]
            //                                     .isEnableVeg!,
            //                                 isJain: menu_items[index]
            //                                     .isEnableJain!,
            //                                 isNew: menu_items[index]
            //                                     .isEnableNew!,
            //                                 isPopular: menu_items[index]
            //                                     .isEnablePopular!,
            //                                 isSpecial: menu_items[index]
            //                                     .isEnableSpecial!,
            //                                 isSpicy: menu_items[index]
            //                                     .isEnableSpicy!,
            //                                 isSweet: menu_items[index]
            //                                     .isEnableSweet!,
            //                               );
            //                             },
            //                             child: (menu_provider.isSelectedIndex ==
            //                                 -1 || (menu_provider.categoryName ==
            //                                 menu_items[index].menuCateory))
            //                                 ? Container(
            //                               width: wp(100, context),
            //                               child: Card(
            //                                 child: Container(
            //                                   padding: const EdgeInsets.all(
            //                                       8.0),
            //                                   child: ListTile(
            //                                     leading: Image.network(
            //                                         menu_items[index]
            //                                             .menuImage ?? ''),
            //                                     title: Column(
            //                                       children: [
            //                                         Row(
            //                                           children: [
            //                                             (menu_items[index]
            //                                                 .isEnableVeg ==
            //                                                 true)
            //                                                 ? Image.asset(
            //                                               "assets/images/veg-icon.png",
            //                                               height: 40,
            //                                               width: 40,
            //                                             )
            //                                                 : Image.asset(
            //                                               "assets/images/non-veg-icon.png",
            //                                               height: 35,
            //                                               width: 35,
            //                                             ),
            //                                             const Spacer(),
            //                                             (menu_items[index]
            //                                                 .isEnableNew! ==
            //                                                 true)
            //                                                 ? Container(
            //                                               decoration: BoxDecoration(
            //                                                   color: Colors
            //                                                       .purple
            //                                                       .shade200,
            //                                                   borderRadius: const BorderRadius
            //                                                       .all(
            //                                                       Radius
            //                                                           .circular(
            //                                                           20))),
            //                                               padding:
            //                                               const EdgeInsets
            //                                                   .all(8.0),
            //                                               child: const Text(
            //                                                 "New",
            //                                                 style: TextStyle(
            //                                                     color: Colors
            //                                                         .purple,
            //                                                     fontSize:
            //                                                     14,
            //                                                     fontWeight:
            //                                                     FontWeight
            //                                                         .bold),
            //                                               ),
            //                                             )
            //                                                 : Container()
            //                                           ],
            //                                         ),
            //                                         const SizedBox(
            //                                           height: 6,
            //                                         ),
            //                                         Row(
            //                                           children: [
            //                                             Text(
            //                                               menu_items[index]
            //                                                   .menuName.toString(),
            //                                               style: const TextStyle(
            //                                                   fontSize: 20,
            //                                                   fontWeight:
            //                                                   FontWeight.w600,
            //                                                   color:
            //                                                   Colors.black),
            //                                             ),
            //                                           ],
            //                                         ),
            //                                         const SizedBox(
            //                                           height: 6,
            //                                         ),
            //                                         Row(
            //                                           children: [
            //                                             Text(
            //                                               menu_items[index]
            //                                                   .menuIngredients.toString(),
            //                                               style: const TextStyle(
            //                                                 fontSize: 12,
            //                                                 color: Colors.grey,
            //                                               ),
            //                                             )
            //                                           ],
            //                                         ),
            //                                         const Divider(
            //                                           height: 3,
            //                                           color: Colors.grey,
            //                                         ),
            //                                         const SizedBox(
            //                                           height: 6,
            //                                         ),
            //                                         Row(
            //                                           children: [
            //                                             Text(
            //                                               menu_items[index]
            //                                                   .menuPrice.toString(),
            //                                               style: const TextStyle(
            //                                                   fontSize: 16,
            //                                                   fontWeight:
            //                                                   FontWeight
            //                                                       .bold),
            //                                             ),
            //                                             const Spacer(),
            //                                             (menu_items[index]
            //                                                 .isEnableSpicy! ==
            //                                                 true) ? const Text(
            //                                               "Spicy, ",
            //                                               style: TextStyle(
            //                                                 fontSize: 12,
            //                                                 color: Colors.grey,
            //                                               ),) : const Text(""),
            //                                             (menu_items[index]
            //                                                 .isEnableSweet! ==
            //                                                 true) ? const Text(
            //                                               "Sweet, ",
            //                                               style: TextStyle(
            //                                                 fontSize: 12,
            //                                                 color: Colors.grey,
            //                                               ),) : const Text(""),
            //                                             (menu_items[index]
            //                                                 .isEnableSpecial! ==
            //                                                 true) ? const Text(
            //                                               "Special, ",
            //                                               style: TextStyle(
            //                                                 fontSize: 12,
            //                                                 color: Colors.grey,
            //                                               ),) : const Text(""),
            //                                             (menu_items[index]
            //                                                 .isEnablePopular! ==
            //                                                 true) ? const Text(
            //                                               "Popular ",
            //                                               style: TextStyle(
            //                                                 fontSize: 12,
            //                                                 color: Colors.grey,
            //                                               ),) : const Text(""),
            //                                           ],
            //                                         ),
            //                                         const SizedBox(
            //                                           height: 6,
            //                                         ),
            //                                       ],
            //                                     ),
            //                                   ),
            //                                 ),
            //                               ),
            //                             )
            //                                 : Container(),
            //                           );
            //                         },
            //                       )
            //                   ) : Container();
            //                 },
            //               ),
            //             ),
            //           ],
            //         ),
            //       ) : Center(
            //         child: Column(
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           children: [
            //             const Text("Scan Qr Code available on your table",
            //               style: TextStyle(
            //                 fontSize: 18,
            //               ),),
            //             IconButton(onPressed: () {
            //               Future.delayed(Duration.zero, () {
            //                 Navigator.push(context, MaterialPageRoute(
            //                   builder: (context) => QRScannerScreen(),));
            //               });
            //             }, icon: const Icon(Icons.qr_code_scanner, size: 35,),
            //             ),
            //           ],
            //         ),
            //       );
            //     },
            //   ),
            // );
          },
        ),
      ),
    );
  }
}