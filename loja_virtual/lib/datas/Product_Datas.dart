import 'package:cloud_firestore/cloud_firestore.dart';

class ProductData {
  String categoria;
  String id;
  String title;
  String descricao;
  double preco;
  String image;
  ProductData.fromDocument(DocumentSnapshot snapshot) {
    id = snapshot.documentID;
    title = snapshot.data['title'];
    descricao = snapshot.data['Descrição'];
    preco = snapshot.data['preço'] + 0.0;
    image = snapshot.data['imagem'];
  }
  Map<String, dynamic> toResumedMap() {
    return {
      'title': title,
      'Descrição': descricao,
      'preço': preco,
    };
  }
}
