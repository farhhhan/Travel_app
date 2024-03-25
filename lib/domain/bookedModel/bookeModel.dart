import 'package:travel_app/domain/data/todo.dart';

class BookedModel {
  final packageName;
  List<dynamic> TravellersList;
   String? Trevelling_date;
  String? traveller_email;
  String? traveller_city;
  String? traveller_country;
  String? traveller_number;
  String? agency_uid;
  String? p_uid;
  String? treveller_state;
  String? treveller_city;
    String? gstaddress;
     String? u_uid;
      String? image;
      String? totalPayment;
  String? uid;
  String? status;
  String? reasons;
  BookedModel({
    required this.totalPayment,
    required this.image,
    required this.status,
    required this.u_uid,
     required this.gstaddress,
    required this.packageName,
    required this.TravellersList,
    required this.Trevelling_date,
    required this.traveller_email,
    required this.traveller_country,
    required this.traveller_number,
    required this.agency_uid,
    required this.p_uid,
    required this.treveller_state,
    required this.treveller_city,
    required this.uid,
    this.reasons
  });

  factory BookedModel.fromJson(Map<String?, dynamic> json) {
    return BookedModel(
      reasons: json['reason_rejection'],
      totalPayment: json['totalPayment'],
      image: json['packageImage'],
      status: json['status'],
      u_uid: json['u_uid'],
      p_uid: json['p_uid'],
      TravellersList: json['travellersList'],
      Trevelling_date: json['Travelling_date'],
      agency_uid: json['a_uid'],
      gstaddress: json['trveller_gst'],
      traveller_country: json['trveller_country'],
      traveller_email: json['traveller_emial'],
      traveller_number: json['traveller_phone'],
      packageName: json['packageName'], 
      treveller_city: json['trveller_city'],
      uid: json['uid'],
      treveller_state: json['trveller_State'],
    );
  }
}
