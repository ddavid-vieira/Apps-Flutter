import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loja_virtual/models/Cartmodel.dart';

class DiscountCart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 8.0,
      margin: EdgeInsets.symmetric(
        horizontal: 8.0,
        vertical: 4.0,
      ),
      child: ExpansionTile(
        leading: Icon(Icons.card_giftcard),
        trailing: Icon(Icons.add),
        title: Text(
          "Cupom de Desconto",
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
              initialValue: CartModel.of(context).cuponCode ?? "",
              onFieldSubmitted: (text) {
                Firestore.instance
                    .collection("coupuns")
                    .document(text)
                    .get()
                    .then((doc) {
                  if (doc.data != null) {
                    CartModel.of(context)
                        .setCoupon(text, doc.data['percentege']);
                    Scaffold.of(context).showSnackBar(SnackBar(
                        backgroundColor: Colors.green,
                        content: Text(
                            "Desconto de ${doc.data['percentege']}% aplicado!")));
                  } else {
                    CartModel.of(context).setCoupon(null, 0);
                    Scaffold.of(context).showSnackBar(SnackBar(
                        backgroundColor: Colors.red,
                        content: Text("Esse cupom não existe!")));
                  }
                });
              },
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: "Digite o seu Cupom"),
            ),
          ),
        ],
      ),
    );
  }
}
