import 'package:flutter/foundation.dart' show immutable;
import 'package:travel_app/domain/packageModel/packageModel.dart';

@immutable
class WishModel {
  Map<String,dynamic> packageModel;
  String w_uid;
  String u_uid;
  String p_uid;
  String packageName;
  WishModel({
    required this.packageName,
    required this.packageModel,
    required this.w_uid,
    required this.u_uid,
    required this.p_uid,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
       'wish_package':packageModel,
     'u_uid':u_uid,
     'w_uid':w_uid,
     'p_uid':p_uid,
     'packageName':packageName
    };
  }

  factory WishModel.fromMap(Map<String, dynamic> map) {
    return WishModel(
      packageName: map['packageName'],
       p_uid: map['p_uid'],
     u_uid: map['u_uid'],
     packageModel: map['wish_package'],
     w_uid: map['w_uid']
    );
  }
}
