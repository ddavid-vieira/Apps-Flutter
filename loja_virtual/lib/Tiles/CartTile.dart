import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loja_virtual/datas/CartProduct.dart';
import 'package:loja_virtual/datas/Product_Datas.dart';
import 'package:loja_virtual/models/Cartmodel.dart';

class CartTile extends StatelessWidget {
  final CartProduct cartProduct;
  CartTile(this.cartProduct);
  @override
  Widget build(BuildContext context) {
    Widget _buildContent() {
      CartModel.of(context).updatePrices();
      return Row(
        children: [
          Container(
            width: 120.0,
            child: Image.network(
              cartProduct.productdata.image,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    cartProduct.productdata.title,
                    style: GoogleFonts.comfortaa(
                        fontWeight: FontWeight.w600, fontSize: 17.0),
                  ),
                  Text(
                    "R\$ ${cartProduct.productdata.preco.toStringAsFixed(2)}",
                    style: GoogleFonts.comfortaa(
                        color: Colors.blueAccent,
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.remove,
                        ),
                        color: Colors.red,
                        onPressed: cartProduct.quantity > 1
                            ? () {
                                CartModel.of(context).decProduct(cartProduct);
                              }
                            : null,
                      ),
                      Text(cartProduct.quantity.toString()),
                      IconButton(
                          icon: Icon(Icons.add),
                          color: Colors.green,
                          onPressed: () {
                            CartModel.of(context).incProduct(cartProduct);
                          }),
                      FlatButton(
                          onPressed: () {
                            CartModel.of(context).removeCart(cartProduct);
                          },
                          child: Text(
                            "Remover",
                            style: GoogleFonts.comfortaa(
                                color: Colors.grey[850], fontSize: 15),
                          ))
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      );
    }

    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 8.0,
        margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
        child: cartProduct.productdata == null
            ? FutureBuilder(
                future: Firestore.instance
                    .collection('Produtos')
                    .document(cartProduct.category)
                    .collection('itens')
                    .document(cartProduct.pid)
                    .get(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    cartProduct.productdata =
                        ProductData.fromDocument(snapshot.data);
                    return _buildContent();
                  } else {
                    return Container(
                      height: 70.0,
                      child: CircularProgressIndicator(),
                      alignment: Alignment.center,
                    );
                  }
                })
            : _buildContent());
  }
}
