import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:orange/model/userModel.dart';


class UserViewModel with ChangeNotifier {

  Future<bool> saveUser(String uid) async {
    var localStorage = Hive.box('localStorage');

    localStorage.put('token', uid);
    notifyListeners();
    return true;
  }

  Future<bool> saveUserName(String name) async {
    var localStorage = Hive.box('localStorage');

    localStorage.put('name', name);
    notifyListeners();
    return true;
  }
  Future<bool> saveUserType(String type) async {
    var localStorage = Hive.box('localStorage');
    localStorage.put('type', type);
    notifyListeners();
    return true;
  }

  Future<String> getUser() async {
    var localStorage = Hive.box('localStorage');
    final String token = localStorage.get('token') == null?"":localStorage.get('token');
    print('Saved Token: $token');
    notifyListeners();
    return token;
  }
  Future<String> getUserName() async {
    var localStorage = Hive.box('localStorage');
    final String token = localStorage.get('name') == null?"":localStorage.get('name');
    print('Saved Name: $token');
    notifyListeners();
    return token;
  }

  Future<String> getUserType() async {
    var localStorage = Hive.box('localStorage');
    final String token = localStorage.get('type') == null?"":localStorage.get('type');
    print('Saved Type: $token');
    notifyListeners();
    return token;
  }

  void removeToken() async {
    var localStorage = Hive.box('localStorage');
    localStorage.clear();
  }
}
