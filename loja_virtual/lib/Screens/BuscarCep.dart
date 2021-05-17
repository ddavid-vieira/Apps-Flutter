import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class BuscarCep extends StatelessWidget {
  final _cep;
  BuscarCep(this._cep);
  Future _showCep() async {
    http.Response response;
    response = await http.get("https://viacep.com.br/ws/$_cep/json/");
    var decoded = await json.decode(response.body);
    return decoded;
  }

  var _addresscontroller = TextEditingController();
  var _logradourocontroller = TextEditingController();
  var _bairrocontroller = TextEditingController();
  var _cidadecontroller = TextEditingController();
  var _ufcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _addresscontroller.text = _cep.toString();
    return Scaffold(
      appBar: AppBar(
        title: Text('Seu endereço'),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10.0),
            child: TextField(
              controller: _addresscontroller,
              decoration: InputDecoration(
                labelText: "CEP",
                hintText: "Seu CEP",
                border: OutlineInputBorder(),
                icon: Icon(Icons.location_city),
              ),
            ),
          ),
          Expanded(
            child: (FutureBuilder(
              future: _showCep(),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                  case ConnectionState.none:
                    return Center(
                        child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                    ));
                  default:
                    if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          'CEP não  encontrado',
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold),
                        ),
                      );
                    } else
                      _logradourocontroller.text = snapshot.data['logradouro'];
                    _bairrocontroller.text = snapshot.data['bairro'];
                    _cidadecontroller.text = snapshot.data['localidade'];
                    _ufcontroller.text = snapshot.data['uf'];

                    return SingleChildScrollView(
                        child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(10.0),
                          child: TextField(
                            controller: _logradourocontroller,
                            decoration: InputDecoration(
                              labelText: "Logradouro",
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(10.0),
                          child: TextField(
                            controller: _bairrocontroller,
                            decoration: InputDecoration(
                              labelText: "Bairro",
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: 300,
                              child: Padding(
                                padding: EdgeInsets.all(10.0),
                                child: TextField(
                                  controller: _cidadecontroller,
                                  decoration: InputDecoration(
                                    labelText: "Localidade",
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: 100,
                              child: Padding(
                                padding: EdgeInsets.all(10.0),
                                child: TextField(
                                  controller: _ufcontroller,
                                  decoration: InputDecoration(
                                    labelText: "UF",
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ));
                }
              },
            )),
          )
        ],
      ),
    );
  }
}
