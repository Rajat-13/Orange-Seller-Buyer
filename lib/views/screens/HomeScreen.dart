import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:orange/viewmodels/userViewModel.dart';
import 'package:orange/views/screens/SellerHomePage.dart';
import 'package:provider/provider.dart';
import 'ProfilePage.dart';
import 'HomePage.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int selectedPosition = 0;
  String _myUser = "";
  List<Widget> listBottomWidget =  <Widget>[];

  UserViewModel umodel = UserViewModel();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    umodel.getUserType();
    checkType();

  }

  @override
  Widget build(BuildContext context) {



    return  Scaffold(
      backgroundColor: Colors.grey.shade100,
      bottomNavigationBar:
      _myUser=="buyer"?
      BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.person), label: "Account"),
        ],
        currentIndex: selectedPosition,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.grey.shade100,
        selectedItemColor: Colors.deepOrangeAccent,
        unselectedItemColor: Colors.black,
        onTap: (position) {
          setState(() {
            selectedPosition = position;
          });
        },
      ):
        BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.person), label: "Account"),
          ],
          currentIndex: selectedPosition,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.grey.shade100,
          selectedItemColor: Colors.deepOrangeAccent,
          unselectedItemColor: Colors.black,
          onTap: (position) {
            setState(() {
              selectedPosition = position;
            });
          },
        ),
      body: Builder(builder: (context) {
        return listBottomWidget[selectedPosition];
      }),
    );


  }

  void addHomePage() {
    if(_myUser=="buyer")
      {
        listBottomWidget.add(HomePage());
        listBottomWidget.add(ProfilePage());

      }
    else{
      listBottomWidget.add(SellerHomePage());
      listBottomWidget.add(ProfilePage());
    }
  }

  void checkType() {
    Provider.of<UserViewModel>(context,listen: false).getUserType().then((value) {
      setState(() {
        _myUser = value;
        addHomePage();

      });
    });

  }


}
