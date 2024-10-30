import 'package:flutter/material.dart';

class PancakesTile extends StatelessWidget {
  final String pancakeFlavor;
  final String pancakePrice;
  final Color pancakeColor; // Cambiado a Color
  final String imageName;
  final VoidCallback onAdd; // Es para llamar al agregar un item al carrito

  // Valor fijo para el borde circular
  final double borderRadius = 24;

  const PancakesTile({
    super.key,
    required this.pancakeFlavor,
    required this.pancakePrice,
    required this.pancakeColor,
    required this.imageName,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Container(
        decoration: BoxDecoration(
          color: pancakeColor.withOpacity(0.1), // Color de fondo más ligero
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Column(
          children: [
            // Precio del pancake
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.end, // Alinear el precio a la derecha
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: pancakeColor
                        .withOpacity(0.2), // Color más oscuro para el precio
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
                    '\$$pancakePrice', // Precio del pancake
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: pancakeColor, // Color del texto
                    ),
                  ),
                ),
              ],
            ),

            // Imagen del pancake
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
              child: Image.asset(imageName), // Imagen del pancake
            ),

            // Texto con el sabor del pancake
            Text(
              pancakeFlavor, // Variable con el sabor del pancake
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            // Texto adicional debajo del sabor
            const Text(
              'Pancake\'s',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),

            // Espacio adicional antes de los botones
            const SizedBox(height: 10),

            // Icono de favorito + botón "Add"
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment
                    .spaceBetween, // Espaciado entre los widgets
                children: [
                  // Icono de favorito
                  const Icon(
                    Icons.favorite, // Ícono de corazón
                    color: Colors.pink, // Color del ícono
                  ),

                  // Botón "Add"
                  TextButton(
                    onPressed: onAdd, // Acción cuando se presiona el botón
                    child: const Text(
                      'Add',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.black,
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
  }
}
