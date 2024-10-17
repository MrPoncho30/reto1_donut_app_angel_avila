import 'package:flutter/material.dart';
import 'package:reto1_donut_app_angel_avila/utils/donut_tile.dart';

class DonutTab extends StatelessWidget {
  //List of donuts
  final List donutOnSale = [
    //[danutFlavor, donutPrice, donutColor, imageName]
    ["Ice Cream", "36", Colors.blue, "lib/images/icecream_donut.png"],
    ["Strawberry", "45", Colors.red, "lib/images/strawberry_donut.png"],
    ["Grape Ape", "84", Colors.purple, "lib/images/grape_donut.png"],
    ["Choco", "95", Colors.brown, "lib/images/chocolate_donut.png"],
    ["Ice Cream", "36", Colors.blue, "lib/images/icecream_donut.png"],
    ["Strawberry", "45", Colors.red, "lib/images/strawberry_donut.png"],
    ["Grape Ape", "84", Colors.purple, "lib/images/grape_donut.png"],
    ["Choco", "95", Colors.brown, "lib/images/chocolate_donut.png"]
  ];

  DonutTab({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: donutOnSale.length, //Longitud de los elementos.
      padding: const EdgeInsets.all(12),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, childAspectRatio: 1 / 1.5), //Dos Columnas
      itemBuilder: (context, index) {
        return DonutTile(
          donutFlavor: donutOnSale[index][0],
          donutPrice: donutOnSale[index][1],
          donutColor: donutOnSale[index][2],
          imageName: donutOnSale[index][3],
        );
      },
    );
  }
}
