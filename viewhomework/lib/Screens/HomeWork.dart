import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class HomeWork extends StatefulWidget {
  final AsyncSnapshot snapshot;
  final int index;
  HomeWork(this.snapshot, this.index);

  @override
  _HomeWorkState createState() => _HomeWorkState();
}

class _HomeWorkState extends State<HomeWork> {
  Future _getHomeWork() async {
    http.Response response = await http.get(
        "https://damp-waters-69676.herokuapp.com/api/discipline/${widget.index + 1}/activities");

    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.snapshot.data["disciplines"][widget.index]['name']),
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
                } else if (snapshot.data['data'] ==
                    'This course has not activities') {
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
                    Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        color: Color.fromARGB(255, 241, 241, 241)),
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
    return snapshot.data['data'].length != 0
        ? RefreshIndicator(
            color: Color.fromARGB(255, 0, 100, 0),
            onRefresh: refresh,
            child: ListView.builder(
                itemCount: snapshot.data['data'].length,
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
                      child: ListTile(
                        leading: Icon(Icons.book,
                            color: Color.fromARGB(255, 0, 100, 0)),
                        title: Text(
                          snapshot.data['data'][index]['description'],
                          textAlign: TextAlign.start,
                          style: GoogleFonts.nunito(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 0, 100, 0)),
                        ),
                        subtitle: Text(
                          'Data de Entrega: ' +
                              snapshot.data['data'][index]['delivery_date'],
                          style: GoogleFonts.nunito(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 0, 100, 0)),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ),
                  );
                }))
        : Center(child: CircularProgressIndicator());
  }

  Future<dynamic> refresh() {
    setState(() {
      _getHomeWork();
    });
  }
}
