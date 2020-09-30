import 'package:flutter/material.dart';
import 'package:flutter_foodapp/scr/helpers/product.dart';
import 'package:flutter_foodapp/scr/models/products.dart';

class ProductProvider with ChangeNotifier {
  ProductServices _productServices = ProductServices();
  List<ProductModel> products = [];

  ProductProvider.initalize() {
    _loadProducts();
  }

  _loadProducts() async {
    products = await _productServices.getProducts();
    notifyListeners();
  }
}
