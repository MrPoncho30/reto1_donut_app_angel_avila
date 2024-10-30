import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Importa Firestore
import 'package:reto1_donut_app_angel_avila/utils/pizza_tile.dart';

class PizzaTab extends StatefulWidget {
  final void Function(String price) onAdd; // Función para agregar al carrito

  const PizzaTab({super.key, required this.onAdd});

  @override
  _PizzaTabState createState() => _PizzaTabState();
}

class _PizzaTabState extends State<PizzaTab> {
  List<QueryDocumentSnapshot> pizzas = []; // Lista de pizzas

  @override
  void initState() {
    super.initState();
    addPizzasToFirestore(); // Llama al método para agregar pizzas al iniciar
    fetchPizzas(); // Llama al método para obtener pizzas
  }

  Future<void> addPizzasToFirestore() async {
    CollectionReference pizzasCollection =
        FirebaseFirestore.instance.collection('pizzas');

    // Datos de las pizzas (incluyendo duplicados)
    List<List<dynamic>> pizzaData = [
      ["Margherita", "36", Colors.red.value, "lib/images/pizza1.png"],
      ["Pepperoni", "45", Colors.redAccent.value, "lib/images/pizza2.png"],
      ["BBQ Chicken", "84", Colors.brown.value, "lib/images/pizza3.png"],
      ["Vegetarian", "95", Colors.green.value, "lib/images/pizza4.png"],
      ["Hawaiian", "36", Colors.yellow.value, "lib/images/pizza5.png"],
      ["Meat Lovers", "45", Colors.orange.value, "lib/images/pizza6.png"],
      ["Seafood", "84", Colors.blue.value, "lib/images/pizza7.png"],
      ["Cheese", "95", Colors.grey.value, "lib/images/pizza8.png"],
    ];

    // Agregar cada pizza si no existe
    for (var pizza in pizzaData) {
      // Verificar si ya existe
      var existingPizzas = await pizzasCollection
          .where('flavor', isEqualTo: pizza[0]) // Verificar el sabor
          .get();

      if (existingPizzas.docs.isEmpty) {
        // Si no hay duplicados
        await pizzasCollection.add({
          'flavor': pizza[0],
          'price': pizza[1],
          'color': pizza[2], // Asumiendo que el color es un entero
          'image': pizza[3],
        });
      }
    }
  }

  Future<void> fetchPizzas() async {
    FirebaseFirestore.instance
        .collection('pizzas')
        .snapshots()
        .listen((snapshot) {
      setState(() {
        pizzas = snapshot.docs; // Actualiza la lista de pizzas
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (pizzas.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    return GridView.builder(
      itemCount: pizzas.length,
      padding: const EdgeInsets.all(12),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Dos columnas
        childAspectRatio: 1 / 1.5,
      ),
      itemBuilder: (context, index) {
        var pizzaData = pizzas[index];

        // Asegúrate de que el campo 'color' sea un entero que representa el color
        final int colorValue =
            pizzaData['color'] ?? 0xFFFFFFFF; // Color por defecto (blanco)
        final Color pizzaColor = Color(colorValue); // Convertir int a Color

        return PizzaTile(
          pizzaFlavor: pizzaData['flavor'],
          pizzaPrice: pizzaData['price'].toString(),
          pizzaColor: pizzaColor, // Pasar el objeto Color
          imageName:
              pizzaData['image'], // Asegúrate de que este campo sea correcto
          onAdd: () {
            widget.onAdd(pizzaData['price'].toString());
          },
        );
      },
    );
  }
}
