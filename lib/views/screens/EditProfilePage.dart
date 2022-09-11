import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:orange/utils/CustomColors.dart';
import 'package:orange/utils/CustomTextStyle.dart';
import 'package:orange/viewmodels/profileViewModel.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';


class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  TextEditingController descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Text(
          "Edit Profile",
          style: CustomTextStyle.textFormFieldBlack.copyWith(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 24,
            ),
            Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                        // image: DecorationImage(image: NetworkImage("https://firebasestorage.googleapis.com/v0/b/orange-c52a0.appspot.com/o/images%2F1663107569014?alt=media&token=b3a9e11d-f810-4373-9163-9fc53160a433"),
                        //     fit: BoxFit.cover,
                        // ),
                      borderRadius: BorderRadius.all(Radius.circular(100)),
                      border: Border.all(color: Colors.orange)
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: 120,
                    height: 120,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        IconButton(
                            icon: Icon(
                              Icons.image,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              Provider.of<ProfileViewModel>(context,listen: false).uploadProfileImage(context);
                            }),

                        Text(
                          "Choose Image",
                          style: CustomTextStyle.textFormFieldMedium
                              .copyWith(color: Colors.black, fontSize: 12,fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
            Container(
              child: TextFormField(
                controller: descriptionController,
                keyboardType: TextInputType.multiline,
                maxLines: 5,
                minLines: 3,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(12),
                  border: border,
                  hintText: "Description",
                  focusedBorder: border.copyWith(
                      borderSide: BorderSide(color: Colors.blue)),
                ),
              ),
              margin: EdgeInsets.only(left: 12, right: 12, top: 24),
            ),

            SizedBox(
              height: 24,
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(left: 48, right: 48),
              child: ElevatedButton(
                // color: Colors.blue,
                // textColor: Colors.white,
                onPressed: () {

                  Provider.of<ProfileViewModel>(context,listen: false).uploadDescription(context,descriptionController.text);
                },
                child: Text(
                  "Save",
                  style: CustomTextStyle.textFormFieldBlack
                      .copyWith(color: Colors.white, fontSize: 16),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  var border = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(4)),
      borderSide: BorderSide(width: 1, color: Colors.grey));



}
