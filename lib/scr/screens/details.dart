import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_foodapp/scr/helpers/common.dart';
import 'package:flutter_foodapp/scr/helpers/screen_navigation.dart';
import 'package:flutter_foodapp/scr/models/products.dart';
import 'package:flutter_foodapp/scr/providers/app.dart';
import 'package:flutter_foodapp/scr/providers/user.dart';
import 'package:flutter_foodapp/scr/screens/cart.dart';
import 'package:flutter_foodapp/scr/widgets/custom_text.dart';
import 'package:flutter_foodapp/scr/widgets/loading.dart';
import 'package:provider/provider.dart';

class Details extends StatefulWidget {
  final ProductModel product;

  const Details({@required this.product});

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  int quantity = 1;
  final _key = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    final app = Provider.of<AppProvider>(context);
    return Scaffold(
        key: _key,
        backgroundColor: white,
        body: SafeArea(
          child: app.isLoading
              ? Loading()
              : Column(
                  children: [
                    SizedBox(
                      height: 300,
                      child: Stack(
                        children: [
                          Carousel(
                              images: [
                                NetworkImage(widget.product.image),
                                NetworkImage(widget.product.image),
                                NetworkImage(widget.product.image)
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
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                  onTap: () {
                                    changeScreen(context, CartScreen());
                                  },
                                  child: Image.asset(
                                    "images/shopping-bag.png",
                                    height: 30,
                                    width: 30,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    CustomText(
                      text: widget.product.name,
                      size: 26,
                      weight: FontWeight.bold,
                    ),
                    CustomText(
                      text: "\$${widget.product.price / 100}",
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
                            onPressed: () {
                              if (quantity != 1) {
                                setState(() {
                                  quantity -= 1;
                                });
                              }
                            }),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: GestureDetector(
                            onTap: () async {
                              app.changeLoading();
                              bool value = await user.addToCart(
                                  product: widget.product, quantity: quantity);
                              if (value) {
                                print("Item added to cart");
                                _key.currentState.showSnackBar(
                                    SnackBar(content: Text("Added to Cart!")));
                                user.reloadUserModel();

                                app.changeLoading();
                                return;
                              } else {
                                print("Item NOT added to cart");
                              }
                            },
                            child: Container(
                              width: 250,
                              height: 60,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: red,
                              ),
                              child: CustomText(
                                text: "Add  $quantity to Bag",
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
                            onPressed: () {
                              setState(() {
                                quantity += 1;
                              });
                            }),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomText(
                        text: widget.product.description,
                        size: 14,
                        weight: FontWeight.normal,
                      ),
                    )
                  ],
                ),
        ));
  }
}
