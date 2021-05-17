import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loja_virtual/Screens/Login_Screen.dart';
import 'package:loja_virtual/Tiles/OrderTile.dart';
import 'package:loja_virtual/models/Usermodel.dart';

class OrdersTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (UserModel.of(context).islogged()) {
      String uid = UserModel.of(context).firebaseUser.uid;
      return FutureBuilder<QuerySnapshot>(
          future: Firestore.instance
              .collection('users')
              .document(uid)
              .collection('orders')
              .getDocuments(),
          builder: (context, snapshot) {
            if (!snapshot.hasData)
              return Center(
                child: CircularProgressIndicator(),
              );
            else {
              return Stack(
                children: [
                  Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      color: Colors.redAccent),
                  ListView(
                    children: snapshot.data.documents
                        .map((doc) => OrderTile(doc.documentID))
                        .toList()
                        .reversed
                        .toList(),
                  )
                ],
              );
            }
          });
    } else {
      return Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.view_list, size: 80.0, color: Colors.redAccent),
            SizedBox(
              height: 16.0,
            ),
            Text(
              "Faça login para acompanhar os seus pedidos !",
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
              elevation: 30.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(70.0)),
              color: Colors.redAccent,
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => LoginScreen('', '')));
              },
              child: Text(
                'Entre para adicionar',
                style:
                    GoogleFonts.comfortaa(fontSize: 16.0, color: Colors.white),
              ),
            )
          ],
        ),
      );
    }
  }
}
