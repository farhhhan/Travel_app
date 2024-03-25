import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travel_app/domain/packageModel/packageModel.dart';


class AgencyindvRepo{
   Future<List<PackageModel>> get(String uid) async {
    List<PackageModel> packageList = [];
    try {
      final datas = await FirebaseFirestore.instance
          .collection('package').where('uid',isEqualTo: uid).get();
           print(datas.docs);
      datas.docs.forEach((element) { 
        packageList.add(PackageModel.fromJson(element.data()));
      });
      return packageList;
    } catch (e) {
      print(e.toString());
      return packageList;
    }
  }
Future<List<PackageModel>> searchPackage(String searchtxt,String uid) async {
  List<PackageModel> packageList = [];
  try {
    final datas = await FirebaseFirestore.instance 
      .collection('package')
      .where("packageName", isNotEqualTo: searchtxt)
      .orderBy("packageName")
      .startAt([searchtxt])
      .endAt([searchtxt + '\uf8ff'])
      .get();
    
    datas.docs.forEach((element) { 
      packageList.add(PackageModel.fromJson(element.data()));
    });
    return packageList;
  } catch (e) {
    print(e.toString());
    return packageList;
  }
}

}
