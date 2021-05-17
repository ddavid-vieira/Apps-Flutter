import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class PlaceTile extends StatelessWidget {
  final DocumentSnapshot doc;
  PlaceTile(this.doc);
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 8.0,
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 150,
            child: Image.network(
              doc.data['image'],
              fit: BoxFit.fill,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(doc.data['title'],
                    textAlign: TextAlign.start,
                    style: GoogleFonts.comfortaa(
                        fontWeight: FontWeight.bold, fontSize: 17.0)),
                Text(
                  doc.data['address'],
                  textAlign: TextAlign.start,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    FlatButton(
                        child: Icon(Icons.my_location),
                        textColor: Colors.blue,
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          launch(
                              'https://www.google.com/maps/search/?api=1&query=${doc.data['lat']},'
                              '${doc.data['long']}');
                        }),
                    FlatButton(
                        child: Icon(Icons.call),
                        textColor: Colors.blue,
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          launch('tel: ${doc.data['phone']}');
                        }),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
