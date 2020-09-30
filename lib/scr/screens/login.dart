import 'package:flutter/material.dart';
import 'package:flutter_foodapp/scr/helpers/common.dart';
import 'package:flutter_foodapp/scr/helpers/screen_navigation.dart';
import 'package:flutter_foodapp/scr/screens/home.dart';
import 'package:flutter_foodapp/scr/screens/register.dart';
import 'package:flutter_foodapp/scr/widgets/custom_text.dart';
import 'package:flutter_foodapp/scr/widgets/loading.dart';
import 'package:provider/provider.dart';
import 'package:flutter_foodapp/scr/providers/user.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _key = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<UserProvider>(context);
    return Scaffold(
        key: _key,
        backgroundColor: white,
        body: authProvider.status == Status.Authenticating
            ? Loading()
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "images/images.jpg",
                          height: 240,
                          width: 240,
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey[300]),
                            borderRadius: BorderRadius.circular(15)),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: TextFormField(
                            controller: authProvider.email,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Email",
                                icon: Icon(Icons.email)),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey[300]),
                              borderRadius: BorderRadius.circular(15)),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: TextFormField(
                              controller: authProvider.password,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Password",
                                icon: Icon(Icons.lock),
                              ),
                            ),
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: GestureDetector(
                        onTap: () async {
                          if (!await authProvider.signIn()) {
                            _key.currentState.showSnackBar(SnackBar(
                              content: Text("Login Failed"),
                            ));

                            return;
                          }
                          authProvider.CleanControllers();
                          changeScreenReplacement(context, Home());
                        },
                        child: Container(
                            decoration: BoxDecoration(
                                color: red,
                                border: Border.all(color: Colors.grey[300]),
                                borderRadius: BorderRadius.circular(15)),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 10.0, bottom: 10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CustomText(
                                      text: "Login", color: white, size: 22)
                                ],
                              ),
                            )),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        changeScreen(context, Register());
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomText(text: "Register Here", size: 20),
                        ],
                      ),
                    )
                  ],
                ),
              ));
  }
}
