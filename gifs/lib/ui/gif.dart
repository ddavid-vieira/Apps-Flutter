import 'package:flutter/material.dart';
import 'package:share/share.dart';

class Gifs extends StatelessWidget {
  final Map _getgif;
  Gifs(this._getgif);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_getgif["title"]),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
              icon: Icon(Icons.share),
              onPressed: () {
                Share.share(_getgif["images"]["fixed_height"]["url"]);
              })
        ],
      ),
      backgroundColor: Colors.black,
      body: Center(
          child: Image.network(_getgif["images"]["fixed_height"]["url"])),
    );
  }
}
