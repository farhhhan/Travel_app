class adModel {
  String imageUrl;
  String date;
  String uid;


  adModel({
    required this.imageUrl,
    required this.date,
    required this.uid,
   
  });

  factory adModel.fromJson(Map<String, dynamic> json) {
    return adModel(
      imageUrl: json['imageUrl'], 
      date: json['date'],
      uid: json['uid'],
     
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['imageUrl'] = this.imageUrl; 
    data['date'] = this.date;
    data['uid'] = this.uid;
    return data;
  }
}
