import 'package:flutter/cupertino.dart';

abstract class BaseApiService {

  Future<dynamic> createCollection(String url, String token,Map request_data);

  Future<dynamic> ReadCollection(String url, String token);

  Future<dynamic> UpdateCollection(String url, String token,dynamic request_data);

  Future<dynamic> DeleteCollection(String url, String token);

  Future<dynamic> ReadCollectionwithConditions(String url,  String field, String data);

}
