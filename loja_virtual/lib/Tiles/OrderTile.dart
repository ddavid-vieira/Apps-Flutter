import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderTile extends StatelessWidget {
  final String orderid;
  OrderTile(this.orderid);
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      margin: EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 8.0,
      ),
      child: Padding(
        padding: EdgeInsets.all(
          8.0,
        ),
        child: StreamBuilder<DocumentSnapshot>(
          stream: Firestore.instance
              .collection('orders')
              .document(orderid)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              int status = snapshot.data['status'];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Código do pedido: ${snapshot.data.documentID}',
                      style:
                          GoogleFonts.comfortaa(fontWeight: FontWeight.bold)),
                  SizedBox(
                    height: 4.0,
                  ),
                  Text(_buildProductsText(snapshot.data)),
                  SizedBox(
                    height: 4.0,
                  ),
                  Text('Status do Pedido:',
                      style:
                          GoogleFonts.comfortaa(fontWeight: FontWeight.bold)),
                  SizedBox(
                    height: 4.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildCircle("1", 'Preparação', status, 1),
                      Container(height: 1.0, width: 44.0, color: Colors.grey),
                      _buildCircle("2", 'Transporte', status, 2),
                      Container(height: 1.0, width: 44.0, color: Colors.grey),
                      _buildCircle("3", 'Entrega', status, 3),
                    ],
                  )
                ],
              );
            }
          },
        ),
      ),
    );
  }

  String _buildProductsText(DocumentSnapshot snapshot) {
    String text = 'Descrição: \n';
    for (LinkedHashMap p in snapshot.data["products"]) {
      text +=
          "${p['quantity']} x ${p['product']['title']} (R\$ ${p['product']['preço'].toStringAsFixed(2)})\n";
    }
    text += 'Total: R\$ ${snapshot.data['totalPrice'].toStringAsFixed(2)}';
    return text;
  }

  Widget _buildCircle(
      String title, String subtitle, int status, int thisStatus) {
    Color backcolor;
    Widget child;
    if (status < thisStatus) {
      backcolor = Colors.grey;
      child = Text(
        title,
        style: GoogleFonts.comfortaa(color: Colors.white),
      );
    } else if (status == thisStatus) {
      backcolor = Colors.blue;
      child = Stack(
        alignment: Alignment.center,
        children: [
          Text(
            title,
            style: GoogleFonts.comfortaa(
              color: Colors.white,
            ),
          ),
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          )
        ],
      );
    } else {
      backcolor = Colors.green;
      child = Icon(Icons.check);
    }
    return Column(
      children: [
        CircleAvatar(
          radius: 20.0,
          backgroundColor: backcolor,
          child: child,
        ),
        Text(subtitle)
      ],
    );
  }
}
