import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loja_virtual/Screens/HomeScreen.dart';
import 'package:loja_virtual/models/Cartmodel.dart';
import 'package:loja_virtual/models/Usermodel.dart';
import 'package:scoped_model/scoped_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ScopedModel<UserModel>(
      model: UserModel(),
      child: ScopedModelDescendant<UserModel>(
        builder: (context, child, model) {
          return ScopedModel<CartModel>(
            model: CartModel(model),
            child: MaterialApp(
              home: HomeScreen(),
              theme: ThemeData(
                  primarySwatch: Colors.blue,
                  primaryColor: Colors.blueAccent,
                  fontFamily: GoogleFonts.getFont('Nunito').fontFamily),
              debugShowCheckedModeBanner: false,
            ),
          );
        },
      ),
    ),
  );
}
