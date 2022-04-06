import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';

class Organizer {

  GeoPoint? locationO;
 String? name;
   String? phone;
   String? urlDownload;
   PlatformFile? file;
   List<String>? services;
  //  finalGeoPoint locationO;


  Organizer( {
    this.urlDownload,
    this.file,
    this.name,
    this.phone,
    this.services,
    this.locationO,
  });

  toJson() {
    return {
      "name": name,
      "phone": phone,
      "url":urlDownload,
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
    urlDownload = map["url"];
    services = List<String>.from(map['services']);
    locationO = map['location'];
  }
}
