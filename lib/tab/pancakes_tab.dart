import 'package:flutter/material.dart';
import 'package:reto1_donut_app_angel_avila/utils/pancakes_tile.dart';

class PancakesTab extends StatelessWidget {
  // List of pancakes
  final List pancakesOnSale = [
    // [pancakeFlavor, pancakePrice, pancakeColor, imageName]
    ["Classic", "36", Colors.blue, "lib/images/pancake1.png"],
    ["Strawberry", "45", Colors.red, "lib/images/pancake2.png"],
    ["Chocolate Chip", "84", Colors.brown, "lib/images/pancake3.png"],
    ["Blueberry", "95", Colors.blueAccent, "lib/images/pancake4.png"],
    ["Banana", "36", Colors.yellow, "lib/images/pancake5.png"],
    ["Nutella", "45", Colors.brown, "lib/images/pancake6.png"],
    ["Cinnamon", "84", Colors.orange, "lib/images/pancake7.png"],
    ["Vegan", "95", Colors.green, "lib/images/pancake8.png"],
  ];

  final void Function(String price) onAdd; // Almacena la función onAdd

  PancakesTab({super.key, required this.onAdd});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: pancakesOnSale.length, // Longitud de los elementos.
      padding: const EdgeInsets.all(12),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, childAspectRatio: 1 / 1.5), // Dos Columnas
      itemBuilder: (context, index) {
        return PancakesTile(
          pancakeFlavor: pancakesOnSale[index][0],
          pancakePrice: pancakesOnSale[index][1],
          pancakeColor: pancakesOnSale[index][2],
          imageName: pancakesOnSale[index][3],
          onAdd: () =>
              onAdd(pancakesOnSale[index][1]), // Pasar el precio al callback
        );
      },
    );
  }
}
