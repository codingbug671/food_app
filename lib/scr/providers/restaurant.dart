import 'package:flutter/material.dart';
import 'package:flutter_foodapp/scr/helpers/restaurant.dart';
import 'package:flutter_foodapp/scr/models/restaurant.dart';

class RestaurantProvider with ChangeNotifier {
  RestaurantServices _restaurantServices = RestaurantServices();
  List<RestaurantModel> restaurants = [];

  RestaurantProvider.initalize() {
    _loadRestaurants();
  }

  _loadRestaurants() async {
    restaurants = await _restaurantServices.getRestaurants();
    notifyListeners();
  }
}
