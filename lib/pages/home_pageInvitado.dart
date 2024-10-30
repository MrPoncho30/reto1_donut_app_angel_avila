import 'package:flutter/material.dart';
import 'package:reto1_donut_app_angel_avila/pages/login.dart'; // Importa la página de login
import 'package:reto1_donut_app_angel_avila/pages/settings_page.dart';
import 'package:reto1_donut_app_angel_avila/tab/burger_tab.dart'; // Importa la pestaña de hamburguesas
import 'package:reto1_donut_app_angel_avila/tab/donut_tab.dart'; // Importa la pestaña de donas
import 'package:reto1_donut_app_angel_avila/tab/pancakes_tab.dart'; // Importa la pestaña de hotcakes
import 'package:reto1_donut_app_angel_avila/tab/pizza_tab.dart'; // Importa la pestaña de pizzas
import 'package:reto1_donut_app_angel_avila/tab/smoothie_tab.dart'; // Importa la pestaña de batidos
import 'package:reto1_donut_app_angel_avila/utils/my_tab.dart'; // Importa la clase de pestañas personalizadas
import 'cart_page.dart'; // Importa la página del carrito
import 'profile_page.dart'; // Importa la página de perfil

class HomePage2 extends StatefulWidget {
  const HomePage2({super.key});

  @override
  State<HomePage2> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage2> {
  // Lista que contiene los precios de los productos añadidos al carrito
  List<double> cartPrices = [];

  // Contador de ítems en el carrito
  int itemCount = 0;

  // Función para añadir un ítem al carrito y actualizar el contador
  void addItemToCart(double price) {
    setState(() {
      cartPrices.add(price);
      itemCount++;
    });
  }

  // Función para vaciar el carrito y restablecer el contador
  void clearCart() {
    setState(() {
      cartPrices.clear();
      itemCount = 0;
    });
  }

  // Función para actualizar el carrito con una lista de precios y ajustar el contador
  void updateCart(List<double> updatedCart) {
    setState(() {
      cartPrices = updatedCart;
      itemCount = cartPrices.length;
    });
  }

  // Getter para obtener el precio total del carrito sumando los elementos
  double get totalPrice => cartPrices.fold(0, (sum, item) => sum + item);

  // Lista de pestañas personalizadas para navegar entre diferentes categorías de alimentos
  List<Widget> myTabs = [
    const MyTab(iconPath: 'lib/icons/donut.png', name: 'Donuts'),
    const MyTab(iconPath: 'lib/icons/burger.png', name: 'Burgers'),
    const MyTab(iconPath: 'lib/icons/smoothie.png', name: 'Smoothies'),
    const MyTab(iconPath: 'lib/icons/pancakes.png', name: 'Pancakes'),
    const MyTab(iconPath: 'lib/icons/pizza.png', name: 'Pizza'),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      // Define el número de pestañas
      length: myTabs.length,
      child: Scaffold(
        // AppBar transparente con botones de menú y perfil
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: Padding(
            padding: const EdgeInsets.only(left: 24.0),
            // Usa Builder para acceder al contexto del Scaffold
            child: Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: Icon(Icons.menu, color: Colors.grey[800], size: 36),
                  onPressed: () {
                    Scaffold.of(context)
                        .openDrawer(); // Abre el drawer al presionar el botón de menú
                  },
                );
              },
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 24.0),
              // Botón que ha sido reemplazado para no ser presionable
              child: GestureDetector(
                onTap: () {
                  // No se realiza ninguna acción al tocar
                },
                child: Icon(
                  Icons.person,
                  color: Colors.grey[800],
                  size: 36,
                ),
              ),
            ),
          ],
        ),

        // Drawer (Menu desplegable)con opciones de navegación y cierre de sesión
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: const Text(
                  'Bienvenido, Usuario',
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
              ),
              // Navegación a la página de perfil
              ListTile(
                leading: Icon(Icons.person),
                title: Text('Perfil'),
                // onTap: () {
                //   Navigator.push(
                //     context,
                //     MaterialPageRoute(builder: (context) => ProfilePage()),
                //   );
                // },
              ),
              ListTile(
                leading: Icon(Icons.notifications),
                title: Text('Notificaciones'),
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text('Ajustes'),
                // onTap: () {
                //   Navigator.push(
                //     context,
                //     MaterialPageRoute(builder: (context) => SettingsPage()),
                //   );
                // },
              ),
              ListTile(
                leading: Icon(Icons.help),
                title: Text('Ayuda'),
              ),
              // Opción de cierre de sesión, navega al login y elimina rutas anteriores
              ListTile(
                leading: Icon(Icons.logout),
                title: Text('Iniciar sesión'),
                onTap: () {
                  // Aquí puedes limpiar el estado de la aplicación si es necesario
                  clearCart(); // Asegúrate de vaciar el carrito
                  // Agrega cualquier otra limpieza necesaria para la sesión
                  // Navega a la pantalla de inicio de sesión y elimina rutas anteriores
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                    (Route<dynamic> route) => false,
                  );
                },
              ),
            ],
          ),
        ),
        // Cuerpo de la pantalla principal
        body: Column(children: [
          // Texto de bienvenida en la parte superior
          const Padding(
            padding: EdgeInsets.all(24.0),
            child: Row(
              children: [
                Text("I want to ", style: TextStyle(fontSize: 32)),
                Text("Eat",
                    style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline)),
              ],
            ),
          ),
          // Barra de pestañas
          TabBar(tabs: myTabs),
          // Vista de cada pestaña con su correspondiente contenido
          Expanded(
            child: TabBarView(children: [
              DonutTab(onAdd: (price) => addItemToCart(double.parse(price))),
              BurgerTab(onAdd: (price) => addItemToCart(double.parse(price))),
              SmoothieTab(onAdd: (price) => addItemToCart(double.parse(price))),
              PancakesTab(onAdd: (price) => addItemToCart(double.parse(price))),
              PizzaTab(onAdd: (price) => addItemToCart(double.parse(price))),
            ]),
          ),
          // Resumen del carrito y opciones de ver o vaciar carrito
          Container(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Muestra el número de ítems y el precio total
                    Text(
                      '$itemCount Items | \$${totalPrice.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 5),
                    // Texto informativo sobre los cargos de envío
                    Text(
                      'Delivery Charges Included',
                      style: TextStyle(fontSize: 18, color: Colors.grey[900]),
                    ),
                  ],
                ),
                // Botón para navegar a la página del carrito
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(35),
                    ),
                  ),
                  onPressed: () {}, // Deshabilita el botón
                  child: const Text(
                    'View Cart',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
                // Botón para vaciar el carrito
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: clearCart,
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
