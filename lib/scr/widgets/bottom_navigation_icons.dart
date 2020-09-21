import 'package:flutter/material.dart';
import 'package:flutter_foodapp/scr/widgets/custom_text.dart';

class BottomNavIcon extends StatelessWidget {
  final String image;
  final String name;

  BottomNavIcon(this.image, this.name);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Image.asset("images/$image", width: 26, height: 20),
          SizedBox(height: 2),
          CustomText(
            text: name,
            size: 12,
          )
        ],
      ),
    );
  }
}
