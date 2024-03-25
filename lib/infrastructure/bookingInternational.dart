import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travel_app/domain/data/todo.dart';

class BookingInternational {
  Future<void> bookingPackage(
      {
      required String status,
      required String packageName,
      required List<Todo> TravellersList,
      required String Trevelling_date,
      required String traveller_email,
      required String traveller_country,
      required String traveller_number,
      required String agency_uid,
      required String p_uid,
      required String treveller_state,
      required String treveller_city,
      required String u_uid,
      required String phone,
      required String payment,
      required String image,
      required String payment_status}) async {
    String uid;
    final db = FirebaseFirestore.instance;
    List<Map<String, dynamic>> trevller_detials =
        TravellersList.map((task) => task.toMap() as Map<String, dynamic>)
            .toList();

    uid = db.collection('booking').doc().id;
    final data = {
      'totalPayment': payment,
      'packageImage': image,
      'a_uid': agency_uid,
      'u_uid': u_uid,
      'uid': uid,
      'p_uid': p_uid,
      'packageName': packageName,
      'travellersList': trevller_detials,
      'traveller_emial': traveller_email,
      'traveller_phone': traveller_number,
      'trveller_country': traveller_country,
      'trveller_State': treveller_state,
      'trveller_city': treveller_city,
      'Travelling_date': Trevelling_date,
      'trveller_gst': phone,
      'status': status,
      'payment_status': payment_status,
    };
    await db.collection("booking").doc(uid).set(data, SetOptions(merge: true));
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
