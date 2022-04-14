import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pizza_app_movil/Models/pizza_model.dart';
import 'package:pizza_app_movil/Repository/pizza_repository.dart';

class PizzaApiRepository implements PizzaRepository {
  static const String URL = "https://10.0.2.2:7140";

  @override
  Future<List<PizzaModel>> getPizzaList() async {
    List<PizzaModel> listPizzas = [];
    Uri url = Uri.parse('${URL}/pizzas');
    final respuesta = await http.get(url);
    var info = json.decode(respuesta.body);
    for (var item = 0; item < info.length; item++) {
      listPizzas.add(PizzaModel.fromJson(info[item]));
    }
    return listPizzas;
  }

  @override
  Future<String> deleteFromListPizza(PizzaModel pizza) async {
    var result = "false";
    int? pizzaId = pizza.id;
    String url = '${URL}/pizza/${pizzaId}';
    var response = await http.delete(Uri.parse(url)).then(
      (value) {
        return result = "true";
      },
    );
    return result;
  }

  @override
  Future<String> addPizza(PizzaModel pizza) async {
    var result = "false";
    String url = '${URL}/pizza';

    Map data = {
      'name': pizza.name,
      'description': pizza.description,
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

  @override
  Future<String> editPizza(PizzaModel pizza) async {
    var result = "false";
    String url = '${URL}/pizza/${pizza.id}';

    Map data = {
      'name': pizza.name,
      'description': pizza.description,
    };
    String jsonObject = json.encode(data);
    var response = await http
        .put(Uri.parse(url),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonObject)
        .then(
      (value) {
        return result = "true";
      },
    );
    print(result);
    return result;
  }
}
