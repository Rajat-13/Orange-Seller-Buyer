
import 'dart:convert';

import 'package:orange/data/network/baseApiService.dart';
import 'package:orange/data/network/networkApiService.dart';
import 'package:orange/model/productModel.dart';
import 'package:orange/res/urls.dart';

class SellerRepository {
  BaseApiService baseApiService = NetworkServiceApi();

  Future<dynamic> addproduct(Map data,String token) async {
    try {
      productModel product = productModel();
      product.productName = data['product_name'];
      product.productPrice  = data['product_price'];
      product.productMrp  = data['product_mrp'];
      product.productDiscount  = data['product_discount'];
      product.productUnitQty  = data['product_unit_qty'];
      product.sellerId  = data['seller_id'];
      product.productId  = data['product_id'];
      dynamic response =
      await baseApiService.createCollection(AppUrl.PRODUCTS,token, product.toJson());
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> updateproduct(Map data,String token) async {
    try {
      var update_rec = {
        "product_name": data['product_name'],
        "product_price": data['product_price'],
        "product_mrp": data['product_mrp'],
        "product_discount":  data['product_discount'],
      };

      dynamic response = await baseApiService.UpdateCollection(AppUrl.PRODUCTS,token, update_rec);
      return response;
    } catch (e) {
      throw e;
    }
  }


  Future<dynamic> deleteSellersproduct(String token) async {
    try {
      dynamic response =
      await baseApiService.DeleteCollection(AppUrl.PRODUCTS,token);
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<productModelList> getSellersproduct(String token) async {
    try {
      dynamic response =
      await baseApiService.ReadCollectionwithConditions(AppUrl.PRODUCTS,"seller_id",token);
      Map<String,dynamic> resdata = {
        "data": response,
      };
      return productModelList.fromSnapshot(resdata);
    } catch (e) {
      throw e;
    }
  }


}