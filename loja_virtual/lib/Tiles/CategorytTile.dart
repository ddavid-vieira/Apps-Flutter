import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loja_virtual/Screens/CategoryScreen.dart';
import 'package:transparent_image/transparent_image.dart';

class CategoryTile extends StatelessWidget {
  final DocumentSnapshot snapshot;
  CategoryTile(this.snapshot);
  @override
  Widget build(BuildContext context) {
    return Card(
        color: Colors.transparent,
        elevation: 6.0,
        margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
        child: Container(
          decoration: BoxDecoration(
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.black,
                offset: Offset(1.0, 2.5),
                blurRadius: 10.0,
              ),
            ],
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            gradient: LinearGradient(colors: [
              Color.fromARGB(255, 255, 0, 0),
              Color.fromARGB(255, 255, 255, 0)
            ], begin: Alignment.topLeft, end: Alignment.bottomRight),
          ),
          child: ListTile(
            contentPadding:
                EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            leading: Container(
              padding: EdgeInsets.only(right: 12.0),
              decoration: BoxDecoration(
                  border: Border(
                      right: BorderSide(width: 1.0, color: Colors.white24))),
              child: CircleAvatar(
                radius: 20.0,
                backgroundColor: Colors.transparent,
                child: FadeInImage.memoryNetwork(
                  placeholder: kTransparentImage,
                  image: snapshot.data['icon'],
                ),
              ),
            ),
            title: Text(snapshot.data['title'],
                style: GoogleFonts.comfortaa(
                    fontSize: 17.0, fontWeight: FontWeight.bold)),
            trailing: Icon(Icons.keyboard_arrow_right),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => CategoryScreen(snapshot)));
            },
          ),
        ));
  }
}
