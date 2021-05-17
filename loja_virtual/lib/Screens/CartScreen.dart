import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loja_virtual/Tiles/CartTile.dart';
import 'package:loja_virtual/Widget/CartPrice.dart';
import 'package:loja_virtual/Widget/DiscountCart.dart';
import 'package:loja_virtual/Widget/ShipCard.dart';
import 'package:loja_virtual/models/Cartmodel.dart';
import 'package:loja_virtual/models/Usermodel.dart';
import 'package:scoped_model/scoped_model.dart';

import 'Login_Screen.dart';
import 'OrderScreen.dart';

class CartScreen extends StatelessWidget {
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
          title: Text('Meu Carrinho'),
          centerTitle: true,
          actions: <Widget>[
            Container(
              padding: EdgeInsets.only(right: 8.0, top: 20.0),
              child: ScopedModelDescendant<CartModel>(
                builder: (context, child, model) {
                  int p = model.products.length;
                  return Text(
                    "${p ?? 0} ${p == 1 ? "ITEM" : "ITENS"}",
                    style: GoogleFonts.comfortaa(fontSize: 16.0),
                  );
                },
              ),
            ),
          ],
        ),
        body: Stack(
          children: [
            Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color: Colors.redAccent),
            ScopedModelDescendant<CartModel>(
              builder: (context, child, model) {
                if (model.isloading && UserModel.of(context).islogged()) {
                  return Center(child: CircularProgressIndicator());
                } else if (!UserModel.of(context).islogged()) {
                  return Container(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.remove_shopping_cart,
                            size: 80.0, color: Colors.redAccent),
                        SizedBox(
                          height: 16.0,
                        ),
                        Text(
                          "Faça login para adicionar no carrinho!",
                          style: GoogleFonts.comfortaa(
                            fontSize: 21.0,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 16.0,
                        ),
                        RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(70.0)),
                          color: Colors.redAccent,
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => LoginScreen('', '')));
                          },
                          child: Text(
                            'Entre para adicionar',
                            style: GoogleFonts.comfortaa(
                                fontSize: 16.0, color: Colors.white),
                          ),
                        )
                      ],
                    ),
                  );
                } else if (model.products == null ||
                    model.products.length == 0) {
                  return Center(
                    child: Text(
                      "Não há nada no carrinho",
                      style: GoogleFonts.comfortaa(
                        fontSize: 21.0,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  );
                } else {
                  return ListView(
                    children: <Widget>[
                      Column(
                        children: model.products.map((product) {
                          return CartTile(product);
                        }).toList(),
                      ),
                      DiscountCart(),
                      Shipcard(),
                      CartPrice(() async {
                        String orderID = await model.finishOrder();
                        if (orderID != null) {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => OrderScreen(orderID)));
                        }
                      }),
                    ],
                  );
                }
              },
            ),
          ],
        ));
  }
}
