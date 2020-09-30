import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_foodapp/scr/helpers/common.dart';
import 'package:flutter_foodapp/scr/models/products.dart';
import 'package:flutter_foodapp/scr/widgets/custom_text.dart';

class Details extends StatelessWidget {
  final ProductModel product;

  const Details({@required this.product});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: white,
        body: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: 300,
                child: Stack(
                  children: [
                    Carousel(
                        images: [
                          NetworkImage(product.image),
                          NetworkImage(product.image),
                          NetworkImage(product.image)
                        ],
                        dotBgColor: white,
                        dotColor: grey,
                        dotIncreasedColor: red,
                        dotIncreaseSize: 1.5,
                        autoplay: false),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.arrow_back,
                            color: black,
                          ),
                        ),
                        Stack(children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(
                              "images/shopping-bag.png",
                              height: 30,
                              width: 30,
                            ),
                          ),
                          Positioned(
                            right: 5,
                            bottom: 2,
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
                                  padding: const EdgeInsets.only(
                                      left: 4.0, right: 4.0),
                                  child: CustomText(
                                      text: "2",
                                      color: red,
                                      size: 16,
                                      weight: FontWeight.bold),
                                )),
                          )
                        ])
                      ],
                    ),
                    Positioned(
                      right: 14,
                      bottom: 54,
                      child: Container(
                        decoration: BoxDecoration(
                            color: white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                  color: grey,
                                  offset: Offset(2, 1),
                                  blurRadius: 3)
                            ]),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.favorite,
                            size: 22,
                            color: red,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              CustomText(
                text: product.name,
                size: 26,
                weight: FontWeight.bold,
              ),
              CustomText(
                text: "\$${product.price / 100}",
                size: 20,
                color: red,
                weight: FontWeight.bold,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      icon: Icon(
                        Icons.remove,
                        size: 30,
                        color: red,
                      ),
                      onPressed: () {}),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: 250,
                        height: 60,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: red,
                        ),
                        child: CustomText(
                          text: "Add to Bag",
                          color: white,
                          size: 22,
                          weight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                      icon: Icon(
                        Icons.add,
                        size: 30,
                        color: red,
                      ),
                      onPressed: () {}),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomText(text: product.description, size: 14),
              )
            ],
          ),
        ));
  }
}
