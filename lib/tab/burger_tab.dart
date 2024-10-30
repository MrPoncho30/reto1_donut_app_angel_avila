import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Importa Firestore
import 'package:reto1_donut_app_angel_avila/utils/burger_tile.dart';

class BurgerTab extends StatefulWidget {
  final void Function(String price) onAdd;

  const BurgerTab({super.key, required this.onAdd});

  @override
  _BurgerTabState createState() => _BurgerTabState();
}

class _BurgerTabState extends State<BurgerTab> {
  final ScrollController _scrollController = ScrollController();
  List<QueryDocumentSnapshot> burgers = []; // Lista de hamburguesas

  @override
  void initState() {
    super.initState();
    addBurgersToFirestore(); // Llama al método para agregar hamburguesas al iniciar
    fetchBurgers(); // Llama al método para obtener hamburguesas
  }

  Future<void> addBurgersToFirestore() async {
    CollectionReference burgersCollection =
        FirebaseFirestore.instance.collection('burger');

    // Datos de las hamburguesas (incluyendo duplicados)
    List<List<dynamic>> burgerData = [
      ["The Classic", "36", Colors.blue.value, "lib/images/burger1.png"],
      ["The Special", "45", Colors.red.value, "lib/images/burger2.png"],
      ["Double Flavor", "84", Colors.purple.value, "lib/images/burger3.png"],
      ["The Gourmet", "95", Colors.brown.value, "lib/images/veganburger.png"],
      ["Supreme Delight", "36", Colors.blue.value, "lib/images/burger4.png"],
      ["Roger Classic", "45", Colors.red.value, "lib/images/burger5.png"],
      ["Alan Classic", "84", Colors.purple.value, "lib/images/burger6.png"],
      ["Chucho Classic", "95", Colors.brown.value, "lib/images/burger7.png"],
    ];

    // Agregar cada hamburguesa si no existe
    for (var burger in burgerData) {
      // Verificar si ya existe
      var existingBurgers = await burgersCollection
          .where('flavor', isEqualTo: burger[0]) // Verificar el sabor
          .get();

      if (existingBurgers.docs.isEmpty) {
        // Si no hay duplicados
        await burgersCollection.add({
          'flavor': burger[0],
          'price': burger[1],
          'color': burger[2], // Asumiendo que el color es un entero
          'image': burger[3],
        });
      }
    }
  }

  Future<void> fetchBurgers() async {
    FirebaseFirestore.instance
        .collection('burger')
        .snapshots()
        .listen((snapshot) {
      setState(() {
        burgers = snapshot.docs; // Actualiza la lista de hamburguesas
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (burgers.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    return GridView.builder(
      controller: _scrollController, // Asocia el ScrollController
      itemCount: burgers.length,
      padding: const EdgeInsets.all(12),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1 / 1.5,
      ),
      itemBuilder: (context, index) {
        var burgerData = burgers[index];

        // Asegúrate de que el campo 'color' sea un entero que representa el color
        final int colorValue =
            burgerData['color'] ?? 0xFFFFFFFF; // Color por defecto (blanco)
        final Color burgerColor = Color(colorValue); // Convertir int a Color

        return BurgerTile(
          burgerFlavor: burgerData['flavor'],
          burgerPrice: burgerData['price'].toString(),
          burgerColor: burgerColor, // Pasar el objeto Color
          imageName:
              burgerData['image'], // Asegúrate de que este campo sea correcto
          onAdd: () {
            widget.onAdd(burgerData['price'].toString());
          },
        );
      },
    );
  }

  @override
  void dispose() {
    _scrollController
        .dispose(); // Limpia el controlador cuando el widget se elimina
    super.dispose();
  }
}
