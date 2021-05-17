import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loja_virtual/Screens/Login_Screen.dart';
import 'package:loja_virtual/datas/CartProduct.dart';
import 'package:loja_virtual/datas/Product_Datas.dart';
import 'package:loja_virtual/models/Cartmodel.dart';
import 'package:loja_virtual/models/Usermodel.dart';

import 'CartScreen.dart';

class ProductScreen extends StatefulWidget {
  final ProductData data;
  ProductScreen(this.data);
  @override
  _ProductScreenState createState() => _ProductScreenState(data);
}

class _ProductScreenState extends State<ProductScreen> {
  final ProductData data;
  _ProductScreenState(this.data);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Color.fromARGB(255, 255, 0, 0),
              Color.fromARGB(255, 255, 255, 0)
            ], begin: Alignment.topLeft, end: Alignment.bottomRight),
          ),
        ),
      ),
      body: ListView(
        children: [
          AspectRatio(aspectRatio: 0.9, child: Image.network(data.image)),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  data.title,
                  style: GoogleFonts.comfortaa(
                      fontSize: 20.0, fontWeight: FontWeight.w400),
                  maxLines: 3,
                ),
                Text(
                  "R\$ ${data.preco.toStringAsPrecision(3)}",
                  style: GoogleFonts.comfortaa(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent),
                ),
                SizedBox(
                  height: 16.0,
                ),
                SizedBox(
                  height: 44.0,
                  child: RaisedButton(
                    onPressed: () {
                      if (UserModel.of(context).islogged()) {
                        CartProduct cartProduct = CartProduct();
                        cartProduct.quantity = 1;
                        cartProduct.pid = data.id;
                        cartProduct.category = data.categoria;
                        cartProduct.productdata = data;
                        CartModel.of(context).addCart(cartProduct);

                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => CartScreen()));
                      } else {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => LoginScreen('', '')));
                      }
                    },
                    child: Text(
                      UserModel.of(context).islogged()
                          ? "Adicionar ao carrinho"
                          : "Entre para comprar",
                      style: GoogleFonts.comfortaa(fontSize: 18.0),
                    ),
                    color: Colors.red,
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(70.0)),
                  ),
                ),
                SizedBox(height: 16.0),
                Text("Descrição",
                    style: GoogleFonts.comfortaa(
                        fontSize: 17.0, fontWeight: FontWeight.w700)),
                Text(
                  data.descricao,
                  style: GoogleFonts.comfortaa(
                      fontWeight: FontWeight.w700,
                      fontSize: 16.0,
                      color: Colors.blue),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
