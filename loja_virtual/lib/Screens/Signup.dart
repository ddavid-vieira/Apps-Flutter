import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loja_virtual/Screens/BuscarCep.dart';
import 'package:loja_virtual/Screens/Login_Screen.dart';
import 'package:loja_virtual/models/Usermodel.dart';
import 'package:scoped_model/scoped_model.dart';
import 'dart:async';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _namecontroller = TextEditingController();
  final _emailcontroller = TextEditingController();
  final _passcontroller = TextEditingController();
  final _addresscontroller = TextEditingController();
  final _complecontroller = TextEditingController();

  final _formkey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  int cep;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Color.fromARGB(255, 255, 0, 0),
              Color.fromARGB(255, 255, 255, 0)
            ], begin: Alignment.topLeft, end: Alignment.bottomRight),
          ),
        ),
        title: Icon(Icons.person_add, size: 40.0),
        centerTitle: true,
        backgroundColor: Colors.grey[600],
      ),
      body: ScopedModelDescendant<UserModel>(
        builder: (context, child, model) {
          if (model.isLoading) {
            return Center(child: CircularProgressIndicator());
          }
          return Form(
            key: _formkey,
            child: ListView(
              padding: EdgeInsets.all(15.0),
              children: [
                TextFormField(
                  controller: _namecontroller,
                  decoration: InputDecoration(
                    hintText: "Nome Completo",
                    icon: Icon(Icons.person),
                  ),

                  // ignore: missing_return
                  validator: (text) {
                    if (text.isEmpty) return "Nome Inválido";
                  },
                ),
                SizedBox(
                  height: 15.0,
                ),
                TextFormField(
                  controller: _emailcontroller,
                  decoration: InputDecoration(
                    hintText: "E-mail",
                    icon: Icon(Icons.email),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  // ignore: missing_return
                  validator: (text) {
                    if (text.isEmpty || !text.contains("@"))
                      return "E-mail Inválido";
                  },
                ),
                SizedBox(
                  height: 15.0,
                ),
                TextFormField(
                  controller: _passcontroller,
                  decoration: InputDecoration(
                    hintText: "Senha",
                    icon: Icon(Icons.lock),
                  ),
                  obscureText: true,
                  maxLength: 8,
                  // ignore: missing_return
                  validator: (text) {
                    if (text.isEmpty || text.length < 6)
                      return "Senha Inválida";
                  },
                ),
                SizedBox(
                  height: 5.0,
                ),
                TextFormField(
                  controller: _addresscontroller,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: "Digite o seu CEP(apenas os números)",
                    suffixIcon: GestureDetector(
                      child: Icon(Icons.search),
                      onTap: () {
                        if (_addresscontroller.text.isEmpty ||
                            _addresscontroller.text.length < 8 ||
                            _addresscontroller.text.contains('.') ||
                            _addresscontroller.text.contains(',') ||
                            _addresscontroller.text.contains(' ') ||
                            _addresscontroller.text.contains('-')) {
                          _scaffoldKey.currentState.showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.red,
                              content: Text("Digite um CEP válido"),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        } else {
                          setState(() {
                            cep = int.parse(_addresscontroller.text);
                          });
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => BuscarCep(cep)));
                        }
                      },
                    ),
                    icon: Icon(Icons.location_city),
                  ),
                  maxLength: 8,

                  // ignore: missing_return
                ),
                TextFormField(
                  controller: _complecontroller,
                  decoration: InputDecoration(
                    hintText: "Complemento",
                    icon: Icon(Icons.add_box),
                  ),

                  // ignore: missing_return
                ),
                SizedBox(height: 15.0),
                SizedBox(
                  height: 40.0,
                  child: RaisedButton(
                    onPressed: () {
                      if (_formkey.currentState.validate()) {
                        Map<String, dynamic> userData = {
                          "name": _namecontroller.text,
                          "email": _emailcontroller.text,
                          "address": _addresscontroller.text,
                          "complemento": _complecontroller.text,
                        };

                        model.signUp(
                            userData: userData,
                            pass: _passcontroller.text,
                            onSuccess: _onSucess,
                            onFail: _onFail);
                      }
                    },
                    child: Text(
                      "Criar Conta ",
                      style: GoogleFonts.comfortaa(fontSize: 18.0),
                    ),
                    color: Colors.redAccent,
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(70.0)),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  void _onSucess() {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        backgroundColor: Colors.green,
        content: Text("Usuário Criado com Sucesso!"),
        duration: Duration(seconds: 2),
      ),
    );
    Future.delayed(Duration(seconds: 2)).then((_) {
      Navigator.of(context).pop();
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) =>
              LoginScreen(_emailcontroller.text, _passcontroller.text)));
    });
  }

  void _onFail() {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        content: Text("Falha ao Criar o Usuário!"),
        duration: Duration(seconds: 2),
      ),
    );
  }
}
