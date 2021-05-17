import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:viewhomework/Screens/HomeWork.dart';

class TeachersScreen extends StatelessWidget {
  Future _getTeachers() async {
    http.Response response;
    response = await http
        .get("http://damp-waters-69676.herokuapp.com/api/disciplines");
    return json.decode(response.body);
  }

  _getLenght() async {
    http.Response response;
    response = await http
        .get("https://damp-waters-69676.herokuapp.com/api/activities");

    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: NestedScrollView(
            headerSliverBuilder: (context, condition) {
              return <Widget>[
                SliverAppBar(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(20),
                    ),
                  ),
                  expandedHeight: 170,
                  backgroundColor: Color.fromARGB(255, 0, 100, 0),
                  floating: false,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    title: Text('Disciplinas',
                        textAlign: TextAlign.start,
                        style: GoogleFonts.nunito(
                            fontSize: 24, fontWeight: FontWeight.w500)),
                    background: Padding(
                      padding: EdgeInsets.all(
                        10,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(width: 2, color: Colors.white),
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset('images/logo_app.png',
                                fit: BoxFit.cover),
                            Padding(
                              padding: EdgeInsets.only(top: 10, left: 0),
                              child: Text('Easy\nHomework',
                                  style: GoogleFonts.nunito(
                                      fontSize: 30,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white)),
                            ),
                            SafeArea(
                                child: FutureBuilder(
                                    future: _getLenght(),
                                    builder: (context, snapshot) {
                                      switch (snapshot.connectionState) {
                                        case ConnectionState.waiting:
                                        case ConnectionState.none:
                                          return CircularProgressIndicator(
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                              Color.fromARGB(
                                                255,
                                                0,
                                                100,
                                                0,
                                              ),
                                            ),
                                          );
                                        default:
                                          if (snapshot.hasError) {
                                            return Text('Erro ');
                                          } else {
                                            return Padding(
                                              padding: EdgeInsets.only(
                                                  right: 15, top: 5),
                                              child: Text(
                                                "Tarefas: ${snapshot.data['data'].length}" ??
                                                    '0',
                                                style: GoogleFonts.nunito(
                                                    fontSize: 22,
                                                    color: Colors.white),
                                              ),
                                            );
                                          }
                                      }
                                    }))
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ];
            },
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
            )));
  }

  Widget cardTeachers(BuildContext context, AsyncSnapshot snapshot) {
    var icons = [
      'images/book.png',
      'images/number.png',
      'images/tabela.png',
      'images/atomo.png',
      'images/celula.png',
      'images/historia.png',
      'images/pessoas.png',
      'images/socrates.png',
      'images/globo.png',
      'images/america.png',
      'images/atleta.png',
      'images/artes.png',
      'images/prog.png',
      'images/web.png',
    ];

    return ListView.builder(
        itemCount: snapshot.data["data"].length,
        itemBuilder: (context, index) {
          return ClipPath(
            clipper: MyClipper1(),
            child: Card(
              elevation: 10.0,
              margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
              child: Container(
                decoration: BoxDecoration(color: Colors.white),
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
                    snapshot.data["data"][index]['name'],
                    style: GoogleFonts.nunito(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 0, 100, 0)),
                  ),
                  subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(snapshot.data["data"][index]['teacher'],
                            style: GoogleFonts.nunito(
                              fontSize: 16.0,
                            )),
                        SizedBox(height: 6),
                        Text(
                            'Atendimento: ' +
                                snapshot.data["data"][index]['openinghours'],
                            style: GoogleFonts.nunito(
                              fontSize: 16.0,
                            )),
                      ]),
                  trailing: Icon(Icons.keyboard_arrow_right,
                      color: Colors.black, size: 30.0),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => HomeWork(
                            snapshot,
                            snapshot.data['data'][index]['id'],
                            index,
                            icons[index]),
                      ),
                    );
                  },
                ),
              ),
            ),
          );
        });
  }
}

class MyClipper1 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.addRRect(
      RRect.fromLTRBAndCorners(0, size.height * 0.1, size.width, size.height,
          topRight: Radius.circular(20),
          bottomLeft: Radius.circular(20),
          topLeft: Radius.elliptical(60, 100),
          bottomRight: Radius.elliptical(60, 100)),
    );

    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
