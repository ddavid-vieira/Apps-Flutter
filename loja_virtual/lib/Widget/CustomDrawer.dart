import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loja_virtual/Screens/Login_Screen.dart';
import 'package:loja_virtual/Tiles/DrawerTile.dart';
import 'package:loja_virtual/models/Usermodel.dart';
import 'package:scoped_model/scoped_model.dart';

class CustomDrawer extends StatelessWidget {
  final PageController pageController;
  CustomDrawer(this.pageController);
  @override
  Widget build(BuildContext context) {
    Widget _buildDrawerBack() => Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Color.fromARGB(255, 255, 0, 0),
              Color.fromARGB(255, 255, 255, 0)
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
          ),
        );
    return Drawer(
      child: Stack(
        children: [
          _buildDrawerBack(),
          ListView(
            padding: EdgeInsets.only(top: 10.0, left: 12.0),
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 8.0),
                padding: EdgeInsets.fromLTRB(0.0, 16.0, 16.0, 8.0),
                height: 170.0,
                child: Stack(
                  children: [
                    Positioned(
                        top: 8.0,
                        left: 0.0,
                        child: Row(
                          children: [
                            Text(
                              "Flutter's\n Food",
                              style: GoogleFonts.comfortaa(
                                  fontSize: 34.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            Padding(
                                padding: EdgeInsets.only(left: 10.0),
                                child: Image.asset(
                                  'assets/images/icons8-hamburger-96 (1).png',
                                  fit: BoxFit.cover,
                                )),
                          ],
                        )),
                    Positioned(
                      left: 0.0,
                      bottom: 0.0,
                      child: ScopedModelDescendant<UserModel>(
                        builder: (context, child, model) {
                          print(model.islogged());
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  "Olá, ${!model.islogged() ? "" : model.userData["name"]}",
                                  style: GoogleFonts.comfortaa(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                              GestureDetector(
                                child: Text(
                                  !model.islogged()
                                      ? "Entre ou cadastre-se > "
                                      : "Sair",
                                  style: GoogleFonts.comfortaa(
                                      color: Colors.blue[900],
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                onTap: () {
                                  if (!model.islogged())
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                LoginScreen(null, null)));
                                  else
                                    model.signOut();
                                },
                              )
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Divider(),
              DrawerTile(Icons.home, "Início", pageController, 0),
              DrawerTile(Icons.fastfood, "Comidas", pageController, 1),
              DrawerTile(Icons.location_on, "Lanchonetes", pageController, 2),
              DrawerTile(
                  Icons.playlist_add_check, "Meus pedidos", pageController, 3),
            ],
          ),
        ],
      ),
    );
  }
}
