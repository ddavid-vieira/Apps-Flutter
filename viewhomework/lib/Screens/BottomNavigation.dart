import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:viewhomework/Screens/TabBarController.dart';
import 'package:viewhomework/Screens/TeachersScreen.dart';

class Navigation extends StatefulWidget {
  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int _currentIndex = 0;
  final tabs = [
    TeachersScreen(),
    Tabs(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: tabs[_currentIndex],
        bottomNavigationBar: Container(
          child: CurvedNavigationBar(
            color: Color.fromARGB(255, 0, 100, 0),
            backgroundColor: Color.fromARGB(255, 241, 241, 241),
            buttonBackgroundColor: Color.fromARGB(255, 0, 100, 0),
            height: 50,
            animationDuration: Duration(milliseconds: 400),
            animationCurve: Curves.easeInCubic,
            index: _currentIndex,
            items: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    AntDesign.home,
                    color: Colors.white,
                  ),
                  Text(
                    'Home',
                    style:
                        GoogleFonts.nunito(color: Colors.white, fontSize: 10),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    AntDesign.book,
                    color: Colors.white,
                  ),
                  Text(
                    'Tarefas',
                    style:
                        GoogleFonts.nunito(color: Colors.white, fontSize: 10),
                  ),
                ],
              ),
            ],
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
        ));
  }
}
