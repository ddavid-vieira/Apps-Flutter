import 'package:flutter/material.dart';
import 'package:loja_virtual/Screens/CartScreen.dart';

class CustomButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.red,
      child: Icon(Icons.shopping_cart, color: Colors.white),
      onPressed: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => CartScreen()));
      },
    );
  }
}
