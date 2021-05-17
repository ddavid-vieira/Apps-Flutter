import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loja_virtual/Screens/HomeScreen.dart';

class OrderScreen extends StatelessWidget {
  final String orderId;
  OrderScreen(this.orderId);
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 2)).then((_) {
      Navigator.of(context).pop();
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => HomeScreen()));
    });
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        centerTitle: true,
        title: Text(
          "Pedido realizado ",
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.check,
              color: Colors.greenAccent,
              size: 80.0,
            ),
            Text('Pedido realizado com sucesso',
                style: GoogleFonts.comfortaa(
                    fontWeight: FontWeight.bold, fontSize: 19.0)),
            Text('Códido do Pedido: $orderId',
                style: GoogleFonts.comfortaa(fontSize: 16.0)),
          ],
        ),
      ),
    );
  }
}
