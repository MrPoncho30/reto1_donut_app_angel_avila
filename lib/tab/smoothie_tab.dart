import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Importa Firestore
import 'package:reto1_donut_app_angel_avila/utils/smoothie_tile.dart';

class SmoothieTab extends StatefulWidget {
  final void Function(String price) onAdd; // Función para agregar al carrito

  const SmoothieTab({super.key, required this.onAdd});

  @override
  _SmoothieTabState createState() => _SmoothieTabState();
}

class _SmoothieTabState extends State<SmoothieTab> {
  List<QueryDocumentSnapshot> smoothies = []; // Lista de smoothies

  @override
  void initState() {
    super.initState();
    addSmoothiesToFirestore(); // Llama al método para agregar smoothies al iniciar
    fetchSmoothies(); // Llama al método para obtener smoothies
  }

  Future<void> addSmoothiesToFirestore() async {
    CollectionReference smoothiesCollection =
        FirebaseFirestore.instance.collection('smoothies');

    // Datos de los smoothies (incluyendo duplicados)
    List<List<dynamic>> smoothieData = [
      ["Tropical Breeze", "36", Colors.blue.value, "lib/images/smoothie1.png"],
      ["Berry Blast", "45", Colors.red.value, "lib/images/smoothie2.png"],
      ["Energy", "84", Colors.purple.value, "lib/images/smoothie3.png"],
      ["Magic", "95", Colors.brown.value, "lib/images/smoothie4.png"],
      ["Sunrise", "36", Colors.blue.value, "lib/images/smoothie5.png"],
      ["Power Boost", "45", Colors.red.value, "lib/images/smoothie6.png"],
      [
        "Tropical Fusion",
        "84",
        Colors.purple.value,
        "lib/images/smoothie9.png"
      ],
      ["Dream", "95", Colors.brown.value, "lib/images/smoothie8.png"],
    ];

    // Agregar cada smoothie si no existe
    for (var smoothie in smoothieData) {
      // Verificar si ya existe
      var existingSmoothies = await smoothiesCollection
          .where('flavor', isEqualTo: smoothie[0]) // Verificar el sabor
          .get();

      if (existingSmoothies.docs.isEmpty) {
        // Si no hay duplicados
        await smoothiesCollection.add({
          'flavor': smoothie[0],
          'price': smoothie[1],
          'color': smoothie[2], // Asumiendo que el color es un entero
          'image': smoothie[3],
        });
      }
    }
  }

  Future<void> fetchSmoothies() async {
    FirebaseFirestore.instance
        .collection('smoothies')
        .snapshots()
        .listen((snapshot) {
      setState(() {
        smoothies = snapshot.docs; // Actualiza la lista de smoothies
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (smoothies.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    return GridView.builder(
      itemCount: smoothies.length,
      padding: const EdgeInsets.all(12),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Dos columnas
        childAspectRatio: 1 / 1.5,
      ),
      itemBuilder: (context, index) {
        var smoothieData = smoothies[index];

        // Asegúrate de que el campo 'color' sea un entero que representa el color
        final int colorValue =
            smoothieData['color'] ?? 0xFFFFFFFF; // Color por defecto (blanco)
        final Color smoothieColor = Color(colorValue); // Convertir int a Color

        return SmoothieTile(
          smoothieFlavor: smoothieData['flavor'],
          smoothiePrice: smoothieData['price'].toString(),
          smoothieColor: smoothieColor, // Pasar el objeto Color
          imageName:
              smoothieData['image'], // Asegúrate de que este campo sea correcto
          onAdd: () {
            widget.onAdd(smoothieData['price'].toString());
          },
        );
      },
    );
  }
}
