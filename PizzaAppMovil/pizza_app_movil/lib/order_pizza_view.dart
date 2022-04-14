import 'package:flutter/material.dart';
import 'package:pizza_app_movil/Models/order_model.dart';
import 'package:pizza_app_movil/main.dart';
import 'package:pizza_app_movil/Models/pizza_model.dart';

import 'Repository/order_api.dart';
import 'Repository/order_controller.dart';

class OrderPizzaView extends StatelessWidget {
  PizzaModel? model;
  OrderPizzaView(this.model);
  @override
  Widget build(BuildContext context) {
    var listOrderController = OrderController(OrderApiRepository());
    TextEditingController _textControllerName =
        TextEditingController(text: model?.name);
    TextEditingController _textControllerDescription =
        TextEditingController(text: model?.description);
    TextEditingController _textControllerAdress =
        TextEditingController();
    return MaterialApp(
      title: "Order Pizza",
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Order"),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyApp(),
                  ),
                );
              },
              icon: const Icon(Icons.arrow_back),
            ),
          ],
        ),
        body: ListView(
          children: [
            Container(
              padding: EdgeInsets.all(17),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 270),
                    child: const Text(
                      "Pizza's name",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  TextField(
                    controller: _textControllerName,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        fillColor: Colors.grey[300],
                        filled: true,
                        hintText: model?.name),
                    enabled: false,
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(17),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 290),
                    child: const Text(
                      "Description ",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  TextField(
                    controller: _textControllerDescription,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        fillColor: Colors.grey[300],
                        filled: true,
                        hintText: model?.description),
                    enabled: false,
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(17),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 320),
                    child: const Text(
                      "Adress",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  TextField(
                    controller: _textControllerAdress,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      fillColor: Colors.grey[300],
                      filled: true,
                      hintText: "Adress",
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                top: 10,
                left: 50,
                right: 50,
              ),
              child: ElevatedButton(
                onPressed: () {
                  PizzaModel pizza = PizzaModel(_textControllerName.text,
                      _textControllerDescription.text, model?.id);
                  OrderModel order = OrderModel(pizza.name, pizza.description,
                      _textControllerAdress.text);
                  listOrderController.AddOrderToList(order);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyApp(),
                    ),
                  );
                },
                child: const Text("Order", style: TextStyle(fontSize: 18)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
