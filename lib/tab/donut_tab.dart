import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Importa Firestore
import 'package:reto1_donut_app_angel_avila/utils/donut_tile.dart';

class DonutTab extends StatefulWidget {
  final void Function(String price) onAdd;

  const DonutTab({super.key, required this.onAdd});

  @override
  _DonutTabState createState() => _DonutTabState();
}

class _DonutTabState extends State<DonutTab> {
  List<QueryDocumentSnapshot> donuts = []; // Lista de donuts

  @override
  void initState() {
    super.initState();
    addDonutsToFirestore(); // Llama al método para agregar donuts al iniciar
    fetchDonuts(); // Llama al método para obtener donuts
  }

  Future<void> addDonutsToFirestore() async {
    CollectionReference donutsCollection =
        FirebaseFirestore.instance.collection('donut');

    // Datos de los donuts (incluyendo duplicados)
    List<List<dynamic>> donutData = [
      ["Ice Cream", "36", Colors.blue.value, "lib/images/icecream_donut.png"],
      ["Strawberry", "45", Colors.red.value, "lib/images/strawberry_donut.png"],
      ["Grape Ape", "84", Colors.purple.value, "lib/images/grape_donut.png"],
      ["Choco", "95", Colors.brown.value, "lib/images/chocolate_donut.png"],
      ["Menta", "36", Colors.blue.value, "lib/images/icecream_donut.png"],
      ["Explosion", "45", Colors.red.value, "lib/images/strawberry_donut.png"],
      ["Ape", "84", Colors.purple.value, "lib/images/grape_donut.png"],
      ["Cheesecake", "95", Colors.brown.value, "lib/images/chocolate_donut.png"]
    ];

    // Agregar cada donut si no existe
    for (var donut in donutData) {
      // Verificar si ya existe
      var existingDonuts = await donutsCollection
          .where('flavor', isEqualTo: donut[0]) // Verificar el sabor
          .get();

      if (existingDonuts.docs.isEmpty) {
        // Si no hay duplicados
        await donutsCollection.add({
          'flavor': donut[0],
          'price': donut[1],
          'color': donut[2], // Asumiendo que el color es un entero
          'image': donut[3],
        });
      }
    }
  }

  Future<void> fetchDonuts() async {
    FirebaseFirestore.instance
        .collection('donut')
        .snapshots()
        .listen((snapshot) {
      setState(() {
        donuts = snapshot.docs; // Actualiza la lista de donuts
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (donuts.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    return GridView.builder(
      itemCount: donuts.length,
      padding: const EdgeInsets.all(12),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1 / 1.5,
      ),
      itemBuilder: (context, index) {
        var donutData = donuts[index];

        // Asegúrate de que el campo 'color' sea un entero que representa el color
        final int colorValue =
            donutData['color'] ?? 0xFFFFFFFF; // Color por defecto (blanco)
        final Color donutColor = Color(colorValue); // Convertir int a Color

        return DonutTile(
          donutFlavor: donutData['flavor'],
          donutPrice: donutData['price'].toString(),
          donutColor: donutColor, // Pasar el objeto Color
          imageName:
              donutData['image'], // Asegúrate de que este campo sea correcto
          onAdd: () {
            widget.onAdd(donutData['price'].toString());
          },
        );
      },
    );
  }
}
