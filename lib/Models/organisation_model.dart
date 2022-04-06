import 'package:cloud_firestore/cloud_firestore.dart';

class Organizer {
  String? name;
  String? phone;
  List<String>? services;
  GeoPoint? locationO;

  Organizer({
    this.name,
    this.phone,
    this.services,
    this.locationO,
  });

  toJson() {
    return {
      "name": name,
      "phone": phone,
      "services": services,
      "location": locationO,
    };
  }

  Organizer.fromJson(Map<dynamic, dynamic> map) {
    if (map == null) {
      return;
    }
    name = map['name'];
    phone = map['phone'];

    services = List<String>.from(map['services']);
    locationO = map['location'];
  }
}
