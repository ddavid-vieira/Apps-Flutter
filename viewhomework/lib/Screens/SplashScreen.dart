import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:viewhomework/Screens/BottomNavigation.dart';
import 'TeachersScreen.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 2,
      gradientBackground: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.fromARGB(255, 15, 64, 9),
            Color.fromARGB(255, 18, 76, 10),
            Color.fromARGB(255, 21, 89, 12),
            Color.fromARGB(255, 24, 102, 14),
            Color.fromARGB(255, 27, 114, 15),
          ]),
      navigateAfterSeconds: Navigation(),
      loaderColor: Colors.transparent,
      title: Text(
        'Easy Homework',
        style: GoogleFonts.nunito(
          fontSize: 30.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      image: Image.asset(
        'images/logo_app.png',
        scale: 1,
      ),
    );
  }
}
