import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pizza_app_movil/Repository/pizza_api.dart';
import 'package:pizza_app_movil/Repository/pizza_controller.dart';
import 'package:pizza_app_movil/Models/pizza_model.dart';

import 'Models/order_model.dart';
import 'Repository/order_api.dart';
import 'Repository/order_controller.dart';
import 'add_pizza_view.dart';
import 'edit_pizza_view.dart';
import 'order_pizza_view.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  HttpOverrides.global = new MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pizza',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Pizza'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  FutureBuilder<List<OrderModel>> ListOrderWidget(OrderController listOrderController) {
    return FutureBuilder<List<OrderModel>>(
            future: listOrderController.fetchListOrder(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasError) {
                return const Center(
                  child: Text("Error"),
                );
              }
              return ListView.separated(
                  itemBuilder: (context, index) {
                    var listPizzas = snapshot.data?[index];
                    return Container(
                      height: 150,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              offset: Offset(0.0, 100),
                              blurRadius: 20.0,
                            ),
                          ],
                        ),
                        margin: const EdgeInsets.only(top: 20),
                        child: Column(
                          children: [
                            Expanded(
                                flex: 2,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 18.0),
                                  child: Text(
                                    "Pizza's Name: ${listPizzas?.pizzaName}",
                                    style: const TextStyle(
                                      fontSize: 18,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                )),
                            Expanded(
                              flex: 3,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 18.0, right: 18.0),
                                child: Text(
                                  "Direction: ${listPizzas?.direction}",
                                  style: TextStyle(fontSize: 18),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const Divider(thickness: 0.5, height: 0.5);
                  },
                  itemCount: snapshot.data?.length ?? 0);
            },
          );
  }

  FutureBuilder<List<PizzaModel>> ListPizzaWidget(
      PizzaController listPizzaController) {
    return FutureBuilder<List<PizzaModel>>(
      future: listPizzaController.fetchListPizza(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasError) {
          return const Center(
            child: Text("Error"),
          );
        }
        return ListView.separated(
            itemBuilder: (context, index) {
              var listPizzas = snapshot.data?[index];
              return Container(
                height: 150,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        offset: Offset(0.0, 100),
                        blurRadius: 20.0,
                      ),
                    ],
                  ),
                  margin: const EdgeInsets.only(top: 20),
                  child: Column(
                    children: [
                      Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 18.0),
                            child: Text(
                              "Pizza's Name: ${listPizzas?.name}",
                              style: const TextStyle(
                                fontSize: 18,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          )),
                      Expanded(
                        flex: 3,
                        child: Padding(
                          padding:
                              const EdgeInsets.only(left: 18.0, right: 18.0),
                          child: Text(
                            "Pizza's description: ${listPizzas?.description}",
                            style: TextStyle(fontSize: 18),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(
                                  top: 5, left: 10, right: 20),
                              width: 100,
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          EditPizzaView(listPizzas),
                                    ),
                                  );
                                },
                                child: buildCallContainer(
                                  "Edit",
                                  Colors.greenAccent,
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(
                                  top: 5, left: 20, right: 20),
                              width: 100,
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    listPizzaController
                                        .deletePizza(listPizzas!)
                                        .then((value) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          duration:
                                              const Duration(milliseconds: 700),
                                          content: Text("${value}"),
                                        ),
                                      );
                                    });
                                  });
                                },
                                child: buildCallContainer(
                                  "Delete",
                                  Colors.redAccent,
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(
                                  top: 5, left: 20, right: 20),
                              width: 60,
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          OrderPizzaView(listPizzas),
                                    ),
                                  );
                                },
                                child: buildCallContainer(
                                  "Order",
                                  Colors.yellowAccent,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const Divider(thickness: 0.5, height: 0.5);
            },
            itemCount: snapshot.data?.length ?? 0);
      },
    );
  }

  Container buildCallContainer(String title, Color color) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          "${title}",
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var listPizzaController = PizzaController(PizzaApiRepository());
    listPizzaController.fetchListPizza();
    var listOrderController = OrderController(OrderApiRepository());
    listOrderController.fetchListOrder();

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Pizzas"),
          actions: [
            IconButton(
              onPressed: () {
                setState(() {});
              },
              icon: const Icon(Icons.refresh),
            ),
          ],
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.local_pizza_outlined)),
              Tab(icon: Icon(Icons.directions_bike_rounded)),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ListPizzaWidget(listPizzaController),
            ListOrderWidget(listOrderController),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddPizzaView(),
              ),
            );
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
