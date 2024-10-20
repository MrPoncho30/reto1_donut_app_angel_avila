import 'package:flutter/material.dart';

class PizzaTile extends StatelessWidget {
  final String pizzaFlavor;
  final String pizzaPrice;
  final dynamic pizzaColor; // Mantiene dynamic
  final String imageName;
  final VoidCallback onAdd; // Para agregar un item al carrito

  // Valor fijo para el borde circular
  final double borderRadius = 24;

  const PizzaTile({
    super.key,
    required this.pizzaFlavor,
    required this.pizzaPrice,
    required this.pizzaColor,
    required this.imageName,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Container(
        decoration: BoxDecoration(
          color: (pizzaColor is List<Color>)
              ? pizzaColor[0].withOpacity(0.1)
              : pizzaColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Column(
          children: [
            // Precio de la pizza
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: (pizzaColor is List<Color>)
                        ? pizzaColor[1].withOpacity(0.3)
                        : pizzaColor.withOpacity(0.3),
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
                    '\$$pizzaPrice',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: (pizzaColor is List<Color>)
                          ? pizzaColor[2]
                          : pizzaColor, // Acceso seguro
                    ),
                  ),
                ),
              ],
            ),

            // Imagen de la pizza
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
              child: Image.asset(imageName),
            ),

            // Sabor de la pizza
            Text(
              pizzaFlavor,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            // Texto adicional
            const Text(
              'Dunkin\'s',
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Icono de favorito
                  const Icon(
                    Icons.favorite,
                    color: Colors.pink,
                  ),

                  // Botón "Add"
                  TextButton(
                    onPressed: onAdd,
                    child: const Text(
                      'Add',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
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
