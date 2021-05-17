import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loja_virtual/models/Cartmodel.dart';
import 'package:scoped_model/scoped_model.dart';

class CartPrice extends StatelessWidget {
  final VoidCallback buy;
  CartPrice(this.buy);
  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        margin: EdgeInsets.all(10.0),
        child: Padding(
          padding: EdgeInsets.all(5),
          child: ScopedModelDescendant<CartModel>(
            builder: (context, child, model) {
              double price = model.getProductPrice();
              double discount = model.getDiscount();
              double ship = model.getShipPrice();
              double total = price + ship - discount;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Resumo do Pedido',
                    textAlign: TextAlign.start,
                    style: GoogleFonts.comfortaa(
                        fontWeight: FontWeight.w600, fontSize: 17.0),
                  ),
                  SizedBox(
                    height: 12.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "SubTotal",
                        style: GoogleFonts.comfortaa(fontSize: 14.0),
                      ),
                      Text(
                        "R\$ ${price.toStringAsFixed(2)}",
                        style: GoogleFonts.comfortaa(fontSize: 14.0),
                      )
                    ],
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Desconto",
                        style: GoogleFonts.comfortaa(fontSize: 14.0),
                      ),
                      Text(
                        "R\$ -${discount.toStringAsFixed(2)}",
                        style: GoogleFonts.comfortaa(fontSize: 14.0),
                      )
                    ],
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Entrega",
                        style: GoogleFonts.comfortaa(fontSize: 14.0),
                      ),
                      Text(
                        "R\$ ${ship.toStringAsFixed(2)}",
                        style: GoogleFonts.comfortaa(fontSize: 14.0),
                      )
                    ],
                  ),
                  Divider(),
                  SizedBox(
                    height: 12.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Total",
                          style: GoogleFonts.comfortaa(
                              fontSize: 16.0, fontWeight: FontWeight.bold)),
                      Text(
                        "R\$ ${total.toStringAsFixed(2)}",
                        style: GoogleFonts.comfortaa(
                            fontSize: 18.0,
                            color: Colors.blue,
                            fontWeight: FontWeight.w400),
                      )
                    ],
                  ),
                  Divider(),
                  SizedBox(
                    height: 12.0,
                  ),
                  RaisedButton(
                    onPressed: buy,
                    child: Text(
                      "Finalizar pedido",
                      style: GoogleFonts.comfortaa(fontSize: 18.0),
                    ),
                    color: Colors.red,
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(70.0)),
                  ),
                ],
              );
            },
          ),
        ));
  }
}
