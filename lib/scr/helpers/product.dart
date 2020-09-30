import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_foodapp/scr/models/products.dart';

class ProductServices {
  String collection = "products";
  Firestore _firestore = Firestore.instance;

  Future<List<ProductModel>> getProducts() async =>
      _firestore.collection(collection).getDocuments().then((result) {
        List<ProductModel> products = [];

        for (DocumentSnapshot product in result.documents) {
          products.add(ProductModel.fromSnapshot(product));
        }

        return products;
      });
}
