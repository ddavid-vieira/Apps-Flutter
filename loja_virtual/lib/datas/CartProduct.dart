import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loja_virtual/datas/Product_Datas.dart';

class CartProduct {
  CartProduct();
  String cid;
  String category;
  String pid;
  int quantity;
  ProductData productdata;
  CartProduct.fromDocument(DocumentSnapshot document) {
    cid = document.documentID;
    category = document['category'];
    pid = document['pid'];
    quantity = document['quantity'];
  }
  Map<String, dynamic> toMap() {
    return {
      'category': category,
      'pid': pid,
      'quantity': quantity,
      'product': productdata.toResumedMap(),
    };
  }
}
