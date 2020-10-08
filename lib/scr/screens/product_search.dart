import 'package:flutter/material.dart';
import 'package:flutter_foodapp/scr/helpers/common.dart';
import 'package:flutter_foodapp/scr/helpers/screen_navigation.dart';
import 'package:flutter_foodapp/scr/providers/product.dart';
import 'package:flutter_foodapp/scr/screens/details.dart';
import 'package:flutter_foodapp/scr/widgets/custom_text.dart';
import 'package:flutter_foodapp/scr/widgets/product.dart';
import 'package:provider/provider.dart';

class ProductSearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    return Scaffold(
        appBar: AppBar(
          title: CustomText(text: "Products", size: 20),
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
        body: productProvider.productSearched.length < 1
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
                          text: "No products found",
                          color: grey,
                          weight: FontWeight.normal,
                          size: 32),
                    ],
                  )
                ],
              )
            : ListView.builder(
                itemCount: productProvider.productSearched.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      changeScreen(
                          context,
                          Details(
                              product: productProvider.productSearched[index]));
                    },
                    child: ProductWidget(
                      product: productProvider.productSearched[index],
                    ),
                  );
                }));
  }
}
