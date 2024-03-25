import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:travel_app/domain/advertesment/adModel.dart';
import 'package:travel_app/domain/packageModel/packageModel.dart';

class PackageSearvicesRepo{
    Future<List<PackageModel>> getPackage() async {
    List<PackageModel> packageList = [];
    try {
      final datas = await FirebaseFirestore.instance
          .collection('package').get();
          print(datas.docs.length);
      datas.docs.forEach((element) { 
       return packageList.add(PackageModel.fromJson(element.data()));
      });
      return packageList;
    } catch (e) {
      print(e.toString());
      return packageList;
    }
  }
    Future<List<PackageModel>> getPopular() async {
    List<PackageModel> packageList = [];
    try {
      final datas = await FirebaseFirestore.instance
          .collection('package')  .where('packageCategory', isEqualTo:'Popular').get();
      datas.docs.forEach((element) { 
       return packageList.add(PackageModel.fromJson(element.data()));
      });
      return packageList;
    } catch (e) {
      print(e.toString());
      return packageList;
    }
  }
   Future<List<PackageModel>> getRecommented() async {
    List<PackageModel> packageList = [];
    try {
      final datas = await FirebaseFirestore.instance
          .collection('package')  .where('packageCategory', isEqualTo:'Recommended').get();
      datas.docs.forEach((element) { 
       return packageList.add(PackageModel.fromJson(element.data()));
      });
      return packageList;
    } catch (e) {
      print(e.toString());
      return packageList;
    }
  }
    Future<List<adModel>> getAd() async {
    List<adModel> adlist = [];
    try {
      final datas = await FirebaseFirestore.instance
          .collection('userAd').get();
      datas.docs.forEach((element) { 
       return adlist.add(adModel.fromJson(element.data()));
      });
      return adlist;
    } catch (e) {
      print(e.toString());
      return adlist;
    }
  }
   Future<List<PackageModel>> getTrending() async {
    List<PackageModel> packageList = [];
    try {
      final datas = await FirebaseFirestore.instance
          .collection('package')  .where('packageCategory', isEqualTo:'Trending').get();
      datas.docs.forEach((element) { 
       return packageList.add(PackageModel.fromJson(element.data()));
      });
      return packageList;
    } catch (e) {
      print(e.toString());
      return packageList;
    }
  }
  Future<List<PackageModel>> getBest() async {
    List<PackageModel> packageList = [];
    try {
      final datas = await FirebaseFirestore.instance
          .collection('package')  .where('packageCategory', isEqualTo:'Best').get();
      datas.docs.forEach((element) { 
       return packageList.add(PackageModel.fromJson(element.data()));
      });
      return packageList;
    } catch (e) {
      print(e.toString());
      return packageList;
    }
  }
}