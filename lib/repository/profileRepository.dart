
import 'dart:convert';

import 'package:orange/data/network/baseApiService.dart';
import 'package:orange/data/network/networkApiService.dart';
import 'package:orange/model/productModel.dart';
import 'package:orange/model/profileModel.dart';
import 'package:orange/res/urls.dart';

class ProfileRepository {
  BaseApiService baseApiService = NetworkServiceApi();

  Future<dynamic> addImage(var data,String token) async {
    try {

      dynamic response =
      await baseApiService.createCollection(AppUrl.IMAGES,token, data);
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> addDescription(var data,String token) async {
    try {

      dynamic response =
      await baseApiService.createCollection(AppUrl.DESC,token, data);
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<profileModel> getProfileDetails(String token) async {
    try {
      dynamic response_img =
      await baseApiService.ReadCollectionwithConditions(AppUrl.IMAGES,"id",token);
      dynamic response_desc =
      await baseApiService.ReadCollectionwithConditions(AppUrl.DESC,"id",token);

      Map<String,dynamic> resdata = {
        "desc": response_desc[0]["desc"],
        "img": response_img[0]["image_url"]
      };
      return profileModel.fromJson(resdata);
    } catch (e) {
      throw e;
    }
  }


}