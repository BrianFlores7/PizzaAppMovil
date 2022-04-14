import 'package:flutter/material.dart';
import 'package:pizza_app_movil/main.dart';
import 'package:pizza_app_movil/Repository/pizza_api.dart';
import 'package:pizza_app_movil/Repository/pizza_controller.dart';
import 'package:pizza_app_movil/Models/pizza_model.dart';

class AddPizzaView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var listPizzaController = PizzaController(PizzaApiRepository());
    TextEditingController _textControllerName = TextEditingController(text: "");
    TextEditingController _textControllerDescription =
        TextEditingController(text: "");
    return MaterialApp(
      title: "Add pizza",
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Add pizza"),
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
                          hintText: "Veggie Pizza"),
                    ),
                  ],
                )),
            Container(
              padding: EdgeInsets.all(17),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 300),
                    child: const Text(
                      "Pizza's description",
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
                        hintText: "A delicious pizza"),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: 10,
                left: 50,
                right: 50,
              ),
              child: ElevatedButton(
                onPressed: () {
                  PizzaModel pizza = PizzaModel(_textControllerName.text,
                      _textControllerDescription.text);
                  listPizzaController.addPizzaToList(pizza);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyApp(),
                    ),
                  );
                },
                child: const Text("Agregar", style: TextStyle(fontSize: 18)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
