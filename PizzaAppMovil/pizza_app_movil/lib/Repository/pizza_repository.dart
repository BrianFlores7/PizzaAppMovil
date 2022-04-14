import 'package:pizza_app_movil/Models/pizza_model.dart';

abstract class PizzaRepository{
  Future<List<PizzaModel>> getPizzaList();
  Future<String> deleteFromListPizza(PizzaModel pizza); 
  Future<String> addPizza(PizzaModel pizza); 
  Future<String> editPizza(PizzaModel pizza); 
}