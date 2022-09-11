import 'package:flutter/material.dart';
import 'package:orange/utils/routes/routeNames.dart';
import 'package:orange/views/screens/CreateProductPage.dart';
import 'package:orange/views/screens/EditProfilePage.dart';
import 'package:orange/views/screens/HomeScreen.dart';
import 'package:orange/views/screens/LoginScreen.dart';
import 'package:orange/views/screens/ProductDetailsPage.dart';
import 'package:orange/views/screens/SellerProductDeleteListPage.dart';
import 'package:orange/views/screens/SellerProductListPage.dart';
import 'package:orange/views/screens/SellerProductUpdateListPage.dart';
import 'package:orange/views/screens/SignupScreen.dart';
import 'package:orange/views/screens/SplashScreen.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {

    switch (settings.name) {
      case RouteNames.splash:
        return MaterialPageRoute(
            builder: (BuildContext context) => SplashScreen());
      case RouteNames.login:
        return MaterialPageRoute(
            builder: (BuildContext context) => Login());
      case RouteNames.signup:
        return MaterialPageRoute(
            builder: (BuildContext context) => SignUp());
      case RouteNames.home:
        return MaterialPageRoute(
            builder: (BuildContext context) => Home());
      case RouteNames.edit_profile:
        return MaterialPageRoute(
            builder: (BuildContext context) => EditProfilePage());
      case RouteNames.create_product:
        return MaterialPageRoute(
            builder: (BuildContext context) => CreateProductPage());
      case RouteNames.seller_productlist:
        return MaterialPageRoute(
            builder: (BuildContext context) => SellerProductListPage());
      case RouteNames.seller_productlist_update:
        return MaterialPageRoute(
            builder: (BuildContext context) => SellerProductListUpdatePage());
      case RouteNames.seller_productlist_delete:
        return MaterialPageRoute(
            builder: (BuildContext context) => SellerProductListDeletePage());
      case RouteNames.sellers_products_from_buyer:
        return MaterialPageRoute(
            builder: (BuildContext context) => ProductDetailsPage(settings.arguments as Map));
      default:
        return MaterialPageRoute(builder: (BuildContext context) {
          return const Scaffold(
            body: Center(
              child: Text('No Route'),
            ),
          );
        });
    }
  }
}

