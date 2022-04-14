import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pizza_app_movil/Models/order_model.dart';

import 'order_repository.dart';

class OrderApiRepository implements OrderRepository {
  static const String URL = "https://10.0.2.2:7140";

  @override
  Future<List<OrderModel>> getOrderList() async {
    List<OrderModel> listOrders = [];
    Uri url = Uri.parse('${URL}/orders');
    final respuesta = await http.get(url);
    var info = json.decode(respuesta.body);
    for (var item = 0; item < info.length; item++) {
      listOrders.add(OrderModel.fromJson(info[item]));
    }
    return listOrders;
  }

  @override
  Future<String> AddOrder(OrderModel order) async {
     var result = "false";
    String url = '${URL}/order';

    Map data = {
      "pizzaName": order.pizzaName,
      "pizzaDescription": order.pizzaDescription,
      "direction": order.direction,
    };
    String jsonObject = json.encode(data);
    var response = await http
        .post(Uri.parse(url),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonObject)
        .then(
      (value) {
        return result = "true";
      },
    );

    return result;
  }


}
