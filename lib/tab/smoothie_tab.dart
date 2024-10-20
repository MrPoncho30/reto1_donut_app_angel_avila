import 'package:flutter/material.dart';
import 'package:reto1_donut_app_angel_avila/utils/smoothie_tile.dart';

class SmoothieTab extends StatelessWidget {
  // Lista de batidos
  final List smoothiesOnSale = [
    // [smoothieFlavor, smoothiePrice, smoothieColor, imageName]
    ["Tropical Breeze", "36", Colors.blue, "lib/images/smoothie1.png"],
    ["Berry Blast", "45", Colors.red, "lib/images/smoothie2.png"],
    ["Energy", "84", Colors.purple, "lib/images/smoothie3.png"],
    ["Magic", "95", Colors.brown, "lib/images/smoothie4.png"],
    ["Sunrise", "36", Colors.blue, "lib/images/smoothie5.png"],
    ["Power Boost", "45", Colors.red, "lib/images/smoothie6.png"],
    ["Tropical Fusion", "84", Colors.purple, "lib/images/smoothie9.png"],
    ["Dream", "95", Colors.brown, "lib/images/smoothie8.png"],
  ];

  final void Function(String price) onAdd; // Cambiamos el tipo de parámetro

  SmoothieTab({super.key, required this.onAdd});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: smoothiesOnSale.length, // Longitud de los elementos
      padding: const EdgeInsets.all(12),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Dos columnas
        childAspectRatio: 1 / 1.5,
      ),
      itemBuilder: (context, index) {
        return SmoothieTile(
          smoothieFlavor: smoothiesOnSale[index][0],
          smoothiePrice: smoothiesOnSale[index][1],
          smoothieColor: smoothiesOnSale[index][2],
          imageName: smoothiesOnSale[index][3],
          // Pasamos la función onAdd para agregar al carrito
          onAdd: () {
            onAdd(smoothiesOnSale[index]
                [1]); // Pasar el precio al presionar "Add"
          },
        );
      },
    );
  }
}
