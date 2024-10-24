import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  final List<double> cartItems;
  final Function(List<double>)
      onCartUpdated; // Callback para actualizar el carrito

  const CartPage(
      {super.key, required this.cartItems, required this.onCartUpdated});

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  // Método para eliminar ítems individuales
  void removeItem(int index) {
    setState(() {
      widget.cartItems.removeAt(index);
      widget.onCartUpdated(
          widget.cartItems); // Actualiza el carrito en la HomePage
    });
  }

  // Calcular el total de la compra
  double get totalPrice => widget.cartItems.fold(0, (sum, item) => sum + item);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.grey[800], size: 36),
          onPressed: () {
            Navigator.pop(context); // Volver a la página anterior
          },
        ),
        title: const Text(
          'My Cart',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Items in Cart:',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            // Lista de ítems en el carrito
            Expanded(
              child: widget.cartItems.isNotEmpty
                  ? ListView.builder(
                      itemCount: widget.cartItems.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: const Icon(Icons.fastfood),
                          title: Text('Item ${index + 1}'),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // Precio del ítem
                              Text(
                                  '\$${widget.cartItems[index].toStringAsFixed(2)}'),
                              const SizedBox(width: 10),
                              // Botón para eliminar ítem
                              IconButton(
                                icon:
                                    const Icon(Icons.delete, color: Colors.red),
                                onPressed: () {
                                  removeItem(
                                      index); // Eliminar el ítem del carrito
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    )
                  : const Center(
                      child: Text(
                        "No items in cart",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
            ),
            const SizedBox(height: 20),
            // Mostrar el total de la compra
            Text(
              'Total: \$${totalPrice.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            // Botón para proceder al pago
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(35),
                  ),
                ),
                onPressed: () {
                  print('Ir a pagar');
                },
                child: const Text(
                  'Ir a pagar',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
