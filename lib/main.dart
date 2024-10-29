import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart'; // Importa firebase_core
import 'package:reto1_donut_app_angel_avila/pages/login.dart'; // Importa la pantalla LoginScreen

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase
      .initializeApp(); // Inicializa Firebase antes de ejecutar runApp
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}
