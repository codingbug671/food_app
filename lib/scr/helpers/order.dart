import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_foodapp/scr/models/order.dart';

class OrderServices {
  String collection = "orders";
  Firestore _firestore = Firestore.instance;

  Future<List<OrderModel>> getUserOrders({String userId}) async => _firestore
          .collection(collection)
          .where("userId", isEqualTo: userId)
          .getDocuments()
          .then((result) {
        List<OrderModel> orders = [];
        for (DocumentSnapshot order in result.documents) {
          orders.add(OrderModel.fromSnapshot(order));
        }
        return orders;
      });

  void createOrder(
      {String userId,
      String id,
      String status,
      String description,
      List cart,
      int totalPrice}) {
    _firestore.collection(collection).document(id).setData({
      "userId": userId,
      "id": id,
      "cart": cart,
      "total": totalPrice,
      "createdAt": DateTime.now().millisecondsSinceEpoch,
      "description": description,
      "status": status
    });
  }
}
