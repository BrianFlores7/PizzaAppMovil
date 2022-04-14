import 'package:pizza_app_movil/Models/order_model.dart';


import 'order_repository.dart';

class OrderController {
  final OrderRepository _repository;

  OrderController(this._repository);

  Future<List<OrderModel>> fetchListOrder() async {
    return _repository.getOrderList();
  }
  Future<String> AddOrderToList(OrderModel order) async {
    return _repository.AddOrder(order);
  }
}