import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_foodapp/scr/helpers/order.dart';
import 'package:flutter_foodapp/scr/helpers/user.dart';
import 'package:flutter_foodapp/scr/models/order.dart';
import 'package:flutter_foodapp/scr/models/products.dart';
import 'package:flutter_foodapp/scr/models/user.dart';
import 'package:uuid/uuid.dart';

enum Status { Uninitialized, Unauthenticated, Authenticating, Authenticated }

class UserProvider with ChangeNotifier {
  FirebaseAuth _auth;
  FirebaseUser _user;
  Status _status = Status.Uninitialized;
  UserServices _userServices = UserServices();
  UserModel _userModel;
  OrderServices _orderServices = OrderServices();

  List<OrderModel> orders = [];

  //getters

  Status get status => _status;
  FirebaseUser get user => _user;
  UserModel get userModel => _userModel;

  final formKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  UserProvider.initalize() : _auth = FirebaseAuth.instance {
    _auth.onAuthStateChanged.listen(_onStateChanged);
  }

  Future<bool> signIn() async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      await _auth.signInWithEmailAndPassword(
          email: email.text, password: password.text);
      return true;
    } catch (e) {
      _status = Status.Unauthenticated;
      notifyListeners();
      print("Error: " + e.toString());
      return false;
    }
  }

  getOrders() async {
    orders = await _orderServices.getUserOrders(userId: _user.uid);
    notifyListeners();
  }

  Future<bool> signUp() async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      await _auth
          .createUserWithEmailAndPassword(
              email: email.text.trim(), password: password.text.trim())
          .then((user) {
        Map<String, dynamic> values = {
          "name": username.text,
          "email": email.text,
          "id": user.user.uid,
          "cart": [],
        };

        _userServices.createUser(values);
      });
      return true;
    } catch (e) {
      _status = Status.Unauthenticated;
      notifyListeners();
      print(e.toString());
      return false;
    }
  }

  Future<bool> addToCart({ProductModel product, int quantity}) async {
    try {
      var uuid = Uuid();
      String cartItemId = uuid.v4();

      Map cartItem = {
        "id": cartItemId,
        "name": product.name,
        "image": product.image,
        "productId": product.id,
        "price": product.price,
        "quantity": quantity
      };

      _userServices.addToCart(userId: _userModel.id, cartItem: cartItem);

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> removeFromCart({Map cartItem}) async {
    try {
      _userServices.removeFromCart(userId: _userModel.id, cartItem: cartItem);

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> signOut() {
    _auth.signOut();
    _status = Status.Unauthenticated;
    notifyListeners();
  }

  void CleanControllers() {
    email.text = "";
    password.text = "";
    username.text = "";
  }

  Future<void> _onStateChanged(FirebaseUser firebaseUser) async {
    if (firebaseUser == null) {
      _status = Status.Unauthenticated;
    } else {
      _user = firebaseUser;
      _status = Status.Authenticated;

      _userModel = await _userServices.getUserbyId(firebaseUser.uid);
    }
    notifyListeners();
  }

  Future<void> reloadUserModel() async {
    _userModel = await _userServices.getUserbyId(user.uid);
    notifyListeners();
  }
}
