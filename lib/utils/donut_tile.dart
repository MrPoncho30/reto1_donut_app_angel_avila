import 'package:flutter/material.dart';

class DonutTile extends StatelessWidget {
  final String donutFlavor;
  final String donutPrice;
  final dynamic donutColor; // Dynamic porque será tipo Color y también usará[]
  final String imageName;

  // Valor fijo para el borde circular
  final double borderRadius = 24;

  const DonutTile({
    super.key,
    required this.donutFlavor,
    required this.donutPrice,
    required this.donutColor,
    required this.imageName,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Container(
        decoration: BoxDecoration(
          color: donutColor[50],
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Column(
          children: [
            // Donut Price
            Row(
              // Alinear el precio a la derecha
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: donutColor[100],
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(borderRadius),
                      bottomLeft: Radius.circular(borderRadius),
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 18,
                  ),
                  child: Text(
                    '\$$donutPrice',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: donutColor[800],
                    ),
                  ),
                ),
              ],
            ),

            // Donut picture
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
              child: Image.asset(imageName),
            ),

            // Donut Flavor Text
            Text(
              donutFlavor, // Variable con el sabor del donut
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            // Texto adicional debajo del sabor
            const Text(
              'Dunkin\'s',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),

            // Espacio adicional antes de los botones
            const SizedBox(height: 10),

            // Love icon + add button"
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment
                    .spaceBetween, // Espaciado entre los widgets
                children: [
                  // Icono de favorito
                  Icon(
                    Icons.favorite, // Ícono de corazón vacío
                    color: Colors.pink, //
                  ),

                  // Texto "Add"
                  Text(
                    'Add',
                    style: TextStyle(
                        color: Colors.black, // Color para el texto
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.black),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
