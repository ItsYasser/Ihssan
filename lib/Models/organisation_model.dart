import 'package:cloud_firestore/cloud_firestore.dart';

class Organizer {
  final String? name;
  final String? phone;
  final List<String>? services;
  //  finalGeoPoint locationO;

  Organizer({
    this.name,
    this.phone,
    this.services,
  });

  toJason() {
    return {
      "name": name,
      "phone": phone,
      "services": services,
      // "locationO": locationO,
    };
  }
}
