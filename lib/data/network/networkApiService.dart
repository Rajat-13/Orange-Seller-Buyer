import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import '../appException.dart';
import './baseApiService.dart';

class NetworkServiceApi extends BaseApiService {
  @override
  Future DeleteCollection(String url, String token) async{
    try {
      final docUser = FirebaseFirestore.instance.collection(url).doc(token);
      await docUser.delete().timeout(const Duration(seconds: 10)).catchError((err)=> print(err.message));
    }
    on SocketException {
      throw FetchDataException('No Internet Connection');
    }

  }

  @override
  Future ReadCollection(String url, String token) async {
    // TODO: implement ReadCollection
    try {
   final docUser = FirebaseFirestore.instance.collection(url).doc(token);
   final snapshot = await docUser.get();
   if(snapshot.exists){
     return snapshot.data();
   }
    }
    on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    on FirebaseException catch (e){
      throw FetchDataException(e.message.toString());
    }


  }

  @override
  Future UpdateCollection(String url, String token,dynamic request_data) async {
    // TODO: implement UpdateCollection
    try {
      final docUser = FirebaseFirestore.instance.collection(url).doc(token);
      await docUser.update(request_data).timeout(const Duration(seconds: 10)).catchError((err)=> print(err.message));
    }
    on SocketException {
      throw FetchDataException('No Internet Connection');
    }

  }

  @override
  Future createCollection(String url, String token,dynamic request_data) async {
    // TODO: implement createCollection
    try {
      final docUser = FirebaseFirestore.instance.collection(url).doc(token);
      await docUser.set(request_data).timeout(Duration(seconds: 10));
    }
   on SocketException {
  //throw FetchDataException('No Internet Connection');
      return 'No Internet Connection';
    }
    on FirebaseException catch (e){
      print('Failed with error code: ${e.code}');
      print(e.message);
      return e.message.toString();
    }
  }

  @override
  Future ReadCollectionwithConditions(String url, String field, String data) async {
    // TODO: implement ReadCollectionwithConditions
    try {
      final docUser = FirebaseFirestore.instance.collection(url).where(field,isEqualTo:data);
      final snapshot = await docUser.get();

        // return snapshot.docs.map((doc) => doc.data).toList();
      return snapshot.docs.map((DocumentSnapshot document) {
        Map a = document.data() as Map<String,dynamic>;
        return a;
      }).toList();

    }
    on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    on FirebaseException catch (e){
      throw FetchDataException(e.message.toString());
    }

  }





}
