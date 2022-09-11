import 'package:another_flushbar/flushbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:orange/data/response/apiResponse.dart';
import 'package:orange/model/userModel.dart';
import 'package:orange/repository/authRepository.dart';
import 'package:orange/utils/routes/routeNames.dart';
import 'package:orange/viewmodels/userViewModel.dart';
import 'package:provider/provider.dart';

class AuthViewModel extends ChangeNotifier {



  Future<void> postSignUp(BuildContext context, Map data) async {
    final authRepository = AuthRepository();
    final _auth = FirebaseAuth.instance;

    try {
      await _auth
          .createUserWithEmailAndPassword(
              email: data['email'], password: data['password'])
          .then((value) {
            data.addAll({"id": _auth.currentUser!.uid.toString()});
        authRepository.SignUp(data, _auth.currentUser!.uid).then((value) {
          Flushbar(
            message: "Registration Successful!",
            icon: Icon(
              Icons.info_outline,
              size: 28.0,
              color: Colors.blue,
            ),
            duration: Duration(seconds: 3),
            leftBarIndicatorColor: Colors.blue,
          )..show(context);
        });
      });
    } on FirebaseAuthException catch (e) {
      Flushbar(
        message: e.message.toString(),
        icon: Icon(
          Icons.warning_amber_rounded,
          size: 28.0,
          color: Colors.red,
        ),
        duration: Duration(seconds: 3),
        leftBarIndicatorColor: Colors.red,
      )..show(context);
    } on FirebaseException catch (e) {
      Flushbar(
        message: e.message.toString(),
        icon: Icon(
          Icons.warning_amber_rounded,
          size: 28.0,
          color: Colors.red,
        ),
        duration: Duration(seconds: 3),
        leftBarIndicatorColor: Colors.red,
      )..show(context);
    }
  }

  Future<void> getUserType(BuildContext context, String token) async {
    final authRepository = AuthRepository();
    authRepository.getUserDetails(token).then((value) {
      Provider.of<UserViewModel>(context, listen: false).saveUserType(value.type.toString()).then((values) {
        Provider.of<UserViewModel>(context, listen: false).saveUserName(value.name.toString());
        Navigator.of(context).pushNamed(RouteNames.home);
      });
    });
  }

  Future<void> postSignIn(BuildContext context, Map data) async {

    // firebase
    final _auth = FirebaseAuth.instance;

    // string for displaying the error Message
    String? errorMessage;

    try {
      await _auth
          .signInWithEmailAndPassword(email: data["email"], password: data["password"])
          .then((uid){
            print("UID ID:"+uid.user!.uid.toString());
        //storing token in local storage
        Provider.of<UserViewModel>(context, listen: false).saveUser(uid.user!.uid.toString());
        //get User type
         Provider.of<AuthViewModel>(context, listen: false).getUserType(context,uid.user!.uid.toString()).whenComplete(() {
             Flushbar(
               message: "Login Successful!",
               icon: Icon(
                 Icons.info_outline,
                 size: 28.0,
                 color: Colors.blue,
               ),
               duration: Duration(seconds: 3),
               leftBarIndicatorColor: Colors.blue,
             )
               ..show(context);



         });



      });
    } on FirebaseAuthException catch (error) {
      switch (error.code) {
        case "invalid-email":
          errorMessage = "Your email address appears to be malformed.";

          break;
        case "wrong-password":
          errorMessage = "Your password is wrong.";
          break;
        case "user-not-found":
          errorMessage = "User with this email doesn't exist.";
          break;
        case "user-disabled":
          errorMessage = "User with this email has been disabled.";
          break;
        case "too-many-requests":
          errorMessage = "Too many requests";
          break;
        case "operation-not-allowed":
          errorMessage = "Signing in with Email and Password is not enabled.";
          break;
        default:
          errorMessage = "An undefined Error happened.";
      }
      Flushbar(
        message: errorMessage,
        icon: Icon(
          Icons.warning_amber_rounded,
          size: 28.0,
          color: Colors.red,
        ),
        duration: Duration(seconds: 3),
        leftBarIndicatorColor: Colors.red,
      )..show(context);
    }
  }
}
