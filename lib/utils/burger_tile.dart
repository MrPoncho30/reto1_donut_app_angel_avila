import 'package:flutter/material.dart';

class BurgerTile extends StatelessWidget {
  final String burgerFlavor;
  final String burgerPrice;
  final Color burgerColor; // Cambiado a Color
  final String imageName;
  final VoidCallback onAdd; // Es para llamar al agregar un item al carrito

  // Valor fijo para el borde circular
  final double borderRadius = 24;

  const BurgerTile({
    super.key,
    required this.burgerFlavor,
    required this.burgerPrice,
    required this.burgerColor,
    required this.imageName,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Container(
        decoration: BoxDecoration(
          color: burgerColor.withOpacity(0.1), // Color de fondo más ligero
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Column(
          children: [
            // Precio de la hamburguesa
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.end, // Alinear el precio a la derecha
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: burgerColor
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
                    '\$$burgerPrice', // Precio de la hamburguesa
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: burgerColor, // Color del texto
                    ),
                  ),
                ),
              ],
            ),

            // Imagen de la hamburguesa
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
              child: Image.asset(imageName), // Imagen de la hamburguesa
            ),

            // Texto con el sabor de la hamburguesa
            Text(
              burgerFlavor, // Variable con el sabor de la hamburguesa
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            // Texto adicional debajo del sabor
            const Text(
              'Burger\'s',
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
                    onPressed:
                        // Acción cuando se presiona el botón
                        onAdd,
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
