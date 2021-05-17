import 'package:flutter/material.dart';

class Teste extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ExpansionTile(
        title: Text('Atividade 1'),
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
              child: Text('Alguma coisa ai'),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 25),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                'Data de entrega',
                textAlign: TextAlign.start,
              ),
            ),
          )
        ],
      ),
    );
  }
}
