import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController peso = TextEditingController();
  TextEditingController altura = TextEditingController();
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  String _infoText = "Informe seus dados!";
  void _resetarcampos() {
    peso.text = "";
    altura.text = "";
    setState(() {
      _infoText = "Informe seus dados!";
    });
  }

  void _calcimc() {
    setState(() {});
    double peso1 = double.parse(peso.text);
    double altura1 = double.parse(altura.text) / 100;
    double imc = peso1 / (altura1 * altura1);
    if (imc < 18.6) {
      _infoText = "Abaixo do Peso (${imc.toStringAsPrecision(3)})";
    } else if (imc >= 18.6 && imc < 24.9) {
      _infoText = "Peso Ideal (${imc.toStringAsPrecision(3)})";
    } else if (imc >= 24.9 && imc < 29.9) {
      _infoText = "Levemente Acima do Peso (${imc.toStringAsPrecision(3)})";
    } else if (imc >= 29.9 && imc < 34.9) {
      _infoText = "Obesidade Grau I (${imc.toStringAsPrecision(3)})";
    } else if (imc >= 34.9 && imc < 39.9) {
      _infoText = "Obesidade Grau II (${imc.toStringAsPrecision(3)})";
    } else if (imc >= 40) {
      _infoText = "Obesidade Grau III (${imc.toStringAsPrecision(3)})";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueAccent,
          title: Text(
            "Calculadora de IMC",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: _resetarcampos,
            ),
          ],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            padding: EdgeInsets.all(10),
            child: Form(
              key: _formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Icon(Icons.person_outline, size: 120.0, color: Colors.blue),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: "Peso(Kg)",
                        labelStyle: TextStyle(
                            color: Colors.blue,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.blue, fontSize: 20),
                    controller: peso,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Insira seu peso!";
                      }
                    },
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: "Altura(cm)",
                        labelStyle: TextStyle(
                            color: Colors.blue,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.blue, fontSize: 25),
                    controller: altura,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Insira sua altura!";
                      }
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    child: Container(
                      height: 50,
                      child: RaisedButton(
                        onPressed: () {
                          if (_formkey.currentState.validate()) {
                            _calcimc();
                          }
                        },
                        child: Text(
                          "Calcular",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25.0,
                          ),
                        ),
                        color: Colors.blueAccent,
                      ),
                    ),
                  ),
                  Text(
                    "$_infoText",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.blueAccent, fontSize: 20),
                  ),
                ],
              ),
            )));
  }
}
