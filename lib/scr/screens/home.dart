import 'package:flutter/material.dart';

import 'package:flutter_foodapp/scr/helpers/screen_navigation.dart';
import 'package:flutter_foodapp/scr/providers/category.dart';
import 'package:flutter_foodapp/scr/providers/restaurant.dart';

import 'package:flutter_foodapp/scr/screens/bag.dart';

import 'package:flutter_foodapp/scr/widgets/categories.dart';
import 'package:flutter_foodapp/scr/widgets/custom_text.dart';
import 'package:flutter_foodapp/scr/widgets/featured_products.dart';
import 'package:flutter_foodapp/scr/widgets/restaurant.dart';

import 'package:flutter_foodapp/scr/providers/user.dart';
import 'package:provider/provider.dart';

import '../helpers/common.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    final categoryProvider = Provider.of<CategoryProvider>(context);
    final restaurantProvider = Provider.of<RestaurantProvider>(context);

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: white),
        backgroundColor: black,
        elevation: 0.5,
        title: CustomText(text: "Food App", color: white, size: 20),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  changeScreen(context, ShoppingBag());
                },
              ),
              Positioned(
                top: 12,
                right: 12,
                child: Container(
                  height: 10,
                  width: 10,
                  decoration: BoxDecoration(
                      color: red, borderRadius: BorderRadius.circular(20)),
                ),
              )
            ],
          ),
          Stack(
            children: [
              IconButton(
                icon: Icon(Icons.notifications_none),
                onPressed: () {},
              ),
              Positioned(
                top: 12,
                right: 12,
                child: Container(
                  height: 10,
                  width: 10,
                  decoration: BoxDecoration(
                      color: red, borderRadius: BorderRadius.circular(20)),
                ),
              )
            ],
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
                decoration: BoxDecoration(color: black),
                accountName: CustomText(
                    text: user.userModel?.name ?? "username loading...",
                    color: white,
                    weight: FontWeight.bold,
                    size: 18),
                accountEmail: CustomText(
                    text: user.userModel?.email ?? "email loading...",
                    color: grey,
                    weight: FontWeight.bold,
                    size: 18)),
            ListTile(
              onTap: () {
                changeScreen(context, Home());
              },
              leading: Icon(Icons.home),
              title: CustomText(text: "Home"),
            ),
            ListTile(
              onTap: () {
                changeScreen(context, ShoppingBag());
              },
              leading: Icon(Icons.shopping_cart),
              title: CustomText(text: "Cart"),
            ),
            ListTile(
              onTap: () {},
              leading: Icon(Icons.person),
              title: CustomText(text: "Account"),
            ),
          ],
        ),
      ),
      backgroundColor: white,
      body: SafeArea(
        child: ListView(children: [
          Container(
            decoration: BoxDecoration(
                color: black,
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20))),
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 8.0, left: 8.0, right: 8.0, bottom: 15),
              child: Container(
                  decoration: BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ListTile(
                    leading: Icon(Icons.search, color: red),
                    title: TextField(
                      decoration: InputDecoration(
                        hintText: "Find food and restaurant",
                        border: InputBorder.none,
                      ),
                    ),
                    trailing: Icon(Icons.filter_list, color: red),
                  )),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
              height: 100,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categoryProvider.categories.length,
                  itemBuilder: (context, index) {
                    return CategoryWidget(
                        category: categoryProvider.categories[index]);
                  })),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomText(
              text: "Featured",
              size: 20,
              color: grey,
            ),
          ),
          Featured(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomText(
              text: "Popular",
              size: 20,
              color: grey,
            ),
          ),
          Column(
            children: restaurantProvider.restaurants
                .map((item) => GestureDetector(
                      onTap: () async {},
                      child: RestaurantWidget(
                        restaurant: item,
                      ),
                    ))
                .toList(),
          )
        ]),
      ),
    );
  }
}
