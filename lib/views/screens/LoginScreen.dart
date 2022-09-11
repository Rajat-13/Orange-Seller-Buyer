import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:orange/utils/CustomBorder.dart';
import 'package:orange/utils/CustomColors.dart';
import 'package:orange/utils/CustomTextStyle.dart';
import 'package:orange/utils/CustomUtils.dart';
import 'package:orange/utils/routes/routeNames.dart';
import 'package:orange/viewmodels/authViewModel.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // form key

  final _formKey = GlobalKey<FormState>();

  // editing controller
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  final TextEditingController cpasswordController = new TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFfaf9f8),
      resizeToAvoidBottomInset: false,
      body: Builder(builder: (context) {
        return Container(
          width: double.infinity,
          child: Column(
            children: <Widget>[
              Expanded(
                child: Image(
                    image : AssetImage("assets/img/orange.png"),
                    height: 140,
                    alignment: Alignment.center,
                    width: 200),
                flex: 40,
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.all(16),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          key: Key("email_field"),
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.fromLTRB(16, 16, 16, 12),
                              border: CustomBorder.enabledBorder,
                              labelText: "Enter Email",
                              errorStyle: TextStyle(fontSize: 14),
                              focusedBorder: CustomBorder.focusBorder,
                              errorBorder: CustomBorder.errorBorder,
                              enabledBorder: CustomBorder.enabledBorder,
                              labelStyle: CustomTextStyle.textFormFieldMedium
                                  .copyWith(fontSize: MediaQuery.of(context).textScaleFactor * 16, color: Colors.black)),
                          autofocus: false,
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return ("Please Enter Your Email");
                            }
                            // reg expression for email validation
                            if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                .hasMatch(value)) {
                              return ("Please Enter a valid email");
                            }
                            return null;
                          },
                          onSaved: (value) {
                            emailController.text = value!;
                          },
                          textInputAction: TextInputAction.next,

                        ),
                        Utils.getSizedBox(height: 20),
                        TextFormField(
                          key: Key("password_field"),
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.fromLTRB(16, 16, 16, 12),
                              border: CustomBorder.enabledBorder,
                              labelText: "Password",
                              errorStyle: TextStyle(fontSize: 14),
                              focusedBorder: CustomBorder.focusBorder,
                              errorBorder: CustomBorder.errorBorder,
                              enabledBorder: CustomBorder.enabledBorder,
                              labelStyle: CustomTextStyle.textFormFieldMedium
                                  .copyWith(fontSize: MediaQuery.of(context).textScaleFactor * 16, color: Colors.black)),
                          obscureText: true,
                          autofocus: false,
                          controller: passwordController,
                          validator: (value) {
                            RegExp regex = new RegExp(r'^.{6,}$');
                            if (value!.isEmpty) {
                              return ("Password is required for login");
                            }
                            if (!regex.hasMatch(value)) {
                              return ("Enter Valid Password(Min. 6 Character)");
                            }
                          },
                          onSaved: (value) {
                            passwordController.text = value!;
                          },
                        ),
                        Utils.getSizedBox(height: 20),
                        TextFormField(
                          key: Key("cpassword_field"),
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.fromLTRB(16, 16, 16, 12),
                              border: CustomBorder.enabledBorder,
                              labelText: "Confirm Password",
                              focusedBorder: CustomBorder.focusBorder,
                              errorBorder: CustomBorder.errorBorder,
                              enabledBorder: CustomBorder.enabledBorder,
                              errorStyle: TextStyle(fontSize: 14),
                              labelStyle: CustomTextStyle.textFormFieldMedium
                                  .copyWith(fontSize: MediaQuery.of(context).textScaleFactor * 16, color: Colors.black)),
                          obscureText: true,
                          autofocus: false,
                          controller: cpasswordController,
                          validator: (value) {
                            RegExp regex = new RegExp(r'^.{6,}$');
                            if (value!.isEmpty) {
                              return ("Confirm Password is required for login");
                            }
                            if (!regex.hasMatch(value)) {
                              return ("Enter Valid Password(Min. 6 Character)");
                            }
                            if(cpasswordController.text != passwordController.text){
                              return ("Password Mismatch !");
                            }
                          },
                          onSaved: (value) {
                            cpasswordController.text = value!;
                          },
                        ),
                        Utils.getSizedBox(height: 20),

                        Container(
                          width: double.infinity,
                          child: ElevatedButton(
                            key: Key("login_button"),
                            onPressed: () {
                              signIn(emailController.text, passwordController.text);



                              },
                            child: Text(
                              "LOGIN",
                              style: CustomTextStyle.textFormFieldRegular.copyWith(color: Colors.white, fontSize: 14),
                            ),

                          ),
                        ),
                        Utils.getSizedBox(height: 10),
                        Utils.getSizedBox(height: 10),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                color: Colors.grey.shade200,
                                margin: EdgeInsets.only(right: 16),
                                height: 1,
                              ),
                              flex: 40,
                            ),
                            Text(
                              "Or",
                              style: CustomTextStyle.textFormFieldMedium.copyWith(fontSize: 14),
                            ),
                            Expanded(
                              child: Container(
                                color: Colors.grey.shade200,
                                margin: EdgeInsets.only(left: 16),
                                height: 1,
                              ),
                              flex: 40,
                            )
                          ],
                        ),
                        Utils.getSizedBox(height: 14),
                        Utils.getSizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Don't have an account?",
                              style: CustomTextStyle.textFormFieldMedium.copyWith(fontSize: 14),
                            ),
                            Utils.getSizedBox(width: 4),
                            GestureDetector(
                              child: Text(
                                "Sign Up",
                                style: CustomTextStyle.textFormFieldBold.copyWith(fontSize: 14, color: Colors.deepOrangeAccent),
                              ),
                              onTap: () {
                                Navigator.of(context).pushNamed(RouteNames.signup);
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                flex: 60,
              )
            ],
          ),
        );
      }),
    );
  }

  Future<void> signIn(String email, String pass) async {
    if (_formKey.currentState!.validate()) {
      Map data = {
        'email': email,
        'password': pass,
      };
      Provider.of<AuthViewModel>(context,listen:false).postSignIn(context, data);
    }
  }
}
