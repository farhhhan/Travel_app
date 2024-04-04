import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:travel_app/infrastructure/auth.dart';
import 'package:travel_app/presentation/commentScreens/bottom_navigator.dart';

class FireStoreUser {
  FirebaseAuthentServices _authServices = FirebaseAuthentServices();

  void registerUser({
    required XFile images,
    required BuildContext context,
    required String email,
    required String username,
    required String phoneNumber,
    required String password,
    required bool isUser,
  }) async {
    print('hellow check 1');
    final db = FirebaseFirestore.instance;
    User? user = await _authServices.signUpWithEmailandPassword(
      email: email,
      password: password,
    );

    if (user != null) {
      print('User Successfully Created');
      try {
         print('hellow check 2');
        firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
            .ref('${DateTime.now().millisecondsSinceEpoch.toString()}');
        firebase_storage.UploadTask uploadTask = ref.putFile(File(images.path));
        await uploadTask;
        var newUrl = await ref.getDownloadURL();
        final data = <String, String>{
          "Name": username,
          "Email": email,
          "phone": phoneNumber,
          "profile": newUrl,
          'uid': FirebaseAuth.instance.currentUser!.uid,
        };

        // Save user data to Firestore
        if (isUser) {
           print('hellow check 3');
          await db.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).set(data);
        }

        // Navigate to next screen
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => UserBottomNavScreen()),
          (route) => false,
        );
      } catch (e) {
        // Handle storage errors
        print('Error uploading image: $e');
        // You may want to show an error message to the user here
      }
    } else {
      print('Something went wrong during user creation');
      // You may want to show an error message to the user here
    }
  }
}
