import 'package:another_flushbar/flushbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:orange/data/response/apiResponse.dart';
import 'package:orange/data/response/status.dart';
import 'package:orange/model/productModel.dart';
import 'package:orange/model/sellerModel.dart';
import 'package:orange/repository/buyerRepository.dart';
import 'package:orange/repository/sellerRepository.dart';
import 'package:orange/utils/routes/routeNames.dart';
import 'package:provider/provider.dart';

class BuyercrudViewModel extends ChangeNotifier {

  ApiResponse<productModelList> productlists = ApiResponse.loading();
  ApiResponse<sellerModelList> sellerlists = ApiResponse.loading();


  Future<void> getBuyerSellers(BuildContext context) async {
    final BuyerRepo = BuyerRepository();
    final _auth = FirebaseAuth.instance;
    try {
      BuyerRepo.getSellersData(_auth.currentUser!.uid.toString()).then((value) {
        setSellerList(ApiResponse.completed(value));
        print(value.toString());
      });
    }
    catch (e){
      setSellerList(ApiResponse.error(e.toString()));
    }
  }


  Future<void> getSellerOwnProduct(BuildContext context,String seller_id) async {
    final sellerRepo = SellerRepository();
    try {
      sellerRepo.getSellersproduct(seller_id).then((value) {
        setProductList(ApiResponse.completed(value));
        print(value.toString());
      });
    }
    catch (e){
      setProductList(ApiResponse.error(e.toString()));
    }
  }


  setSellerList(ApiResponse<sellerModelList> response) {
    sellerlists = response;
    notifyListeners();
  }

  setProductList(ApiResponse<productModelList> response) {
    productlists = response;
    notifyListeners();
  }


}





