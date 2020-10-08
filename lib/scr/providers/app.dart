import 'package:flutter/material.dart';

enum SearchBy { PRODUCTS, RESTAURANTS }

class AppProvider with ChangeNotifier {
  bool isLoading = false;
  SearchBy search = SearchBy.PRODUCTS;
  int totalPrice = 0;

  void changeLoading() {
    isLoading = !isLoading;
    notifyListeners();
  }

  void changeTotal({int newTotal}) {
    totalPrice = newTotal;
    notifyListeners();
  }

  void changeSearchBy({SearchBy newSearchBy}) {
    search = newSearchBy;
    if (newSearchBy == SearchBy.PRODUCTS) {
    } else {
      search = SearchBy.RESTAURANTS;
    }
    notifyListeners();
  }
}
