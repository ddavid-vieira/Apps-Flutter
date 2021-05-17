import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class HomeWork extends StatefulWidget {
  final AsyncSnapshot snapshot;
  final int id;
  final int index;
  final String widget;
  HomeWork(this.snapshot, this.id, this.index, this.widget);

  @override
  _HomeWorkState createState() => _HomeWorkState();
}

class _HomeWorkState extends State<HomeWork> {
  Future<Map> _getHomeWork() async {
    http.Response response = await http.get(
        "https://damp-waters-69676.herokuapp.com/api/disciplines/${widget.id}/activities");

    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
        title: Text(widget.snapshot.data["data"][widget.index]['name']),
        backgroundColor: Color.fromARGB(
          255,
          0,
          100,
          0,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 10),
        child: FutureBuilder(
          future: _getHomeWork(),
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
                    'Não há tarefas para essa disciplina',
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
                    expansionTile(context, snapshot, widget.widget)
                  ]);
                }
            }
          },
        ),
      ),
    );
  }

  Widget expansionTile(
      BuildContext context, AsyncSnapshot snapshot, String image) {
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
                          childrenPadding: EdgeInsets.all(10),
                          leading: Padding(
                              padding: EdgeInsets.only(top: 10, bottom: 10),
                              child: Image.asset(image)),
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
      _getHomeWork();
    });
  }
}
