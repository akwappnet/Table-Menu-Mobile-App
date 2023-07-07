// import 'package:dio/dio.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/mockito.dart';
// import 'package:table_menu_customer/repository/menu_repository.dart';
// import 'package:table_menu_customer/utils/constants/api_endpoints.dart';
// import 'package:table_menu_customer/view_model/menu_provider.dart';
//
// // Create a mock MenuRepository
// class MockMenuRepository extends Mock implements MenuRepository {
//   String token = "";
//
//   @override
//   Future<Response> getCategories([BuildContext? context]) {
//     try{
//       var headers = {
//         'Authorization': 'Token $token',
//         'Accept': 'application/json'
//       };
//       var response = Response(
//         data: {
//           'status': true,
//           'message': 'test message',
//           'data': [
//             {
//               'category_id': 1,
//               'category_name': 'pizza',
//               'description': 'aaa',
//               'category_img': 'aaaa'
//             },
//             {
//               'category_id': 2,
//               'category_name': 'burger',
//               'description': 'aaaa',
//               'category_img': 'aaaa'
//             },
//           ],
//         },
//         statusCode: 200,
//         requestOptions: RequestOptions(
//           baseUrl: ApiEndPoint.baseUrl,
//           path: ApiEndPoint.menuEndPoint.categoryEndPoint,
//           headers: headers,
//         ),
//       );
//       return Future.value(response);
//     }catch (e){
//       throw e;
//     }
//   }
//
//   Future<Response<dynamic>> getMenuItems(String category_name,
//       [BuildContext? context]) {
//     var headers = {
//       'Authorization': 'Token $token',
//       'Accept': 'application/json'
//     };
//     return Future.value(
//         Response(
//         data: {
//           'status': true,
//           'message': 'test message',
//           'data': [
//             {'id': 1, 'name': 'Item 1'},
//             {'id': 2, 'name': 'Item 2'},
//           ],
//         },
//         statusCode: 200,
//         requestOptions: RequestOptions(
//           baseUrl: ApiEndPoint.baseUrl,
//           path: ApiEndPoint.menuEndPoint.menuItemEndPoint,
//           headers: headers,
//         )));
//   }
// }
//
// void main() {
//   late MenuProvider menuProvider;
//   late MockMenuRepository mockMenuRepository;
//
//   setUp(() {
//     mockMenuRepository = MockMenuRepository();
//     menuProvider = MenuProvider();
//     menuProvider.menuRepository = mockMenuRepository;
//   });
//
//   // test group for test whole menu provider class
//
//   group("Menu Provider Tests", () {
//
//     test("initial value are correct", () {
//       expect(menuProvider.categories, []);
//       expect(menuProvider.menuitems, []);
//       expect(menuProvider.categoryName, "");
//     });
//
//     test('selectCategory should update isSelectedIndex', () {
//       menuProvider.selectCategory(3);
//       expect(menuProvider.isSelectedIndex, 3);
//     });
//
//     test('setCategoryName should update categoryName', () {
//       menuProvider.setCategoryName("pizza");
//       expect(menuProvider.categoryName, "pizza");
//     });
//
//     test('getCategories should return categories list', () async {
//       // Call the method in the MenuProvider
//       await mockMenuRepository.getCategories();
//       await menuProvider.getCategories();
//       final categories = await menuProvider.getCategories();
//
//       // Verify the expected values stored in category list
//       expect(menuProvider.categories.length, 2);
//       expect(categories.length, 2);
//       expect(menuProvider.categories[0].categoryId, 1);
//       expect(menuProvider.categories[0].categoryName, 'pizza');
//       expect(menuProvider.categories[1].categoryId, 2);
//       expect(menuProvider.categories[1].categoryName, 'burger');
//     });
//
//     test('getMenuItems should return menuItems list', () async {
//       mockMenuRepository.getMenuItems('pizza');
//       // Call the method in the MenuProvider
//       final menuItems = await menuProvider.getMenuItems('pizza');
//       // Verify the expected values stored in menuItem list
//       expect(menuProvider.menuitems.length, 2);
//       expect(menuItems.length, 2);
//       expect(menuProvider.menuitems[0].id, 1);
//       expect(menuProvider.menuitems[0].name, 'Item 1');
//       expect(menuProvider.menuitems[1].id, 2);
//       expect(menuProvider.menuitems[1].name, 'Item 2');
//     });
//   });
// }