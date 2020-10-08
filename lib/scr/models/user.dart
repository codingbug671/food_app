import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  static const NAME = "name";
  static const EMAIL = "email";
  static const ID = "id";

  static const CART = "cart";

  String _name;
  String _email;
  String _id;

  int _priceSum = 0;

  List _cart;
  int totalCartPrice;

  String get name => _name;
  String get email => _email;
  String get id => _id;

  List get cart => _cart;

  UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    _name = snapshot.data[NAME];
    _email = snapshot.data[EMAIL];
    _id = snapshot.data[ID];

    _cart = snapshot.data[CART] ?? [];
    totalCartPrice = snapshot.data[CART] == null
        ? 0
        : getTotalPrice(cart: snapshot.data[CART]);
  }

  int getTotalPrice({List cart}) {
    if (cart == null) {
      return 0;
    }
    for (Map cartItem in cart) {
      _priceSum += cartItem["price"] * cartItem["quantity"];
    }

    int total = _priceSum;

    return total;
  }
}
