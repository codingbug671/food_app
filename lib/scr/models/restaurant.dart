import 'package:cloud_firestore/cloud_firestore.dart';

class RestaurantModel {
  static const ID = "id";
  static const NAME = "name";
  static const AVG_PRICE = "avgPrice";
  static const RATING = "rating";
  static const RATES = "rates";
  static const IMAGE = "image";

  int _id;
  String _name;
  double _rating;
  double _avgPrice;
  String _image;

  int _rates;

  String get name => _name;
  int get id => _id;
  double get rating => _rating;
  double get avgPrice => _avgPrice;
  String get image => _image;

  int get rates => _rates;

  RestaurantModel.fromSnapshot(DocumentSnapshot snapshot) {
    _id = snapshot.data[ID];
    _name = snapshot.data[NAME];
    _rating = snapshot.data[RATING];
    _avgPrice = snapshot.data[AVG_PRICE];
    _image = snapshot.data[IMAGE];

    _rates = snapshot.data[RATES];
  }
}
