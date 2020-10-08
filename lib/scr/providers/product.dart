import 'package:flutter/material.dart';
import 'package:flutter_foodapp/scr/helpers/product.dart';
import 'package:flutter_foodapp/scr/models/products.dart';

class ProductProvider with ChangeNotifier {
  ProductServices _productServices = ProductServices();
  List<ProductModel> products = [];
  List<ProductModel> productsbyRestaurant = [];
  List<ProductModel> productsbyCategory = [];
  List<ProductModel> productSearched = [];

  ProductProvider.initalize() {
    _loadProducts();
  }

  _loadProducts() async {
    products = await _productServices.getProducts();
    notifyListeners();
  }

  Future loadProductsbyRestaurant(int restaurantId) async {
    productsbyRestaurant =
        await _productServices.getProductsbyRestaurant(id: restaurantId);
    notifyListeners();
  }

  Future search(String productName) async {
    productSearched =
        await _productServices.searchProducts(productName: productName);
    notifyListeners();
  }

  Future loadProductsbyCategory(String categoryName) async {
    productsbyCategory =
        await _productServices.getProductsOfCategory(category: categoryName);
    notifyListeners();
  }
}
