import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Shipcard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8.0,
      margin: EdgeInsets.symmetric(
        horizontal: 8.0,
        vertical: 4.0,
      ),
      child: ExpansionTile(
        leading: Icon(Icons.location_on),
        title: Text(
          "Calcular Frete",
          textAlign: TextAlign.start,
          style: GoogleFonts.comfortaa(
              fontWeight: FontWeight.w700, fontSize: 17.0),
        ),
        children: [
          Padding(
            padding: EdgeInsets.all(
              8.0,
            ),
            child: TextFormField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: "Digite o seu CEP"),
            ),
          ),
        ],
      ),
    );
  }
}
