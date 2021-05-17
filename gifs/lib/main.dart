import 'package:flutter/material.dart';
import 'package:gifs/ui/home.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
    theme: ThemeData(
        inputDecorationTheme: InputDecorationTheme(
      enabledBorder:
          OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
    )),
  ));
}
