import 'package:cloud_firestore/cloud_firestore.dart';

class CartItemModel {
  static const ID = "id";
  static const NAME = "name";
  static const IMAGE = "image";
  static const PRODUCT_ID = "productId";
  static const QUANTITY = "quantity";
  static const PRICE = "price";
  static const RESTAURANT_ID = "restaurantId";
  static const TOTAL_RESTAURANT_SALES = "totalRestaurantSale";

  String _id;
  String _name;
  String _image;
  String _productId;
  String _restaurantId;
  int _totalRestaurantSale;
  int _quantity;
  int _price;

  //  getters
  String get id => _id;

  String get name => _name;

  String get image => _image;

  String get productId => _productId;

  String get restaurantId => _restaurantId;

  int get price => _price;

  int get totalRestaurantSale => _totalRestaurantSale;

  int get quantity => _quantity;

  CartItemModel.fromSnapshot(DocumentSnapshot snapshot) {
    _id = snapshot.data[ID];
    _name = snapshot.data[NAME];
    _image = snapshot.data[IMAGE];
    _productId = snapshot.data[PRODUCT_ID];
    _price = snapshot.data[PRICE];
    _quantity = snapshot.data[QUANTITY];
    _totalRestaurantSale = snapshot.data[TOTAL_RESTAURANT_SALES];
    _restaurantId = snapshot.data[RESTAURANT_ID];
  }
}
