
import 'dart:convert';

import 'package:orange/data/network/baseApiService.dart';
import 'package:orange/data/network/networkApiService.dart';
import 'package:orange/model/productModel.dart';
import 'package:orange/model/sellerModel.dart';
import 'package:orange/res/urls.dart';

class BuyerRepository {
  BaseApiService baseApiService = NetworkServiceApi();


  Future<sellerModelList> getSellersData(String token) async {
    try {
      dynamic response = await baseApiService.ReadCollectionwithConditions(AppUrl.USERS, "type", "seller");

      print(response);

      for(int v = 0; v < response.length; v++)
        {
          dynamic img = await baseApiService.ReadCollectionwithConditions(AppUrl.IMAGES,"id",response[v]["id"]);
          dynamic desc = await baseApiService.ReadCollectionwithConditions(AppUrl.DESC,"id",response[v]["id"]);
          response[v].addAll({"image": img[0]["image_url"].toString(),"desc":desc[0]["desc"].toString()});
        }

      // response.forEach((k,v) async {
      //
      // });


      Map<String,dynamic> resdata = {
        "data": response,
      };

      return sellerModelList.fromSnapshot(resdata);
    } catch (e) {
      throw e;
    }
  }


}