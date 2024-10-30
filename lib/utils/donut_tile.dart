import 'package:flutter/material.dart';

class DonutTile extends StatelessWidget {
  final String donutFlavor;
  final String donutPrice;
  final Color donutColor; // Cambiado a Color
  final String imageName;
  final VoidCallback onAdd; // Para llamar al agregar un item al carrito
  final double borderRadius = 24; // Valor fijo para el borde circular

  const DonutTile({
    super.key,
    required this.donutFlavor,
    required this.donutPrice,
    required this.donutColor, // Ahora es de tipo Color
    required this.imageName,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Container(
        decoration: BoxDecoration(
          color: donutColor.withOpacity(0.2), // Color de fondo con opacidad
          borderRadius:
              BorderRadius.circular(borderRadius), // Bordes redondeados
        ),
        child: Column(
          children: [
            // Precio del donut
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: donutColor
                        .withOpacity(0.1), // Color del contenedor del precio
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(borderRadius),
                      bottomLeft: Radius.circular(borderRadius),
                    ),
                  ),
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 18),
                  child: Text(
                    '\$$donutPrice', // Formato del precio
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: donutColor, // Color del texto del precio
                    ),
                  ),
                ),
              ],
            ),

            // Imagen del donut
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
              child: Image.asset(
                imageName,
                height: 140, // Establece una altura para la imagen
                fit: BoxFit.cover, // Ajusta la imagen para que cubra el espacio
              ),
            ),

            // Texto del sabor del donut
            Text(
              donutFlavor,
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
                    onPressed: onAdd, // Acción al presionar el botón
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
