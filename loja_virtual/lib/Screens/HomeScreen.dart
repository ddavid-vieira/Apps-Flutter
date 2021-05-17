import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loja_virtual/Widget/CustomButton.dart';
import 'package:loja_virtual/Widget/CustomDrawer.dart';
import 'package:loja_virtual/tabs/HomeTab.dart';
import 'package:loja_virtual/tabs/OrdersTab.dart';
import 'package:loja_virtual/tabs/PlacesTab.dart';
import 'package:loja_virtual/tabs/ProductsTab.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      physics: NeverScrollableScrollPhysics(),
      children: [
        Scaffold(
          drawer: CustomDrawer(_pageController),
          body: HomeTab(),
          floatingActionButton: CustomButton(),
        ),
        Scaffold(
          appBar: AppBar(
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  Color.fromARGB(255, 255, 0, 0),
                  Color.fromARGB(255, 255, 255, 0)
                ], begin: Alignment.topLeft, end: Alignment.bottomRight),
              ),
            ),
            title: Text("Comidas", style: GoogleFonts.comfortaa()),
            centerTitle: true,
            backgroundColor: Colors.red[400],
          ),
          drawer: CustomDrawer(_pageController),
          body: ProductsTab(),
          floatingActionButton: CustomButton(),
        ),
        Scaffold(
            appBar: AppBar(
              flexibleSpace: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Color.fromARGB(255, 255, 0, 0),
                    Color.fromARGB(255, 255, 255, 0)
                  ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                ),
              ),
              backgroundColor: Colors.red,
              centerTitle: true,
              title: Text(
                'Lanchonetes',
              ),
            ),
            body: PlacesTab(),
            drawer: CustomDrawer(_pageController)),
        Scaffold(
            appBar: AppBar(
              flexibleSpace: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Color.fromARGB(255, 255, 0, 0),
                    Color.fromARGB(255, 255, 255, 0)
                  ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                ),
              ),
              backgroundColor: Colors.red,
              centerTitle: true,
              title: Text(
                'Meus pedidos',
              ),
            ),
            body: OrdersTab(),
            drawer: CustomDrawer(_pageController))
      ],
    );
  }
}
