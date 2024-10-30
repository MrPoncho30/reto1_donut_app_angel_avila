import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Importa Firestore
import 'package:reto1_donut_app_angel_avila/utils/pancakes_tile.dart';

class PancakesTab extends StatefulWidget {
  final void Function(String price) onAdd;

  const PancakesTab({super.key, required this.onAdd});

  @override
  _PancakesTabState createState() => _PancakesTabState();
}

class _PancakesTabState extends State<PancakesTab> {
  List<QueryDocumentSnapshot> pancakes = []; // Lista de pancakes

  @override
  void initState() {
    super.initState();
    addPancakesToFirestore(); // Llama al método para agregar pancakes al iniciar
    fetchPancakes(); // Llama al método para obtener pancakes
  }

  Future<void> addPancakesToFirestore() async {
    CollectionReference pancakesCollection =
        FirebaseFirestore.instance.collection('pancakes');

    // Datos de los pancakes (incluyendo duplicados)
    List<List<dynamic>> pancakeData = [
      ["Buttermilk", "30", Colors.yellow.value, "lib/images/pancake1.png"],
      ["Chocolate Chip", "35", Colors.brown.value, "lib/images/pancake2.png"],
      ["Blueberry", "40", Colors.blue.value, "lib/images/pancake3.png"],
      [
        "Banana Nut",
        "45",
        Colors.yellowAccent.value,
        "lib/images/pancake4.png"
      ],
      ["Red Velvet", "50", Colors.red.value, "lib/images/pancake5.png"],
      ["Lemon Zest", "30", Colors.orange.value, "lib/images/pancake6.png"],
      [
        "Carrot Cake",
        "40",
        Colors.orangeAccent.value,
        "lib/images/pancake7.png"
      ],
      ["Pineapple", "45", Colors.yellow.value, "lib/images/pancake8.png"],
    ];

    // Agregar cada pancake si no existe
    for (var pancake in pancakeData) {
      // Verificar si ya existe
      var existingPancakes = await pancakesCollection
          .where('flavor', isEqualTo: pancake[0]) // Verificar el sabor
          .get();

      if (existingPancakes.docs.isEmpty) {
        // Si no hay duplicados
        await pancakesCollection.add({
          'flavor': pancake[0],
          'price': pancake[1],
          'color': pancake[2], // Asumiendo que el color es un entero
          'image': pancake[3],
        });
      }
    }
  }

  Future<void> fetchPancakes() async {
    FirebaseFirestore.instance
        .collection('pancakes')
        .snapshots()
        .listen((snapshot) {
      setState(() {
        pancakes = snapshot.docs; // Actualiza la lista de pancakes
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (pancakes.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    return GridView.builder(
      itemCount: pancakes.length,
      padding: const EdgeInsets.all(12),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1 / 1.5,
      ),
      itemBuilder: (context, index) {
        var pancakeData = pancakes[index];

        // Asegúrate de que el campo 'color' sea un entero que representa el color
        final int colorValue =
            pancakeData['color'] ?? 0xFFFFFFFF; // Color por defecto (blanco)
        final Color pancakeColor = Color(colorValue); // Convertir int a Color

        return PancakesTile(
          pancakeFlavor: pancakeData['flavor'],
          pancakePrice: pancakeData['price'].toString(),
          pancakeColor: pancakeColor, // Pasar el objeto Color
          imageName:
              pancakeData['image'], // Asegúrate de que este campo sea correcto
          onAdd: () {
            widget.onAdd(pancakeData['price'].toString());
          },
        );
      },
    );
  }
}
