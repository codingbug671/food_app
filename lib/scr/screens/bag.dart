import 'package:flutter/material.dart';
import 'package:flutter_foodapp/scr/helpers/common.dart';
import 'package:flutter_foodapp/scr/models/products.dart';
import 'package:flutter_foodapp/scr/widgets/custom_text.dart';

class ShoppingBag extends StatefulWidget {
  @override
  _ShoppingBagState createState() => _ShoppingBagState();
}

class _ShoppingBagState extends State<ShoppingBag> {
  Product product = Product(
      name: "Cereals",
      image: "1.jpg",
      price: 5.99,
      rating: 4.2,
      vendor: "GoodFood",
      wishList: true);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: black),
          backgroundColor: white,
          elevation: 0,
          centerTitle: true,
          title: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: CustomText(
              text: "Shopping Bag",
              size: 24,
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Image.asset(
                      "images/shopping-bag.png",
                      height: 30,
                      width: 30,
                    ),
                  ),
                  Positioned(
                    right: 8,
                    bottom: 1,
                    child: Container(
                        decoration: BoxDecoration(
                            color: white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  color: grey,
                                  offset: Offset(2, 1),
                                  blurRadius: 3)
                            ]),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                          child: CustomText(
                              text: "2",
                              color: red,
                              size: 16,
                              weight: FontWeight.bold),
                        )),
                  )
                ],
              ),
            ),
          ],
        ),
        backgroundColor: white,
        body: ListView(children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
                height: 120,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(color: white, boxShadow: [
                  BoxShadow(
                      color: Colors.red[100],
                      offset: Offset(3, 5),
                      blurRadius: 30)
                ]),
                child: Row(
                  children: [
                    Image.asset("images/${product.image}",
                        height: 120, width: 120),
                    Expanded(
                      child: RichText(
                        text: TextSpan(children: [
                          TextSpan(
                              text: product.name + "\n",
                              style: TextStyle(color: black, fontSize: 20)),
                          TextSpan(
                              text: "\$${product.price}",
                              style: TextStyle(
                                  color: black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold))
                        ]),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: null,
                    )
                  ],
                )),
          )
        ]));
  }
}
