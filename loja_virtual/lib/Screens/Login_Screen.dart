import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loja_virtual/Screens/HomeScreen.dart';
import 'package:loja_virtual/Screens/Signup.dart';
import 'package:loja_virtual/models/Usermodel.dart';
import 'package:scoped_model/scoped_model.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
  final String email;
  final String senha;
  LoginScreen(this.email, this.senha);
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailcontroller = TextEditingController();
  final _passcontroller = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    setState(() {
      _emailcontroller.text = widget.email;
      _passcontroller.text = widget.senha;
    });
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
        title: Text('Entrar'),
        centerTitle: true,
        backgroundColor: Colors.grey[600],
      ),
      body: ScopedModelDescendant<UserModel>(
        builder: (context, child, model) {
          if (model.isLoading)
            return Center(child: CircularProgressIndicator());
          return Form(
            key: _formkey,
            child: ListView(
              padding: EdgeInsets.all(15.0),
              children: [
                TextFormField(
                  controller: _emailcontroller,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: "E-mail",
                    icon: Icon(
                      Icons.email,
                      color: Colors.redAccent,
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  // ignore: missing_return
                  validator: (text) {
                    if (text.isEmpty || !text.contains("@"))
                      return "E-mail Inválido";
                  },
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  controller: _passcontroller,
                  decoration: InputDecoration(
                    hintText: "Senha",
                    border: const OutlineInputBorder(),
                    icon: Icon(Icons.lock, color: Colors.yellowAccent),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                      child: Icon(_obscureText
                          ? Icons.visibility
                          : Icons.visibility_off),
                    ),
                  ),
                  obscureText: _obscureText,
                  maxLength: 8,
                  // ignore: missing_return
                  validator: (text) {
                    if (text.isEmpty || text.length < 8)
                      return "Senha Inválida";
                  },
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: FlatButton(
                      onPressed: () {
                        if (_emailcontroller.text.isEmpty) {
                          _scaffoldKey.currentState.showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.red,
                              content: Text("Insira o email para recuperação!"),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        } else {
                          model.recoverPass(_emailcontroller.text);
                          _scaffoldKey.currentState.showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.green,
                              content: Text("Verique o seu e-mail!"),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        }
                      },
                      child: Text(
                        "Esqueci minha senha",
                        textAlign: TextAlign.right,
                        style: GoogleFonts.comfortaa(
                            color: Colors.blue[900],
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold),
                      ),
                      padding: EdgeInsets.zero),
                ),
                SizedBox(height: 15.0),
                SizedBox(
                  height: 40.0,
                  child: RaisedButton(
                    onPressed: () {
                      if (_formkey.currentState.validate()) {
                        model.signIn(
                            email: _emailcontroller.text,
                            password: _passcontroller.text,
                            onSuccess: _onSucess,
                            onFail: _onFail);
                      }
                    },
                    child: Text(
                      "Entrar",
                      style: GoogleFonts.comfortaa(fontSize: 18.0),
                    ),
                    color: Colors.redAccent,
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(70.0)),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Divider(
                    color: Colors.black,
                    height: 5,
                    indent: 20.0,
                    endIndent: 20.0,
                  ),
                ),
                FlatButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Signup()));
                  },
                  child: Text(
                    "Não possui uma conta?",
                    style: GoogleFonts.comfortaa(
                        color: Colors.blue[900],
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _onSucess() {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => HomeScreen()));
  }

  void _onFail() {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        content: Text("Falha ao realizar o login!"),
        duration: Duration(seconds: 2),
      ),
    );
  }
}
