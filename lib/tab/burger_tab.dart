import 'package:flutter/material.dart';
import 'package:reto1_donut_app_angel_avila/utils/burger_tile.dart';

class BurgerTab extends StatelessWidget {
  // Lista de hamburguesas
  final List burgersOnSale = [
    // [burgerFlavor, burgerPrice, burgerColor, imageName]
    ["The Classic", "36", Colors.blue, "lib/images/burger1.png"],
    ["The Special", "45", Colors.red, "lib/images/burger2.png"],
    ["Double Flavor", "84", Colors.purple, "lib/images/burger3.png"],
    ["The Gourmet", "95", Colors.brown, "lib/images/veganburger.png"],
    ["Supreme Delight", "36", Colors.blue, "lib/images/burger4.png"],
    ["Roger Classic", "45", Colors.red, "lib/images/burger5.png"],
    ["Alan Classic", "84", Colors.purple, "lib/images/burger6.png"],
    ["Chucho Classic", "95", Colors.brown, "lib/images/burger7.png"],
  ];

  final void Function(String price) onAdd; // Actualizamos el tipo de parámetro

  BurgerTab({super.key, required this.onAdd});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: burgersOnSale.length, // Longitud de los elementos
      padding: const EdgeInsets.all(12),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Dos columnas
        childAspectRatio: 1 / 1.5,
      ),
      itemBuilder: (context, index) {
        return BurgerTile(
          burgerFlavor: burgersOnSale[index][0],
          burgerPrice: burgersOnSale[index][1],
          burgerColor: burgersOnSale[index][2],
          imageName: burgersOnSale[index][3],
          // Pasar la función onAdd para agregar al carrito
          onAdd: () {
            onAdd(
                burgersOnSale[index][1]); // Pasar el precio al presionar "Add"
          },
        );
      },
    );
  }
}
