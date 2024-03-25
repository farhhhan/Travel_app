import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:travel_app/infrastructure/auth.dart';
import 'package:travel_app/presentation/commentScreens/bottom_navigator.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;


class FireStoreUser{
   FirebaseAuthentServices _authServices = FirebaseAuthentServices();
  void registerUser({required XFile images,required BuildContext context,required  String email,required String username,required String phoneNumber,required String password,required bool isUser}) async {
   final db = FirebaseFirestore.instance;
    User? user = await _authServices.signUpWithEmailandPassword(
        email: email, password: password);
    firebase_storage.Reference ref =
        firebase_storage.FirebaseStorage.instance.ref('${DateTime.now().millisecondsSinceEpoch.toString()}');
    firebase_storage.UploadTask uploadTask = ref.putFile(File(images.path));
     Future.value(uploadTask);
      var newUrl = await ref.getDownloadURL();    
    if (user != null) {
      print('User Succesfully Created');
      final data = <String, String>{
        "Name": username,
        "Email": email,
        "phone": phoneNumber,
        "profile":newUrl,
        'uid':FirebaseAuth.instance.currentUser!.uid
      };

    if(isUser){  db
          .collection("users").doc(FirebaseAuth.instance.currentUser!.uid).
          set(data);}
         
      Navigator.pushAndRemoveUntil(
          context, MaterialPageRoute(builder: (context) => UserBottomNavScreen()),(route) => false,);
    } else {
      print('Some thing error occures');
    }
  }
}