import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travel_app/domain/userModel/userModel.dart';

class AgencyProfoRepo{
   Future<List<UserModel>> get({required String uid}) async {
    List<UserModel> agencyList = [];
    try {
      final datas = await FirebaseFirestore.instance
          .collection('agency')
          .where('uid', isEqualTo:uid).get();
      datas.docs.forEach((element) { 
       return agencyList.add(UserModel.fromJson(element.data()));
      });
      return agencyList;
    } catch (e) {
      print(e.toString());
      return agencyList;
    }
  }
}

