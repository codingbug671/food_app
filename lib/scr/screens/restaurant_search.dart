import 'package:flutter/material.dart';
import 'package:flutter_foodapp/scr/helpers/common.dart';
import 'package:flutter_foodapp/scr/helpers/screen_navigation.dart';
import 'package:flutter_foodapp/scr/providers/app.dart';
import 'package:flutter_foodapp/scr/providers/product.dart';
import 'package:flutter_foodapp/scr/providers/restaurant.dart';
import 'package:flutter_foodapp/scr/screens/restaurant.dart';
import 'package:flutter_foodapp/scr/widgets/custom_text.dart';
import 'package:flutter_foodapp/scr/widgets/loading.dart';

import 'package:flutter_foodapp/scr/widgets/restaurant.dart';
import 'package:provider/provider.dart';

class RestaurantsSearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final restaurantProvider = Provider.of<RestaurantProvider>(context);
    final productProvider = Provider.of<ProductProvider>(context);
    final app = Provider.of<AppProvider>(context);
    return Scaffold(
        appBar: AppBar(
          title: CustomText(text: "Restaurants", size: 20),
          centerTitle: true,
          elevation: 0.0,
          iconTheme: IconThemeData(color: black),
          backgroundColor: white,
          leading: IconButton(
              icon: Icon(Icons.close), onPressed: () => Navigator.pop(context)),
          actions: [
            IconButton(icon: Icon(Icons.shopping_cart), onPressed: () {})
          ],
        ),
        body: restaurantProvider.restaurantSearched.length < 1
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.search, color: grey, size: 30),
                    ],
                  ),
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText(
                          text: "No restaurants found",
                          color: grey,
                          weight: FontWeight.normal,
                          size: 32),
                    ],
                  )
                ],
              )
            : ListView.builder(
                itemCount: restaurantProvider.restaurantSearched.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () async {
                      await productProvider.loadProductsbyRestaurant(
                          restaurantProvider.restaurantSearched[index].id);

                      changeScreen(
                          context,
                          RestaurantScreen(
                              restaurantModel: restaurantProvider
                                  .restaurantSearched[index]));
                    },
                    child: RestaurantWidget(
                      restaurant: restaurantProvider.restaurantSearched[index],
                    ),
                  );
                }));
  }
}
