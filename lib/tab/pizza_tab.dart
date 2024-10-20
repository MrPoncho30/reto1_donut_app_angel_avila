import 'package:flutter/material.dart';
import 'package:reto1_donut_app_angel_avila/utils/pizza_tile.dart';

class PizzaTab extends StatelessWidget {
  // List of pizzas
  final List pizzaOnSale = [
    // [pizzaFlavor, pizzaPrice, pizzaColor, imageName]
    ["Margherita", "36", Colors.red, "lib/images/pizza1.png"],
    ["Pepperoni", "45", Colors.redAccent, "lib/images/pizza2.png"],
    ["BBQ Chicken", "84", Colors.brown, "lib/images/pizza3.png"],
    ["Vegetarian", "95", Colors.green, "lib/images/pizza4.png"],
    ["Hawaiian", "36", Colors.yellow, "lib/images/pizza5.png"],
    ["Meat Lovers", "45", Colors.orange, "lib/images/pizza6.png"],
    ["Seafood", "84", Colors.blue, "lib/images/pizza7.png"],
    ["Cheese", "95", Colors.grey, "lib/images/pizza8.png"],
  ];

  final void Function(String price) onAdd; // Almacena la función onAdd

  PizzaTab({super.key, required this.onAdd});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: pizzaOnSale.length, // Longitud de los elementos
      padding: const EdgeInsets.all(12),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Dos columnas
        childAspectRatio: 1 / 1.5,
      ),
      itemBuilder: (context, index) {
        return PizzaTile(
          pizzaFlavor: pizzaOnSale[index][0],
          pizzaPrice: pizzaOnSale[index][1],
          pizzaColor: pizzaOnSale[index][2],
          imageName: pizzaOnSale[index][3],
          // Pasamos la función onAdd para agregar al carrito
          onAdd: () {
            onAdd(pizzaOnSale[index][1]); // Pasar el precio al presionar "Add"
          },
        );
      },
    );
  }
}
