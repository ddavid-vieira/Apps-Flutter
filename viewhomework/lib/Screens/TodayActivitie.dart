import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class Today extends StatefulWidget {
  @override
  _TodayState createState() => _TodayState();
}

class _TodayState extends State<Today> {
  Future<Map> _getToday() async {
    http.Response response = await http.get(
        "https://damp-waters-69676.herokuapp.com/api/activities?today=true");

    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 10),
        child: FutureBuilder(
          future: _getToday(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
              case ConnectionState.none:
                return Center(
                    child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Color.fromARGB(
                      255,
                      0,
                      100,
                      0,
                    ),
                  ),
                ));
              default:
                if (snapshot.hasError) {
                  return Center(
                      child: Text('Falha ao carregar os dados da API'));
                }
                if (snapshot.data["data"].length == 0) {
                  return Center(
                      child: Text(
                    'Não há tarefas para hoje',
                    style: GoogleFonts.nunito(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 0, 100, 0)),
                  ));
                } else {
                  return Stack(children: [
                    Scaffold(
                        body: Container(
                            height: MediaQuery.of(context).size.height,
                            width: MediaQuery.of(context).size.width,
                            color: Color.fromARGB(255, 241, 241, 241))),
                    expansionTile(context, snapshot)
                  ]);
                }
            }
          },
        ),
      ),
    );
  }

  Widget expansionTile(BuildContext context, AsyncSnapshot snapshot) {
    return snapshot.data['data'] != null
        ? RefreshIndicator(
            color: Color.fromARGB(255, 0, 100, 0),
            onRefresh: refresh,
            child: ListView.builder(
                itemCount: snapshot.data["data"].length,
                itemBuilder: (context, index) {
                  return Padding(
                      padding: EdgeInsets.all(10),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: BorderSide(
                            color: Color.fromARGB(255, 0, 100, 0),
                            width: 2.0,
                          ),
                        ),
                        elevation: 4.0,
                        margin: EdgeInsets.symmetric(
                          horizontal: 8.0,
                          vertical: 4.0,
                        ),
                        child: ExpansionTile(
                          leading: Icon(AntDesign.book,
                              color: Color.fromARGB(255, 0, 100, 0)),
                          childrenPadding: EdgeInsets.all(10),
                          title: Text(
                            snapshot.data['data'][index]['title'],
                            textAlign: TextAlign.center,
                            style: GoogleFonts.nunito(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 0, 100, 0)),
                          ),
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width - 50,
                              height: 150,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.green,
                                  width: 3,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(
                                    10,
                                  ),
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  snapshot.data['data'][index]['description'],
                                  style: GoogleFonts.nunito(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 0, 100, 0)),
                                  textAlign: TextAlign.start,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 15),
                              child: Align(
                                alignment: Alignment.bottomLeft,
                                child: Text(
                                  'Data de Entrega: ' +
                                      snapshot.data['data'][index]
                                          ['delivery_date'],
                                  style: GoogleFonts.nunito(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 0, 100, 0)),
                                  textAlign: TextAlign.start,
                                ),
                              ),
                            )
                          ],
                        ),
                      ));
                }))
        : Center(child: CircularProgressIndicator());
  }

  Future<void> refresh() {
    setState(() {
      _getToday();
    });
  }
}
