import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:loja_virtual/datas/CartProduct.dart';
import 'package:scoped_model/scoped_model.dart';

import 'Usermodel.dart';

class CartModel extends Model {
  List<CartProduct> products = [];
  bool isloading = false;
  UserModel user;
  String cuponCode;
  int discountPercentege = 0;
  CartModel(this.user) {
    if (user.islogged()) loadCart();
  }
  static CartModel of(BuildContext context) =>
      ScopedModel.of<CartModel>(context);
  void addCart(CartProduct cartproduct) {
    products.add(cartproduct);
    Firestore.instance
        .collection('users')
        .document(user.firebaseUser.uid)
        .collection("cart")
        .add(cartproduct.toMap())
        .then((doc) {
      cartproduct.cid = doc.documentID;
    });
    notifyListeners();
  }

  void removeCart(CartProduct cartproduct) {
    products.remove(cartproduct);
    Firestore.instance
        .collection('users')
        .document(user.firebaseUser.uid)
        .collection("cart")
        .document(cartproduct.cid)
        .delete();
    notifyListeners();
  }

  void decProduct(CartProduct cartproduct) {
    cartproduct.quantity--;
    Firestore.instance
        .collection('users')
        .document(user.firebaseUser.uid)
        .collection('cart')
        .document(cartproduct.cid)
        .updateData(cartproduct.toMap());
    notifyListeners();
  }

  void incProduct(CartProduct cartproduct) {
    cartproduct.quantity++;
    Firestore.instance
        .collection('users')
        .document(user.firebaseUser.uid)
        .collection('cart')
        .document(cartproduct.cid)
        .updateData(cartproduct.toMap());
    notifyListeners();
  }

  void setCoupon(String coupunCode, int discountPercentege) {
    this.cuponCode = coupunCode;
    this.discountPercentege = discountPercentege;
  }

  double getProductPrice() {
    double price = 0;
    for (CartProduct c in products) {
      if (c.productdata != null) {
        price += c.quantity * c.productdata.preco;
      }
    }
    return price;
  }

  void updatePrices() {
    notifyListeners();
  }

  double getShipPrice() {
    return getProductPrice() * 11 / 100;
  }

  double getDiscount() {
    return getProductPrice() * discountPercentege / 100;
  }

  Future<String> finishOrder() async {
    if (products.length == 0) return null;
    isloading = true;
    notifyListeners();
    double price = getProductPrice();
    double discount = getDiscount();
    double ship = getShipPrice();
    DocumentReference ref = await Firestore.instance.collection('orders').add(
      {
        'clientID': user.firebaseUser.uid,
        'products': products.map((cartProduct) => cartProduct.toMap()).toList(),
        'shipPrice': ship,
        'productsPrice': price,
        'dicount': discount,
        'totalPrice': ship + price - discount,
        'status': 1
      },
    );
    await Firestore.instance
        .collection('users')
        .document(user.firebaseUser.uid)
        .collection('orders')
        .document(ref.documentID)
        .setData({'orderID': ref.documentID});

    QuerySnapshot query = await Firestore.instance
        .collection('users')
        .document(user.firebaseUser.uid)
        .collection('cart')
        .getDocuments();
    for (DocumentSnapshot document in query.documents) {
      document.reference.delete();
    }
    products.clear();
    cuponCode = null;
    discountPercentege = 0;
    isloading = false;
    notifyListeners();
    return ref.documentID;
  }

  void loadCart() async {
    QuerySnapshot q = await Firestore.instance
        .collection('users')
        .document(user.firebaseUser.uid)
        .collection('cart')
        .getDocuments();
    products = q.documents.map((e) => CartProduct.fromDocument(e)).toList();
  }
}
