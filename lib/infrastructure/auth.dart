import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:travel_app/infrastructure/util.dart';
import 'package:travel_app/presentation/commentScreens/bottom_navigator.dart';
import 'package:travel_app/presentation/userScreen/auth/login/user_login.dart';

class FirebaseAuthentServices{
  FirebaseAuth _auth= FirebaseAuth.instance;
 final FirebaseFirestore firestore=FirebaseFirestore.instance;
 Future<User?> signUpWithEmailandPassword({required String email, required String password}) async {
  try {
    UserCredential credential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
    return credential.user;
  } catch (e) {
    print('Error signing up: $e');
    throw Exception('Error signing up: $e'); 
  }
}

  Future<User?> signInWithEmailandPassword({required String email,required String password})async{
    try{
        UserCredential credential=await _auth.signInWithEmailAndPassword(email: email, password: password);
        return credential.user;
    }catch(e){
       throw Exception(e.toString());
    }
  }
  
 Future<void> signInWithGoogle(BuildContext context, bool isUser) async {
  final GoogleSignIn googleSignIn = GoogleSignIn();

  try {
    final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
        print("Step 1        current working");

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken,
      );
     print("Is current working");
      UserCredential userCredential = await _auth.signInWithCredential(credential);
      User? user = userCredential.user;

      print(user);

      if (user != null && isUser) {
        await firestore.collection("users").doc(user.uid).set({
          "uid": user.uid,
          "Name": user.displayName,
          "Email": user.email,
          "profile": user.photoURL,
        });

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => UserLoginScreen(),
          ),
          (route) => false,
        );
      }
    }
  } catch (e) {
    print("Exception is: $e");
  }
}
 void forgetPassword(String email) async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: email)
          .onError((error, stackTrace) {
        utils().showToast(error.toString());
      });
    } catch (e) {
      print(e);
    }
  }
}