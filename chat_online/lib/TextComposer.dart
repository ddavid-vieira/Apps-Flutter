import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class TextComposer extends StatefulWidget {
  TextComposer(this.sendMessage);
  final Function({String text, File imgFile}) sendMessage;
  @override
  _TextComposerState createState() => _TextComposerState();
}

class _TextComposerState extends State<TextComposer> {
  void _reset() {
    _controller.clear();
    setState(() {
      _isComposer = false;
    });
  }

  bool _isComposer = false;
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.photo_camera, size: 25.0),
            onPressed: () async {
              final File imgFile =
                  // ignore: deprecated_member_use
                  await ImagePicker.pickImage(source: ImageSource.camera);
              if (imgFile == null)
                return;
              else {
                widget.sendMessage(imgFile: imgFile);
              }
            },
          ),
          IconButton(
            icon: Icon(
              Icons.add_photo_alternate,
              size: 25.0,
            ),
            onPressed: () async {
              final File imgFile =
                  // ignore: deprecated_member_use
                  await ImagePicker.pickImage(source: ImageSource.gallery);
              if (imgFile == null)
                return;
              else {
                widget.sendMessage(imgFile: imgFile);
              }
            },
          ),
          Expanded(
            child: TextField(
              controller: _controller,
              decoration:
                  InputDecoration.collapsed(hintText: "Envie uma mensagem"),
              onChanged: (text) {
                setState(() {
                  _isComposer = text.isNotEmpty;
                });
              },
              /*onSubmitted: (text) {
                  widget.sendMessage(text: text);
                  _reset();
                }*/
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: _isComposer
                ? () {
                    widget.sendMessage(text: _controller.text);
                    _reset();
                  }
                : null,
          )
        ],
      ),
    );
  }
}
