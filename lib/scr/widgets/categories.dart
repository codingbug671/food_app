import 'package:flutter/material.dart';
import 'package:flutter_foodapp/scr/helpers/common.dart';
import 'package:flutter_foodapp/scr/models/category.dart';
import 'package:flutter_foodapp/scr/widgets/custom_text.dart';

List<Category> categoriesList = [
  Category(name: "Salad", image: "salad.png"),
  Category(name: "Steak", image: "steak.png"),
  Category(name: "Fast food", image: "sandwich.png"),
  Category(name: "Desserts", image: "ice-cream.png"),
  Category(name: "Seafood", image: "fish.png"),
  Category(name: "Beer", image: "pint.png"),
];

class Categories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categoriesList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(color: white, boxShadow: [
                      BoxShadow(
                        color: Colors.red[50],
                        offset: Offset(4, 6),
                        blurRadius: 20,
                      )
                    ]),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Image.asset(
                          "images/${categoriesList[index].image}",
                          width: 50,
                          height: 60),
                    ),
                  ),
                  SizedBox(height: 5),
                  CustomText(
                      text: "${categoriesList[index].name}",
                      size: 14,
                      color: black)
                ],
              ),
            );
          }),
    );
  }
}
