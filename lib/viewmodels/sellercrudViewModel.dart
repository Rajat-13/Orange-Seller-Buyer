import 'package:another_flushbar/flushbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:orange/data/response/apiResponse.dart';
import 'package:orange/data/response/status.dart';
import 'package:orange/model/productModel.dart';
import 'package:orange/repository/sellerRepository.dart';
import 'package:orange/utils/routes/routeNames.dart';
import 'package:provider/provider.dart';

class SellercrudViewModel extends ChangeNotifier {




  ApiResponse<productModelList> productlists = ApiResponse.loading();
  ApiResponse<Object> updateproduct = ApiResponse.loading();

  Future<void> postProduct(BuildContext context, Map data) async {
    final sellerRepo = SellerRepository();

    try {
      final _auth = FirebaseAuth.instance;

      String pid = FirebaseFirestore.instance.collection('products').doc().id;
      data.addAll({"seller_id": _auth.currentUser!.uid.toString(),
                    "product_id":pid.toString()});

      sellerRepo.addproduct(data, pid).then((value) {
        Flushbar(
          message: "Product created successfully!",
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
      )
        ..show(context);
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
      )
        ..show(context);
    }
  }

  Future<void> getSellerOwnProduct(BuildContext context) async {
    final sellerRepo = SellerRepository();
    final _auth = FirebaseAuth.instance;
    try {
      sellerRepo.getSellersproduct(_auth.currentUser!.uid.toString()).then((value) {
        setProductList(ApiResponse.completed(value));
        print(value.toString());
      });
    }
    catch (e){
      setProductList(ApiResponse.error(e.toString()));
    }
  }

  Future<void> updateProduct(BuildContext context, Map data, String pid) async {
    final sellerRepo = SellerRepository();
    try {
      sellerRepo.updateproduct(data, pid).whenComplete(() {
        Future.delayed(Duration(seconds: 100),(){Provider.of<SellercrudViewModel>(context,listen: false).getSellerOwnProduct(context);});
        Flushbar(
          message: "Product updated successfully!",
          icon: Icon(
            Icons.info_outline,
            size: 28.0,
            color: Colors.blue,
          ),
          duration: Duration(seconds: 3),
          leftBarIndicatorColor: Colors.blue,
        )
          ..show(context);
      },
      );
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
      )
        ..show(context);
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
      )
        ..show(context);
    }
  }

  Future<void> deleteProduct(BuildContext context, String pid) async {
    final sellerRepo = SellerRepository();

    try {

      sellerRepo.deleteSellersproduct(pid).then((value) {

        Flushbar(
          message: "Product deleted successfully!",
          icon: Icon(
            Icons.info_outline,
            size: 28.0,
            color: Colors.blue,
          ),
          duration: Duration(seconds: 3),
          leftBarIndicatorColor: Colors.blue,
        )
          ..show(context);
        notifyListeners();
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
      )
        ..show(context);
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
      )
        ..show(context);
    }
  }

  setProductList(ApiResponse<productModelList> response) {
    productlists = response;
    notifyListeners();
   }



  }





