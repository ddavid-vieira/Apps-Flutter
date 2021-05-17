import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

const request = "https://api.hgbrasil.com/finance/quotations?key=bd0352f6";
void main() async {
  runApp(MaterialApp(
    home: Home(),
    theme: ThemeData(
        hintColor: Colors.amber,
        primaryColor: Colors.white,
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          focusedBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.amber)),
          hintStyle: TextStyle(color: Colors.amber),
        )),
  ));
}

Future<Map> getData() async {
  http.Response response = await http.get(request);
  return json.decode(response.body);
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final real1 = TextEditingController();
  final dolar1 = TextEditingController();
  final euro1 = TextEditingController();
  final libra1 = TextEditingController();
  final bit1 = TextEditingController();

  double dolar;
  double euro;
  double bitcoin;
  double libra;
  void _clear() {
    real1.text = "";
    dolar1.text = "";
    euro1.text = "";
    libra1.text = "";
    bit1.text = "";
  }

  void _realchanged(String text) {
    if (text.isEmpty) {
      _clear();
      return;
    }
    double real = double.parse(text);
    dolar1.text = (real / dolar).toStringAsFixed(2);
    euro1.text = (real / euro).toStringAsFixed(2);
    libra1.text = (real / libra).toStringAsFixed(2);
    bit1.text = (real / bitcoin).toStringAsPrecision(5);
  }

  void _dolarchanged(String text) {
    if (text.isEmpty) {
      _clear();
      return;
    }
    double dolar = double.parse(text);
    real1.text = (dolar * this.dolar).toStringAsPrecision(2);
    euro1.text = (dolar * this.dolar / euro).toStringAsFixed(2);
    libra1.text = (dolar * this.dolar / libra).toStringAsFixed(2);
    bit1.text = (dolar * this.dolar / bitcoin).toStringAsFixed(5);
  }

  void _eurochanged(String text) {
    if (text.isEmpty) {
      _clear();
      return;
    }
    double euro = double.parse(text);
    real1.text = (euro * this.euro).toStringAsFixed(2);
    dolar1.text = (euro * this.euro / dolar).toStringAsFixed(2);
    libra1.text = (euro * this.euro / libra).toStringAsFixed(2);
    bit1.text = (euro * this.euro / bitcoin).toStringAsFixed(5);
  }

  void _librachanged(String text) {
    if (text.isEmpty) {
      _clear();
      return;
    }
    double libra = double.parse(text);
    real1.text = (libra * this.libra).toStringAsFixed(2);
    dolar1.text = (libra * this.libra / dolar).toStringAsFixed(2);
    euro1.text = (libra * this.libra / euro).toStringAsFixed(2);
    bit1.text = (libra * this.libra / bitcoin).toStringAsFixed(5);
  }

  void _bitchanged(String text) {
    if (text.isEmpty) {
      _clear();
      return;
    }
    double bitcoin = double.parse(text);
    real1.text = (bitcoin * this.bitcoin).toStringAsFixed(2);
    dolar1.text = (bitcoin * this.bitcoin / dolar).toStringAsFixed(2);
    euro1.text = (bitcoin * this.bitcoin / euro).toStringAsFixed(2);
    libra1.text = (bitcoin * this.bitcoin / libra).toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.amber,
        centerTitle: true,
        title: Text(
          "\$ Conversor de Moedas \$",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: FutureBuilder<Map>(
        future: getData(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(
                  child: Text(
                "Carregando dados...",
                style: TextStyle(color: Colors.white, fontSize: 25.0),
              ));
            default:
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    "Erro ao carregar os dados",
                    style: TextStyle(color: Colors.white12, fontSize: 25.0),
                  ),
                );
              } else {
                dolar = snapshot.data['results']['currencies']['USD']['buy'];
                euro = snapshot.data['results']['currencies']['EUR']['buy'];
                libra = snapshot.data['results']['currencies']['GBP']['buy'];
                bitcoin = snapshot.data['results']['currencies']['BTC']['buy'];
                return SingleChildScrollView(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Icon(Icons.monetization_on,
                            size: 150.0, color: Colors.amber),
                        textfield("Real", "R\$", real1, _realchanged),
                        Divider(),
                        textfield('Dólar', 'US\$', dolar1, _dolarchanged),
                        Divider(),
                        textfield('Euro', '€', euro1, _eurochanged),
                        Divider(),
                        textfield(
                            'Libra Esterlina', '£', libra1, _librachanged),
                        Divider(),
                        textfield('Bitcoin', '₿', bit1, _bitchanged),
                      ],
                    ));
              }
          }
        },
      ),
    );
  }
}

Widget textfield(
    String label, String prefix, TextEditingController c, Function f) {
  return TextField(
      controller: c,
      decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.amber, fontSize: 25.0),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(4))),
          prefixText: prefix),
      style: TextStyle(color: Colors.amber, fontSize: 25.0),
      onChanged: f,
      keyboardType: TextInputType.numberWithOptions(decimal: true));
}
