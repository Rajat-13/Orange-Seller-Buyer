import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:orange/model/userModel.dart';
import 'package:orange/viewmodels/userViewModel.dart';
import '../utils/routes/route.dart';
import '../utils/routes/routeNames.dart';


class SplashServices {

  Future<String?> getToken() => UserViewModel().getUser();

  void authenticate(BuildContext context) async {
    getToken().then((value) async {
      if(value! == 'null' || value == '') {
         await Future.delayed(Duration(seconds: 2));
         Navigator.pop(context);
         Navigator.pushNamed(context, RouteNames.login);
      } else {
         await Future.delayed(Duration(seconds: 2));
         Navigator.pop(context);
         Navigator.pushNamed(context, RouteNames.home);
      }
    }).onError((error, stackTrace) {
      if(kDebugMode) {
        print(error.toString());
      }
    });
  }
}