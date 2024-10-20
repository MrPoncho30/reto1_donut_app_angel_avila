import 'package:flutter/material.dart';
import 'package:reto1_donut_app_angel_avila/tab/burger_tab.dart';
import 'package:reto1_donut_app_angel_avila/tab/donut_tab.dart';
import 'package:reto1_donut_app_angel_avila/tab/pancakes_tab.dart';
import 'package:reto1_donut_app_angel_avila/tab/pizza_tab.dart';
import 'package:reto1_donut_app_angel_avila/tab/smoothie_tab.dart';
import 'package:reto1_donut_app_angel_avila/utils/my_tab.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Lista para almacenar los precios de los ítems añadidos al carrito
  List<double> cartPrices = [];
  int itemCount = 0; // Cantidad de ítems en el carrito

  // Métodos para actualizar el carrito
  void addItemToCart(double price) {
    setState(() {
      cartPrices.add(price);
      itemCount++;
    });
  }

  // Calcular el precio total sumando todos los ítems
  double get totalPrice => cartPrices.fold(0, (sum, item) => sum + item);
  List<Widget> myTabs = [
    // Donut tab
    const MyTab(iconPath: 'lib/icons/donut.png', name: 'Donuts'),

    // Burger tab
    const MyTab(iconPath: 'lib/icons/burger.png', name: 'Burgers'),

    // Smoothie tab
    const MyTab(iconPath: 'lib/icons/smoothie.png', name: 'Smoothies'),

    // Pancakes tab
    const MyTab(iconPath: 'lib/icons/pancakes.png', name: 'Pancakes'),

    // Pizza tab
    const MyTab(iconPath: 'lib/icons/pizza.png', name: 'Pizza'),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: myTabs.length,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: Padding(
            padding: const EdgeInsets.only(left: 24.0),
            child: IconButton(
              icon: Icon(Icons.menu, color: Colors.grey[800], size: 36),
              onPressed: () {
                print('Botón de Menú');
              },
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 24.0),
              child: IconButton(
                icon: Icon(Icons.person, color: Colors.grey[800], size: 36),
                onPressed: () {
                  print('Botón de Usuario');
                },
              ),
            )
          ],
        ),
        body: Column(children: [
          //TEXTO "I want to eat"
          const Padding(
            padding: EdgeInsets.all(24.0),
            child: Row(
              children: [
                Text("I want to ", style: TextStyle(fontSize: 32)),
                Text("Eat",
                    style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline)),
              ],
            ),
          ),
          //Tap Bar
          TabBar(tabs: myTabs),
          //Tap bar view
          Expanded(
            child: TabBarView(children: [
              // Donut tab
              DonutTab(
                onAdd: (price) => addItemToCart(double.parse(price)),
              ),

              // Burger tab
              BurgerTab(
                onAdd: (price) => addItemToCart(double.parse(price)),
              ),

              // Smoothie tab
              SmoothieTab(
                onAdd: (price) => addItemToCart(double.parse(price)),
              ),

              // Pancakes tab
              PancakesTab(
                onAdd: (price) => addItemToCart(double.parse(price)),
              ),

              // Pizza tab
              PizzaTab(
                onAdd: (price) => addItemToCart(double.parse(price)),
              ),
            ]),
          ),

          // Contenedor del carrito
          Container(
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Información de items y precio
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$itemCount Items | \$${totalPrice.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Delivery Charges Included',
                      style: TextStyle(fontSize: 18, color: Colors.grey[900]),
                    ),
                  ],
                ),
                // Botón "View Cart"
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink, // Color del botón
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(35),
                    ),
                  ),
                  onPressed: () {
                    // Acción al presionar el botón
                  },
                  child: const Text(
                    'View Cart',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
