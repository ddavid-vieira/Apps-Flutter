import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loja_virtual/Screens/ProductScreen.dart';
import 'package:loja_virtual/datas/Product_Datas.dart';

class ProductTile extends StatelessWidget {
  final ProductData data;
  ProductTile(this.data);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => ProductScreen(data)));
      },
      child: Card(
        color: Colors.transparent,
        shadowColor: Colors.transparent,
        borderOnForeground: false,
        elevation: 8.0,
        child: Container(
          height: 100,
          decoration: BoxDecoration(
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.black,
                offset: Offset(1.0, 2.5),
                blurRadius: 10.0,
              ),
            ],
            gradient: LinearGradient(colors: [
              Color.fromARGB(255, 255, 0, 0),
              Color.fromARGB(255, 255, 255, 0)
            ], begin: Alignment.topLeft, end: Alignment.bottomRight),
            borderRadius: BorderRadius.circular(17.0),
          ),
          width: double.infinity,

          margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5.0),
          //padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),

          child: IntrinsicHeight(
            child: Row(
              children: [
                Flexible(
                    flex: 1,
                    child: Container(
                        height: 350,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(17.0),
                              bottomLeft: Radius.circular(17.0)),
                          image: DecorationImage(
                              scale: 1.0,
                              image: NetworkImage(data.image, scale: 1.0),
                              fit: BoxFit.contain),
                        ),
                        child: null)),
                Expanded(
                  flex: 2,
                  child: Column(
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                              child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(6, 2, 2, 0),
                                  child: Text(
                                    data.title,
                                    style: GoogleFonts.comfortaa(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold),
                                  ))),
                          Container(
                            width: 100,
                            height: 35,
                            padding: EdgeInsets.only(top: 5),
                            //margin: EdgeInsets.only(top: 0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(17),
                                    bottomLeft: Radius.circular(17)),
                                color: Colors.red),
                            child: Text(
                              "R\$ ${data.preco.toStringAsPrecision(3)}",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.comfortaa(fontSize: 17.0),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
