import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/Tiles/ProductTile.dart';
import 'package:loja_virtual/datas/Product_Datas.dart';

class CategoryScreen extends StatelessWidget {
  final DocumentSnapshot snapshot;
  CategoryScreen(this.snapshot);
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Color.fromARGB(255, 255, 0, 0),
                Color.fromARGB(255, 255, 255, 0)
              ], begin: Alignment.topLeft, end: Alignment.bottomRight),
            ),
          ),
          title: Image.network(snapshot.data['icon']),
          centerTitle: true,
          backgroundColor: Colors.red,
        ),
        body: FutureBuilder<QuerySnapshot>(
          future: Firestore.instance
              .collection("Produtos")
              .document(snapshot.documentID)
              .collection("itens")
              .getDocuments(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            } else
              return TabBarView(
                physics: NeverScrollableScrollPhysics(),
                children: [
                  Stack(
                    children: [
                      Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          color: Colors.redAccent),
                      ListView.builder(
                          padding: EdgeInsets.all(4.0),
                          itemCount: snapshot.data.documents.length,
                          itemBuilder: (context, index) {
                            ProductData data = ProductData.fromDocument(
                                snapshot.data.documents[index]);
                            data.categoria = this.snapshot.documentID;
                            return ProductTile(data);
                          })
                    ],
                  )
                ],
              );
          },
        ),
      ),
    );
  }
}
