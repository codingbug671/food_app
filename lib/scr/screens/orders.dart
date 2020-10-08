import 'package:flutter/material.dart';
import 'package:flutter_foodapp/scr/helpers/common.dart';
import 'package:flutter_foodapp/scr/models/order.dart';
import 'package:flutter_foodapp/scr/providers/app.dart';
import 'package:flutter_foodapp/scr/providers/user.dart';
import 'package:flutter_foodapp/scr/widgets/custom_text.dart';

import 'package:provider/provider.dart';

class OrdersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    final app = Provider.of<AppProvider>(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: black),
        backgroundColor: white,
        elevation: 0.0,
        title: CustomText(text: "Orders"),
        leading: IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      backgroundColor: white,
      body: ListView.builder(
          itemCount: user.orders.length,
          itemBuilder: (_, index) {
            OrderModel _order = user.orders[index];
            return ListTile(
              leading: CustomText(
                text: "\$${_order.total / 100}",
                weight: FontWeight.bold,
              ),
              title: Text(_order.description),
              subtitle: Text(
                  DateTime.fromMillisecondsSinceEpoch(_order.createdat)
                      .toString()),
              trailing: CustomText(
                text: _order.status,
                color: Colors.green,
              ),
            );
          }),
    );
  }
}
