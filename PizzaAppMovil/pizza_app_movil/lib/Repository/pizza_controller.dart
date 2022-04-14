import 'package:pizza_app_movil/Models/pizza_model.dart';
import 'package:pizza_app_movil/Repository/pizza_repository.dart';

class PizzaController {
  final PizzaRepository _repository;

  PizzaController(this._repository);

  Future<List<PizzaModel>> fetchListPizza() async {
    return _repository.getPizzaList();
  }

  Future<String> deletePizza(PizzaModel pizza) async {
    return _repository.deleteFromListPizza(pizza);
  }

  Future<String> addPizzaToList(PizzaModel pizza) async {
    return _repository.addPizza(pizza);
  }
  Future<String> editPizzaFromList(PizzaModel pizza) async {
    return _repository.editPizza(pizza);
  }
}
