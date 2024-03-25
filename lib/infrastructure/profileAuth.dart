import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:travel_app/domain/userModel/userModel.dart';
class UserProfile {
  Future<List<UserModel>> get() async {
    List<UserModel> agencyList = [];
     User? user = FirebaseAuth.instance.currentUser;
    try {
      final datas = await FirebaseFirestore.instance
          .collection('users')
          .where('uid', isEqualTo: user!.uid).get();
      datas.docs.forEach((element) { 
       return agencyList.add(UserModel.fromJson(element.data()));
      });
      return agencyList;
    } catch (e) {
      print(e.toString());
      return agencyList;
    }
  }
  
 Future<void> updateAgency(UserModel UserModel) async {
  try {
    if (UserModel.profile != null) {
      final ref = firebase_storage.FirebaseStorage.instance
          .ref('/foldername' + '1224');
      final uploadTask = ref.putFile(File(UserModel.profile));
      await uploadTask;

      final newUrl = await ref.getDownloadURL();
      UserModel.profile = newUrl ?? UserModel.profile;
    }

    await FirebaseFirestore.instance
        .collection('agency')
        .doc(UserModel.uid)
        .update(UserModel.toJson());
  } catch (e) {
    print('Error updating agency: $e');
    throw e; 
  }
}

}
