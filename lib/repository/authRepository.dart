

import 'package:orange/data/network/baseApiService.dart';
import 'package:orange/data/network/networkApiService.dart';
import 'package:orange/model/userModel.dart';
import 'package:orange/res/urls.dart';
import 'package:orange/views/screens/SignupScreen.dart';
import 'package:orange/model/userModel.dart';
class AuthRepository {
  BaseApiService baseApiService = NetworkServiceApi();

  Future<dynamic> SignUp(Map data,String token) async {
    try {
      userModel user = userModel();
      user.email = data["email"];
      user.password = data["password"];
      user.name = data["name"];
      user.type = data["type"];
      user.mobile = data["mobile"];
      user.id = data["id"];
      dynamic response = await baseApiService.createCollection(AppUrl.USERS,token, user.toJson());
      //created black repo for image and description upload
      createRowImage(token);
      createRowDesc(token);
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<userModel> getUserDetails(String token) async {
    try {
      dynamic response =
      await baseApiService.ReadCollection(AppUrl.USERS,token);
      return userModel.fromJson(response);
    } catch (e) {
      throw e;
    }
  }

  Future<void> createRowImage(String token) async {
    var data = {
      "image_url":"",
      "id": token
    };
    await baseApiService.createCollection(AppUrl.IMAGES,token, data);
  }

  Future<void> createRowDesc(String token) async {
    var data = {
      "desc":"",
      "id": token
    };
    await baseApiService.createCollection(AppUrl.DESC,token, data);  }
}