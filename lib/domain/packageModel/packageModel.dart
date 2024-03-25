class PackageModel {
  String? packageName;
  String? packageDesc;
  String? uid;
  String? packageCategory;
  String? packagePayment;
  List?  activityList;
  double? packageLong;
  double? packageLat;
  String? packageLocation;
  String? packageType;
  List? imageUrlList;
  String? puid;
  PackageModel({
    required this.puid,
    required this.packageType,
    required this.packageLocation,
    required this.packageLat,
    required this.packageLong,
    required this.packageName,
    required this.packageDesc,
    required this.uid,
    required this.packageCategory,
    required this.packagePayment,required this.activityList,
    required this.imageUrlList,
  });

  factory PackageModel.fromJson(Map<String, dynamic> json) {
    return PackageModel(
      puid: json['puid'],
      imageUrlList: json['packageUrl'],
      packageType: json['packageType'],
      packageLocation: json['packageLocation'],
      packageLat: json['packageLat'],
      packageLong: json['packageLong'],
      activityList: json['activity'],
      packagePayment: json['packagePayment'],
      packageName: json['packageName'], 
      packageDesc: json['packageDesc'],
      uid: json['uid'],
      packageCategory: json['packageCategory'],
    );
  }
  Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['puid'] = this.puid;
  data['packageType'] = this.packageType;
  data['packageLocation'] = this.packageLocation;
  data['packageLat'] = this.packageLat;
  data['packageLong'] = this.packageLong;
  data['packageName'] = this.packageName;
  data['packageDesc'] = this.packageDesc;
  data['uid'] = this.uid;
  data['packageCategory'] = this.packageCategory;
  data['packagePayment'] = this.packagePayment;
  data['activity'] = this.activityList;
  data['imageUrlList'] = this.imageUrlList;
  return data;
}
}
