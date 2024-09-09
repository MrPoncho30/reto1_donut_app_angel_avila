import 'package:flutter/material.dart';
import 'package:reto1_donut_app_angel_avila/tab/burger_tab.dart';
import 'package:reto1_donut_app_angel_avila/tab/donut_tab.dart';
import 'package:reto1_donut_app_angel_avila/tab/pancakes_tab.dart';
import 'package:reto1_donut_app_angel_avila/tab/pizza_tab.dart';
import 'package:reto1_donut_app_angel_avila/tab/smoothie_tab.dart';
import 'package:reto1_donut_app_angel_avila/utils/my_tab.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Widget> myTabs = [
    //donut tab
    const MyTab(iconPath: 'lib/icons/donut.png'),

    //burger tab
    const MyTab(iconPath: 'lib/icons/burger.png'),

    //smoothie tab
    const MyTab(iconPath: 'lib/icons/smoothie.png'),

    //pancakes tab
    const MyTab(iconPath: 'lib/icons/pancakes.png'),

    //pizza tab
    const MyTab(iconPath: 'lib/icons/pizza.png'),
  ];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: myTabs.length,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: Padding(
            padding: const EdgeInsets.only(left: 24.0),
            child: IconButton(
              icon: Icon(Icons.menu, color: Colors.grey[800], size: 36),
              onPressed: () {
                print('Botón de Menú');
              },
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 24.0),
              child: IconButton(
                icon: Icon(Icons.person, color: Colors.grey[800], size: 36),
                onPressed: () {
                  print('Botón de Usuario');
                },
              ),
            )
          ],
        ),
        body: Column(children: [
          //TEXTO "I want to eat"
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
          //Tap Bar
          TabBar(tabs: myTabs),
          //Tap bar view
          const Expanded(
            child: TabBarView(children: [
              //Donut tab
              DonutTab(),

              //Burger tab
              BurgerTab(),

              //Smoothie tab
              SmoothieTab(),

              //Pancakes tab
              PancakesTab(),

              //Pizza tab
              PizzaTab(),
            ]),
          )
          //Carrito
        ]),
      ),
    );
  }
}
