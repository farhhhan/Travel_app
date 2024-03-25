import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travel_app/domain/packageModel/packageModel.dart';


class IndivtualPackageRepo{
   Future<List<PackageModel>> get({required String puid}) async {
    List<PackageModel> indivtalPackage = [];
    try {
      final datas = await FirebaseFirestore.instance
          .collection('package')
          .where('puid', isEqualTo:puid).get();
          print(datas.docs);
      datas.docs.forEach((element) { 
       return indivtalPackage.add(PackageModel.fromJson(element.data()));
      });
      return indivtalPackage;
    } catch (e) {
      print(e.toString());
      return indivtalPackage;
    }
  }
  Future<void> afterApprove({
    required String status,
    required String uid,
  }) async {
    final db = FirebaseFirestore.instance;
    final data = {'status': status};
    await db.collection("booking").doc(uid).update(data);
  }
}