import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:viewhomework/Screens/HomeWork.dart';

class TeachersScreen extends StatelessWidget {
  Future _getTeachers() async {
    http.Response response;
    response = await http
        .get("https://damp-waters-69676.herokuapp.com/api/discipline");

    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leading: Icon(Icons.book),
            title: Text(
              'Disciplinas',
              style: GoogleFonts.nunito(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
            backgroundColor: Color.fromARGB(255, 0, 100, 0)),
        body: Padding(
          padding: EdgeInsets.only(top: 10),
          child: FutureBuilder(
            future: _getTeachers(),
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
                  } else
                    return Stack(children: [
                      Container(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          color: Color.fromARGB(255, 241, 241, 241)),
                      cardTeachers(context, snapshot)
                    ]);
              }
            },
          ),
        ));
  }

  Widget cardTeachers(BuildContext context, AsyncSnapshot snapshot) {
    var icons = [
      'images/book.png',
      'images/number.png',
      'images/atomo.png',
      'images/tabela.png',
      'images/celula.png',
      'images/historia.png',
      'images/socrates.png',
      'images/america.png',
      'images/artes.png',
      'images/atleta.png',
      'images/prog.png',
      'images/web.png',
      'images/pessoas.png',
    ];

    return ListView.builder(
        itemCount: snapshot.data["disciplines"].length,
        itemBuilder: (context, index) {
          return Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            elevation: 8.0,
            margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
            child: Container(
                decoration: BoxDecoration(color: Colors.white24),
                child: ListTile(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  leading: Container(
                      padding: EdgeInsets.only(right: 12.0),
                      decoration: new BoxDecoration(
                          border: new Border(
                              right: new BorderSide(
                                  width: 1.0, color: Colors.black))),
                      child: Image.asset(icons[index])),
                  title: Text(
                    snapshot.data["disciplines"][index]['name'],
                    style: GoogleFonts.nunito(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 0, 100, 0)),
                  ),
                  subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(snapshot.data["disciplines"][index]['teacher'],
                            style: GoogleFonts.nunito(
                              fontSize: 16.0,
                            )),
                        SizedBox(height: 6),
                        Text(
                            'Atendimento: ' +
                                snapshot.data["disciplines"][index]
                                    ['openinghours'],
                            style: GoogleFonts.nunito(
                              fontSize: 16.0,
                            )),
                      ]),
                  trailing: Icon(Icons.keyboard_arrow_right,
                      color: Colors.black, size: 30.0),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => HomeWork(snapshot, index)));
                  },
                )),
          );
        });
  }
}
