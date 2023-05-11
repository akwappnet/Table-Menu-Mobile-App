import 'package:flutter/cupertino.dart';
import 'package:table_menu_customer/repository/order_repository.dart';
import 'package:table_menu_customer/utils/routes/routes_name.dart';


class OrderProvider extends ChangeNotifier {


  final OrderRepository _orderRepository = OrderRepository();

  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> placeOrder(BuildContext context, dynamic data) async {

    setLoading(true);
    var result = await _orderRepository.placeOrder(data);
    print(result.data);
    if(result.data['status'] == true) {
      Navigator.pushNamed(context, RoutesName.ORDER_SCREEN_ROUTE);
    }else if (result.data['status'] == "False"){
      setLoading(false);
      // TODO show error message to user
      print("status : ${result.data['status']}");
    }
  }


}