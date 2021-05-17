import 'dart:io';

import 'package:agenda_contatos/helper/contact_helper.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ContactPage extends StatefulWidget {
  final Contact contact;
  ContactPage({this.contact});

  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final _nameEdit = TextEditingController();
  final _emailEdit = TextEditingController();
  final _phoneEdit = TextEditingController();
  final _nameFocus = FocusNode();
  bool _useredit = false;
  Contact _edit = Contact();
  @override
  void initState() {
    super.initState();
    if (widget.contact == null) {
      _edit = Contact();
    } else {
      _edit = Contact.fromMap(widget.contact.toMap());
    }
    _nameEdit.text = _edit.name;
    _emailEdit.text = _edit.email;
    _phoneEdit.text = _edit.phone;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _requestPop,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueAccent,
          title: Text(_edit.name ?? "Novo contato"),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (_edit.name != null && _edit.name.isNotEmpty) {
              Navigator.pop(context, _edit);
            } else {
              FocusScope.of(context).requestFocus(_nameFocus);
            }
          },
          child: Icon(Icons.save, color: Colors.white),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: [
              GestureDetector(
                child: Container(
                  width: 140.0,
                  height: 140.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: _edit.img != null
                            ? FileImage(File(_edit.img))
                            : AssetImage("images/images.png")),
                  ),
                ),
                onTap: () {
                  ImagePicker.pickImage(source: ImageSource.camera)
                      .then((file) {
                    if (file == null) return;
                    setState(() {
                      _edit.img = file.path;
                    });
                  });
                },
              ),
              TextField(
                decoration: InputDecoration(labelText: "Nome:"),
                controller: _nameEdit,
                focusNode: _nameFocus,
                onChanged: (text) {
                  _useredit = true;
                  setState(() {
                    _edit.name = text;
                  });
                },
              ),
              TextField(
                decoration: InputDecoration(labelText: "Email:"),
                controller: _emailEdit,
                onChanged: (text) {
                  _useredit = true;
                  _edit.email = text;
                },
                keyboardType: TextInputType.emailAddress,
              ),
              TextField(
                decoration: InputDecoration(labelText: "Telefone:"),
                controller: _phoneEdit,
                onChanged: (text) {
                  _useredit = true;
                  _edit.phone = text;
                },
                keyboardType: TextInputType.phone,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> _requestPop() {
    if (_useredit) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Deescartar alterações?"),
              content: Text("Se sair as alterações serão perdidas"),
              actions: <Widget>[
                FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Cancelar"),
                ),
                FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  child: Text("Sim"),
                ),
              ],
            );
          });
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }
}
