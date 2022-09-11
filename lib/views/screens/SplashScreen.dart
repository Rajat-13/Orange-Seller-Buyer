

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:orange/services/splashServices.dart';
import 'package:orange/utils/routes/routeNames.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashServices splashServices = SplashServices();

  @override
  void initState() {
    super.initState();
    splashServices.authenticate(context);
  }

  @override
  Widget build(BuildContext context) {



    return Scaffold(
      backgroundColor: Color(0xFFfaf9f8),
      resizeToAvoidBottomInset: false,
      body: Container(
          child: Center(
            child: Image(
              image: AssetImage("assets/img/orange.png"),
              height: 200,
              width: 200,
            ),
          )),
    );
  }

  void navigate() {
    Navigator.of(context).pushNamed(RouteNames.login);
  }
}