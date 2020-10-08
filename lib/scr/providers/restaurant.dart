import 'package:flutter/material.dart';
import 'package:flutter_foodapp/scr/helpers/restaurant.dart';
import 'package:flutter_foodapp/scr/models/restaurant.dart';

class RestaurantProvider with ChangeNotifier {
  RestaurantServices _restaurantServices = RestaurantServices();
  List<RestaurantModel> restaurants = [];
  RestaurantModel restaurant;
  List<RestaurantModel> restaurantSearched = [];

  RestaurantProvider.initalize() {
    _loadRestaurants();
    search("abc");
  }

  _loadRestaurants() async {
    restaurants = await _restaurantServices.getRestaurants();
    notifyListeners();
  }

  Future search(String restaurantName) async {
    restaurantSearched = await _restaurantServices.searchRestaurants(
        restaurantName: restaurantName);
    notifyListeners();
  }

  loadRestaurantsbyId(int id) async {
    restaurant = await _restaurantServices.getRestaurantbyId(id);
    notifyListeners();
  }
}
