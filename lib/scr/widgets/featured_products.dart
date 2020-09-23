import 'package:flutter/material.dart';
import 'package:flutter_foodapp/scr/helpers/common.dart';
import 'package:flutter_foodapp/scr/helpers/screen_navigation.dart';
import 'package:flutter_foodapp/scr/models/products.dart';
import 'package:flutter_foodapp/scr/screens/details.dart';
import 'package:flutter_foodapp/scr/widgets/custom_text.dart';

List<Product> productList = [
  Product(
      name: "Cereals",
      image: "1.jpg",
      price: 5.99,
      rating: 4.2,
      vendor: "GoodFood",
      wishList: true),
  Product(
      name: "Taccos",
      image: "5.jpg",
      price: 12.99,
      rating: 4.7,
      vendor: "GoodFood",
      wishList: false),
  Product(
      name: "Cereals",
      image: "1.jpg",
      price: 5.99,
      rating: 4.2,
      vendor: "GoodFood",
      wishList: true),
];

class Featured extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 240,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: productList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  changeScreen(context, Details(product: productList[index]));
                },
                child: Container(
                  height: 240,
                  width: 200,
                  decoration: BoxDecoration(color: white, boxShadow: [
                    BoxShadow(
                      color: Colors.red[50],
                      offset: Offset(15, 1),
                      blurRadius: 4,
                    )
                  ]),
                  child: Column(
                    children: [
                      Image.asset("images/${productList[index].image}",
                          height: 140, width: 140),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CustomText(
                              text: "${productList[index].name}",
                            ),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey[300],
                                      offset: Offset(15, 5),
                                      blurRadius: 30,
                                    )
                                  ]),
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: productList[index].wishList
                                    ? Icon(
                                        Icons.favorite_sharp,
                                        color: red,
                                        size: 18,
                                      )
                                    : Icon(
                                        Icons.favorite_border,
                                        color: red,
                                        size: 18,
                                      ),
                              ),
                            ),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: CustomText(
                                text: "${productList[index].rating}",
                                color: grey,
                                size: 14,
                              ),
                            ),
                            SizedBox(
                              width: 2,
                            ),
                            Icon(
                              Icons.star,
                              color: red,
                              size: 16,
                            ),
                            Icon(
                              Icons.star,
                              color: red,
                              size: 16,
                            ),
                            Icon(
                              Icons.star,
                              color: red,
                              size: 16,
                            ),
                            Icon(
                              Icons.star,
                              color: red,
                              size: 16,
                            ),
                            Icon(
                              Icons.star,
                              color: grey,
                              size: 16,
                            )
                          ]),
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: CustomText(
                              text: "\$${productList[index].price}",
                              weight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
