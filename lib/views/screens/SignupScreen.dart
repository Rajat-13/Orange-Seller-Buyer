import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:orange/utils/CustomBorder.dart';
import 'package:orange/utils/CustomTextStyle.dart';
import 'package:orange/utils/CustomUtils.dart';
import 'package:orange/viewmodels/authViewModel.dart';
import 'package:provider/provider.dart';

enum UserType { seller, buyer }

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  UserType? _character ;
  String _choice = "";
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _mobileController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _cpasswordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFfaf9f8),
      resizeToAvoidBottomInset: false,
      body: Container(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Expanded(
              child: Image(
                  image: AssetImage("assets/img/orange.png"),
                  height: 140,
                  alignment: Alignment.center,
                  width: 200),
              flex: 15,
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.all(16),
                child: Column(
                  children: <Widget>[
                    TextFormField(

                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(16, 16, 16, 12),
                            border: CustomBorder.enabledBorder,
                            labelText: "Name",
                            focusedBorder: CustomBorder.focusBorder,
                            errorBorder: CustomBorder.errorBorder,
                            enabledBorder: CustomBorder.enabledBorder,
                            labelStyle: CustomTextStyle.textFormFieldRegular
                                .copyWith(fontSize: MediaQuery.of(context).textScaleFactor * 16, color: Colors.black)),
                        controller: _nameController,
                        keyboardType: TextInputType.text),
                    Utils.getSizedBox(height: 20),
                    TextFormField(
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(16, 16, 16, 12),
                            border: CustomBorder.enabledBorder,
                            labelText: "Mobile Number",
                            focusedBorder: CustomBorder.focusBorder,
                            errorBorder: CustomBorder.errorBorder,
                            enabledBorder: CustomBorder.enabledBorder,
                            labelStyle: CustomTextStyle.textFormFieldRegular
                                .copyWith(fontSize: MediaQuery.of(context).textScaleFactor * 16, color: Colors.black)),
                        controller: _mobileController,
                        keyboardType: TextInputType.number),
                    Utils.getSizedBox(height: 20),
                    TextFormField(
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(16, 16, 16, 12),
                            border: CustomBorder.enabledBorder,
                            labelText: "Email",
                            focusedBorder: CustomBorder.focusBorder,
                            errorBorder: CustomBorder.errorBorder,
                            enabledBorder: CustomBorder.enabledBorder,
                            labelStyle: CustomTextStyle.textFormFieldRegular
                                .copyWith(fontSize: MediaQuery.of(context).textScaleFactor * 16, color: Colors.black)),
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress),
                    Utils.getSizedBox(height: 20),
                    TextFormField(
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(16, 16, 16, 12),
                          border: CustomBorder.enabledBorder,
                          labelText: "Password",
                          focusedBorder: CustomBorder.focusBorder,
                          errorBorder: CustomBorder.errorBorder,
                          enabledBorder: CustomBorder.enabledBorder,
                          labelStyle: CustomTextStyle.textFormFieldRegular
                              .copyWith(fontSize: MediaQuery.of(context).textScaleFactor * 16, color: Colors.black)),
                      controller: _passwordController,
                      obscureText: true,
                    ),
                    Utils.getSizedBox(height: 20),
                    TextFormField(
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(16, 16, 16, 12),
                          border: CustomBorder.enabledBorder,
                          labelText: "Confirm Password",
                          focusedBorder: CustomBorder.focusBorder,
                          errorBorder: CustomBorder.errorBorder,
                          enabledBorder: CustomBorder.enabledBorder,
                          labelStyle: CustomTextStyle.textFormFieldRegular
                              .copyWith(fontSize: MediaQuery.of(context).textScaleFactor * 16, color: Colors.black)),
                      controller: _cpasswordController,
                      obscureText: true,
                    ),
                    Utils.getSizedBox(height: 10),
                    ListTile(
                      title: Text('Register as Orange aficionado',style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.black,fontSize: MediaQuery.of(context).textScaleFactor * 16,),),
                      leading: Radio<UserType>(
                        activeColor: Colors.orange,
                        value: UserType.buyer,
                        groupValue: _character,
                        onChanged: (UserType? value) {
                          setState(() {
                            _character = value;
                            _choice = "buyer";
                          });
                        },
                      ),
                    ),
                    ListTile(
                      title: Text('Register as Orange Seller',style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.black,fontSize: MediaQuery.of(context).textScaleFactor * 16,),),
                      leading: Radio<UserType>(
                        activeColor: Colors.orange,
                        value: UserType.seller,
                        groupValue: _character,
                        onChanged: (UserType? value) {
                          setState(() {
                            _character = value;
                            _choice = "seller";
                          });
                        },
                      ),
                    ),
                    Utils.getSizedBox(height: 10),
                    Container(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          
                          if(validateAllFields(_nameController.text,_emailController.text,_passwordController.text,_cpasswordController.text,_choice)) {
                            Map data = {
                              "name": _nameController.text.toString(),
                              "password": _passwordController.text.toString(),
                              "email": _emailController.text.toString(),
                              "mobile": _mobileController.text.toString(),
                              "type": _choice.toString(),

                            };
                            Provider.of<AuthViewModel>(context, listen: false).postSignUp(context, data);
                          }
                            },
                        child: Text(
                          "SIGNUP",
                          style: CustomTextStyle.textFormFieldRegular.copyWith(color: Colors.white, fontSize: 14),
                        ),


                      ),
                    ),
                  ],
                ),
              ),
              flex: 50,
            )
          ],
        ),
      ),
    );
  }

  bool validateAllFields(String _nameController,String _emailController,String _passwordController,String _cpasswordController,String _choice) {
    if(_nameController.trim() == "" || _emailController.trim() == "" || _passwordController.trim() == "" || _cpasswordController.trim() =="" || _choice == "" ) {
      Flushbar(
        message: "Please provide all details",
        icon: Icon(
          Icons.warning_amber_rounded,
          size: 28.0,
          color: Colors.red,
        ),
        duration: Duration(seconds: 3),
        leftBarIndicatorColor: Colors.red,
      )
        ..show(context);
    }
    else if(_passwordController.trim()!=_cpasswordController.trim()){
      Flushbar(
        message: "Password not matching..",
        icon: Icon(
          Icons.warning_amber_rounded,
          size: 28.0,
          color: Colors.red,
        ),
        duration: Duration(seconds: 3),
        leftBarIndicatorColor: Colors.red,
      )
        ..show(context);

    }
    else{
      return true;
    }
    return false;
  }

}
