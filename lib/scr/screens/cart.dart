import 'package:flutter/material.dart';
import 'package:flutter_foodapp/scr/helpers/common.dart';
import 'package:flutter_foodapp/scr/helpers/order.dart';
import 'package:flutter_foodapp/scr/models/products.dart';
import 'package:flutter_foodapp/scr/providers/app.dart';
import 'package:flutter_foodapp/scr/providers/user.dart';
import 'package:flutter_foodapp/scr/widgets/custom_text.dart';
import 'package:flutter_foodapp/scr/widgets/loading.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final _key = GlobalKey<ScaffoldState>();
  ProductModel product;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    final app = Provider.of<AppProvider>(context);
    OrderServices _orderServices = OrderServices();

    return Scaffold(
        key: _key,
        appBar: AppBar(
          iconTheme: IconThemeData(color: black),
          backgroundColor: white,
          elevation: 0,
          centerTitle: true,
          title: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: CustomText(
              text: "Shopping Cart",
              size: 24,
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Image.asset(
                "images/shopping-bag.png",
                height: 30,
                width: 30,
              ),
            ),
          ],
        ),
        backgroundColor: white,
        body: app.isLoading
            ? Loading()
            : ListView.builder(
                itemCount: user.userModel.cart.length,
                itemBuilder: (context, index) {
                  return Padding(
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
                              Image.network(
                                user.userModel.cart[index]['image'],
                                height: 120,
                                width: 140,
                                fit: BoxFit.fill,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: RichText(
                                  text: TextSpan(children: [
                                    TextSpan(
                                        text: user.userModel.cart[index]
                                                ['name'] +
                                            "\n",
                                        style: TextStyle(
                                            color: black, fontSize: 20)),
                                    TextSpan(
                                        text:
                                            "\$${user.userModel.cart[index]['price'] / 100} \n",
                                        style: TextStyle(
                                            color: black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold)),
                                    TextSpan(
                                        text: "Quantity: ",
                                        style: TextStyle(
                                            color: black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold)),
                                    TextSpan(
                                        text: user
                                            .userModel.cart[index]['quantity']
                                            .toString(),
                                        style: TextStyle(
                                            color: black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold))
                                  ]),
                                ),
                              ),
                              IconButton(
                                  icon: Icon(Icons.delete),
                                  onPressed: () async {
                                    app.changeLoading();

                                    bool value = await user.removeFromCart(
                                        cartItem: user.userModel.cart[index]);
                                    if (value) {
                                      user.reloadUserModel();
                                      print("Item added to cart");
                                      _key.currentState.showSnackBar(SnackBar(
                                          content: Text("Removed from Cart!")));
                                      app.changeLoading();
                                      return;
                                    } else {
                                      print("ITEM WAS NOT REMOVED");
                                      app.changeLoading();
                                    }
                                  })
                            ],
                          )));
                }),
        bottomNavigationBar: Container(
          height: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RichText(
                    text: TextSpan(children: [
                  TextSpan(
                      text: "Total ",
                      style: TextStyle(color: black, fontSize: 22)),
                  TextSpan(
                      text: "\$${user.userModel.totalCartPrice / 100}",
                      style: TextStyle(
                          color: black,
                          fontSize: 22,
                          fontWeight: FontWeight.normal)),
                ])),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.deepOrange,
                        borderRadius: BorderRadius.circular(20)),
                    child: FlatButton(
                      onPressed: () {
                        if (user.userModel.totalCartPrice == 0) {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return Dialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          20.0)), //this right here
                                  child: Container(
                                    height: 200,
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Text(
                                                'Your cart is emty',
                                                textAlign: TextAlign.center,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              });
                          return;
                        }
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Dialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        20.0)), //this right here
                                child: Container(
                                  height: 200,
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CustomText(
                                            text:
                                                'You will be charged \$${user.userModel.totalCartPrice / 100} upon delivery'),
                                        SizedBox(
                                          width: 320.0,
                                          child: RaisedButton(
                                            onPressed: () async {
                                              var uuid = Uuid();
                                              String id = uuid.v4();

                                              _orderServices.createOrder(
                                                  userId: user.user.uid,
                                                  id: id,
                                                  description:
                                                      "Some random description",
                                                  status: "Complete",
                                                  totalPrice: user
                                                      .userModel.totalCartPrice,
                                                  cart: user.userModel.cart);
                                              for (Map cartItem
                                                  in user.userModel.cart) {
                                                bool value =
                                                    await user.removeFromCart(
                                                        cartItem: cartItem);
                                                if (value) {
                                                  user.reloadUserModel();

                                                  _key.currentState
                                                      .showSnackBar(SnackBar(
                                                          content: Text(
                                                              "Removed from Cart!")));

                                                  return;
                                                } else {
                                                  print("ITEM WAS NOT REMOVED");
                                                }
                                              }
                                              _key.currentState.showSnackBar(
                                                  SnackBar(
                                                      content: Text(
                                                          "Order Created")));
                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                              "Accept",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            color: const Color(0xFF1BC0C5),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 320.0,
                                          child: RaisedButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                              "Reject",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            color: red,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            });
                      },
                      child: CustomText(
                        text: "CheckOut",
                      ),
                    )),
              )
            ],
          ),
        ));
  }
}
