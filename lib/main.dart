import 'package:flutter/material.dart';
import 'package:flutter_foodapp/scr/providers/app.dart';
import 'package:flutter_foodapp/scr/providers/category.dart';
import 'package:flutter_foodapp/scr/providers/product.dart';
import 'package:flutter_foodapp/scr/providers/restaurant.dart';
import 'package:flutter_foodapp/scr/providers/user.dart';
import 'package:flutter_foodapp/scr/screens/home.dart';

import 'package:flutter_foodapp/scr/screens/login.dart';
import 'package:flutter_foodapp/scr/widgets/loading.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: UserProvider.initalize()),
        ChangeNotifierProvider.value(value: CategoryProvider.initalize()),
        ChangeNotifierProvider.value(value: RestaurantProvider.initalize()),
        ChangeNotifierProvider.value(value: ProductProvider.initalize()),
        ChangeNotifierProvider.value(value: AppProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Food App',
        theme: ThemeData(
          primarySwatch: Colors.red,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: ScreenController(),
      )));
}

class ScreenController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<UserProvider>(context);
    switch (auth.status) {
      case Status.Uninitialized:
        return Loading();
      case Status.Unauthenticated:
      case Status.Authenticating:
        return LoginScreen();
      case Status.Authenticated:
        return Home();
      default:
        return LoginScreen();
    }
  }
}
