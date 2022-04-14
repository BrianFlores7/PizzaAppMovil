import 'package:pizza_app_movil/Models/order_model.dart';

abstract class OrderRepository{
  Future<List<OrderModel>> getOrderList();
  Future<String> AddOrder(OrderModel order);
}