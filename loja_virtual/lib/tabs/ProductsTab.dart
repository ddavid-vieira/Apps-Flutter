import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/Tiles/CategorytTile.dart';

class ProductsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: Firestore.instance.collection("Produtos").getDocuments(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.black,
            ),
          );
        } else {
          var dividedtiles = ListTile.divideTiles(
                  tiles: snapshot.data.documents.map(
                    (doc) {
                      return CategoryTile(doc);
                    },
                  ).toList(),
                  color: Colors.transparent)
              .toList();
          return Stack(
            children: [
              Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  color: Colors.redAccent),
              ListView(
                children: dividedtiles,
              )
            ],
          );
        }
      },
    );
  }
}
