

import 'dart:io';

import 'package:another_flushbar/flushbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:orange/data/response/apiResponse.dart';
import 'package:orange/model/profileModel.dart';
import 'package:orange/repository/authRepository.dart';
import 'package:orange/repository/profileRepository.dart';
import 'package:permission_handler/permission_handler.dart';

class ProfileViewModel extends ChangeNotifier {
  final profileRepository = ProfileRepository();
  final authRepository = AuthRepository();
  ApiResponse<profileModel> profileModelResp = ApiResponse.loading();

  final _auth = FirebaseAuth.instance;

  Future<void> uploadProfileImage(BuildContext context) async {
    final _firebaseStorage = FirebaseStorage.instance;
    //Check Permissions
    await Permission.photos.request();
    var permissionStatus = await Permission.photos.status;
    if (permissionStatus.isGranted) {
      final ImagePicker _picker = ImagePicker();
      try {
        final XFile? pickedFile = await _picker.pickImage(
          source: ImageSource.gallery,
          imageQuality: 100,
        );
        if (pickedFile != null) {
          String filename = DateTime
              .now()
              .millisecondsSinceEpoch
              .toString();
          var snapshot = await _firebaseStorage.ref()
              .child('images/$filename')
              .putFile(File(pickedFile.path));
          var downloadUrl = await snapshot.ref.getDownloadURL();
          print(downloadUrl.toString());


          var data = {
            "image_url": downloadUrl.toString(),
            "id": _auth.currentUser!.uid.toString(),
          };

          profileRepository.addImage(data,_auth.currentUser!.uid.toString()).then((value)
              {
                Flushbar(
                  message: "Image Uploaded Successfully!",
                  icon: Icon(
                    Icons.info_outline,
                    size: 28.0,
                    color: Colors.blue,
                  ),
                  duration: Duration(seconds: 3),
                  leftBarIndicatorColor: Colors.blue,
                )..show(context);
              });
        }
      } catch (e) {}
    } else {
      print('Permission not granted. Try Again with permission access');
    }

  }

  Future<void> getProfileInfo(BuildContext context) async {
    try {
      profileRepository.getProfileDetails(_auth.currentUser!.uid.toString()).then((value) {
        setProfileDetails(ApiResponse.completed(value));
        print(value.toString());
      });
    }
    catch (e){
      setProfileDetails(ApiResponse.error(e.toString()));
    }
  }


  Future<void> uploadDescription(BuildContext context,var desc) async{
    var data = {
      "desc": desc.toString(),
      "id": _auth.currentUser!.uid.toString(),
    };
    profileRepository.addDescription(data,_auth.currentUser!.uid.toString()).then((value)
    {
      Flushbar(
        message: "Description edited Successfully!",
        icon: Icon(
          Icons.info_outline,
          size: 28.0,
          color: Colors.blue,
        ),
        duration: Duration(seconds: 3),
        leftBarIndicatorColor: Colors.blue,
      )..show(context);
    });
  }

  void setProfileDetails(ApiResponse<profileModel> apiResponse) {
    profileModelResp = apiResponse;
    notifyListeners();
  }



}