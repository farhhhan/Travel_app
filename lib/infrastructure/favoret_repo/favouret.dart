import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:travel_app/domain/packageModel/packageModel.dart';
import 'package:travel_app/domain/wishModel/wishModel.dart';

class Wish {
  Future<void> addWishList({required PackageModel packageModel}) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var cur_uid = _auth.currentUser!.uid;
    final db = FirebaseFirestore.instance;
    bool exists = await isInWish(packageModel.puid!);
    if (exists) {
      throw Exception('Package already exists in the wishlist');
    }

    final w_uid = db.collection('wish_lists').doc().id;
    WishModel wishModel = WishModel(
      packageModel: packageModel.toJson(),
      u_uid: cur_uid,
      w_uid: w_uid,
      p_uid: packageModel.puid!,
      packageName: packageModel.packageName!
    );
    print(packageModel.packageName);
    await db.collection('wish_lists').doc(w_uid).set(wishModel.toMap());
  }

  Future<bool> isInWish(String package_id) async {
    final datas = await FirebaseFirestore.instance
        .collection('wish_lists')
        .where('u_uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .where('p_uid', isEqualTo: package_id)
        .get();
    return datas.docs.isNotEmpty;
  }

  Future<List<WishModel>> getWishList() async {
    List<WishModel> listwish = [];
    try {
      final datas = await FirebaseFirestore.instance
          .collection('wish_lists')
          .where('u_uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get();

      datas.docs.forEach((element) {
        listwish.add(WishModel.fromMap(element.data()));
      });
      return listwish;
    } catch (e) {
      print(e.toString());
      return listwish;
    }
  }

  Future removeWish(String doc_id) async {
    try {
      await FirebaseFirestore.instance
          .collection('wish_lists')
          .doc(doc_id)
          .delete();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<List<WishModel>> searchPackage(String searchtxt) async {
    List<WishModel> packageList = [];
    try {
      print(searchtxt);
      final datas = await FirebaseFirestore.instance
          .collection('wish_lists')
          .where('u_uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .where("packageName", isNotEqualTo: searchtxt)
          .orderBy("packageName")
          .startAt([searchtxt]).endAt([searchtxt + '\uf8ff']).get();
      print(datas.docs);
      datas.docs.forEach((element) {
        packageList.add(WishModel.fromMap(element.data()));
      });
      return packageList;
    } catch (e) {
      print(e.toString());
      return packageList;
    }
  }
}
