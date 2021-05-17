import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Contador de pessoas',
        debugShowCheckedModeBanner: false,
        home: Home());
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _p = 0;
  String _tx = "Pode entrar caro amigo";

  void _mudar(int t) {
    setState(() {
      _p += t;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Image.asset(
        "imagens/restaurant.jpg",
        fit: BoxFit.cover,
        height: 1000.0,
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Pessoas:$_p",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(10.0),
                child: FlatButton(
                    onPressed: () {
                      _mudar(1);
                    },
                    child: Text(
                      "+1",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 40.0,
                        color: Colors.white,
                      ),
                    )),
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: FlatButton(
                  onPressed: () {
                    _mudar(-1);
                  },
                  child: Text(
                    "-1",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 40.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Text("$_tx",
              style: TextStyle(
                  color: Colors.white,
                  fontStyle: FontStyle.italic,
                  fontSize: 30.0)),
        ],
      )
    ]);
  }
}
