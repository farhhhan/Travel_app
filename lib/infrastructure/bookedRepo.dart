import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:travel_app/domain/bookedModel/bookeModel.dart';

class BookedRepo{
   Future<List<BookedModel>> get() async {
    List<BookedModel> packageList = [];
    try {
      final datas = await FirebaseFirestore.instance
          .collection('booking').where('u_uid',isEqualTo: FirebaseAuth.instance.currentUser!.uid).get();
           print(datas.docs);
       datas.docs.forEach((element) {
        final bookingdate = element['Travelling_date'];
        final pickupDate = DateTime.parse(bookingdate);
        DateTime currentDate = DateTime.now();

        if (pickupDate.isAfter(currentDate) || pickupDate==currentDate) {
          packageList.add(BookedModel.fromJson(element.data()));
        }
      });
      print(packageList.length);
      return packageList;
    } catch (e) {
      print(e.toString());
      return packageList;
    }
  }
  Future<List<BookedModel>> getHistory() async {
    List<BookedModel> historyList = [];
    try {
      final datas = await FirebaseFirestore.instance
          .collection('booking')
          .where('u_uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get();
      print(datas.docs);
      datas.docs.forEach((element) {
        final bookingdate = element['Travelling_date'];
        final pickupDate = DateTime.parse(bookingdate);
        DateTime currentDate = DateTime.now();

        if (pickupDate.isBefore(currentDate) && pickupDate !=currentDate) {
          historyList.add(BookedModel.fromJson(element.data()));
        }
      });
      print(historyList.length); 
      return historyList;
    } catch (e) {
      print(e.toString());
      return historyList;
    }
  }
}
