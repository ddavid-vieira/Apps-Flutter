import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:scoped_model/scoped_model.dart';

class UserModel extends Model {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser firebaseUser;
  Map<String, dynamic> userData = Map();
  bool isLoading = false;
  static UserModel of(BuildContext context) =>
      ScopedModel.of<UserModel>(context);
  @override
  void addListener(VoidCallback listener) {
    super.addListener(listener);
    _loadCurrenteUser();
  }

  void signUp(
      {@required Map<String, dynamic> userData,
      @required String pass,
      @required VoidCallback onSuccess,
      @required VoidCallback onFail}) async {
    isLoading = true;
    notifyListeners();
    _auth
        .createUserWithEmailAndPassword(
            email: userData["email"], password: pass)
        .then((user) async {
      await _saveUserData(userData, user);
      onSuccess();
      isLoading = false;
      notifyListeners();
    }).catchError((e) {
      print(e);
      onFail();
      isLoading = false;
      notifyListeners();
    });
  }

  void signIn(
      {@required String email,
      @required String password,
      @required VoidCallback onSuccess,
      @required VoidCallback onFail}) {
    isLoading = true;
    notifyListeners();
    _auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((user) async {
      firebaseUser = user;
      await _loadCurrenteUser();
      onSuccess();
      isLoading = false;
      notifyListeners();
    }).catchError((e) {
      print(e);
      onFail();
      isLoading = false;
      notifyListeners();
    });
  }

  void signOut() async {
    await _auth.signOut();
    userData = Map();
    firebaseUser = null;
    notifyListeners();
  }

  void recoverPass(String email) {
    _auth.sendPasswordResetEmail(email: email);
  }

  bool islogged() {
    if (firebaseUser != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<Null> _saveUserData(
      Map<String, dynamic> userData, FirebaseUser user) async {
    this.userData = userData;
    await Firestore.instance
        .collection("users")
        .document(user.uid)
        .setData(userData);
  }

  Future<Null> _loadCurrenteUser() async {
    if (firebaseUser == null) {
      firebaseUser = await _auth.currentUser();
    }
    if (firebaseUser != null) {
      if (userData["name"] == null) {
        DocumentSnapshot doc = await Firestore.instance
            .collection("users")
            .document(firebaseUser.uid)
            .get();
        userData = doc.data;
      }
    }
    notifyListeners();
  }
}
