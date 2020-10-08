import 'package:flutter/material.dart';

import 'package:flutter_foodapp/scr/helpers/screen_navigation.dart';
import 'package:flutter_foodapp/scr/providers/app.dart';
import 'package:flutter_foodapp/scr/providers/category.dart';
import 'package:flutter_foodapp/scr/providers/product.dart';
import 'package:flutter_foodapp/scr/providers/restaurant.dart';

import 'package:flutter_foodapp/scr/screens/cart.dart';
import 'package:flutter_foodapp/scr/screens/login.dart';
import 'package:flutter_foodapp/scr/screens/orders.dart';
import 'package:flutter_foodapp/scr/screens/product_search.dart';
import 'package:flutter_foodapp/scr/screens/restaurant.dart';
import 'package:flutter_foodapp/scr/screens/restaurant_search.dart';

import 'package:flutter_foodapp/scr/widgets/categories.dart';
import 'package:flutter_foodapp/scr/screens/category.dart';
import 'package:flutter_foodapp/scr/widgets/custom_text.dart';
import 'package:flutter_foodapp/scr/widgets/all_products.dart';
import 'package:flutter_foodapp/scr/widgets/loading.dart';
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
    final app = Provider.of<AppProvider>(context);
    final categoryProvider = Provider.of<CategoryProvider>(context);
    final restaurantProvider = Provider.of<RestaurantProvider>(context);
    final productProvider = Provider.of<ProductProvider>(context);

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: white),
        backgroundColor: black,
        elevation: 0.5,
        title: CustomText(text: "Tasty Food", color: white, size: 20),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              changeScreen(context, CartScreen());
            },
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
                changeScreen(context, CartScreen());
              },
              leading: Icon(Icons.shopping_cart),
              title: CustomText(text: "Cart"),
            ),
            ListTile(
              onTap: () async {
                await user.getOrders();
                changeScreen(context, OrdersScreen());
              },
              leading: Icon(Icons.bookmark_border),
              title: CustomText(text: "My orders"),
            ),
            ListTile(
              onTap: () {
                user.signOut();
                changeScreen(context, LoginScreen());
              },
              leading: Icon(Icons.person),
              title: CustomText(text: "Sign Out"),
            ),
          ],
        ),
      ),
      backgroundColor: white,
      body: app.isLoading
          ? Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Loading(),
                ],
              ),
            )
          : SafeArea(
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
                              textInputAction: TextInputAction.search,
                              onSubmitted: (pattern) async {
                                if (app.search == SearchBy.PRODUCTS) {
                                  app.changeLoading();
                                  await productProvider.search(pattern);
                                  app.changeLoading();
                                  changeScreen(context, ProductSearchScreen());
                                } else {
                                  app.changeLoading();
                                  await restaurantProvider.search(pattern);
                                  app.changeLoading();
                                  changeScreen(
                                      context, RestaurantsSearchScreen());
                                }
                              },
                              decoration: InputDecoration(
                                hintText: "Find food and restaurant",
                                border: InputBorder.none,
                              ),
                            ),
                            trailing: DropdownButton<String>(
                              icon: Icon(Icons.filter_list, color: red),
                              elevation: 0,
                              onChanged: (value) {
                                if (value == "Search by Products") {
                                  app.changeSearchBy(
                                      newSearchBy: SearchBy.PRODUCTS);
                                } else {
                                  app.changeSearchBy(
                                      newSearchBy: SearchBy.RESTAURANTS);
                                }
                              },
                              items: <String>[
                                "Search by Products",
                                "Search by Restaurants"
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                    value: value, child: Text(value));
                              }).toList(),
                            ))),
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
                          return GestureDetector(
                            onTap: () async {
                              // app.changeLoading();
                              await productProvider.loadProductsbyCategory(
                                  categoryProvider.categories[index].name);
                              // app.changeLoading();
                              changeScreen(
                                  context,
                                  CategoryScreen(
                                      categoryModel:
                                          categoryProvider.categories[index]));
                            },
                            child: CategoryWidget(
                                category: categoryProvider.categories[index]),
                          );
                        })),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomText(
                    text: "Products",
                    size: 20,
                    color: grey,
                  ),
                ),
                Products(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomText(
                    text: "Restaurants",
                    size: 20,
                    color: grey,
                  ),
                ),
                SingleChildScrollView(
                  child: Column(
                    children: restaurantProvider.restaurants
                        .map((item) => GestureDetector(
                              onTap: () async {
                                app.changeLoading();
                                await productProvider
                                    .loadProductsbyRestaurant(item.id);
                                app.changeLoading();
                                changeScreen(context,
                                    RestaurantScreen(restaurantModel: item));
                              },
                              child: RestaurantWidget(
                                restaurant: item,
                              ),
                            ))
                        .toList(),
                  ),
                )
              ]),
            ),
    );
  }
}
