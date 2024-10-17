import 'package:flutter/material.dart';
import 'package:reto1_donut_app_angel_avila/pages/home_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Esto quita el banner de debug
      home: const HomePage(),
      theme: ThemeData(
          tabBarTheme: const TabBarTheme(indicatorColor: Colors.pink)),
    );
  }
}
