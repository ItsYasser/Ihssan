import 'package:cloud_firestore/cloud_firestore.dart';

class Person {
  String? name;

  String? phone;
  List<String?>? sadaka;
  String? info;
  GeoPoint? locationO;
  Person({this.name, this.phone, this.sadaka, this.info, this.locationO});
  toJason() {
    return {
      "name": name,
      "phone": phone,
      "sadaka": sadaka,
      "info": info,
      "location": locationO,
    };
  }

  Person.fromJson(Map<dynamic, dynamic> map) {
    if (map == null) {
      return;
    }
    name = map['name'];
    phone = map['phone'];
    info = map['info'];
    sadaka = List<String>.from(map['sadaka']);
    locationO = map['location'];
  }
}
