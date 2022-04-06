import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_festival/Models/person_model.dart';
import 'package:get/get.dart';

import '../Util/functions.dart';

class AddContributorController extends GetxController {
  late String name, phoneNumber, extraInfo;
  List<String> donnationType = [];
  GeoPoint location = GeoPoint(0, 0);
  final CollectionReference _person =
      FirebaseFirestore.instance.collection('Person');

  void donations(String val, bool checked) {
    if (checked) {
      if (donnationType.contains(val)) return;
      donnationType.add(val);
    } else {
      if (donnationType.contains(val)) donnationType.remove(val);
      return;
    }
  }

  void addPerson() async {
    String id = _person.doc().id;
    if (donnationType.isEmpty) {
      snackBar(
          title: "خطأ في عملية الاضافة",
          message: "يجب عليك تقديم تبرع او تطوع واحد على الاقل");
      return;
    }
    if (location.latitude == 0 && location.longitude == 0) {
      snackBar(
          title: "خطأ في عملية الاضافة", message: "عليك اضافة الموقع الجغرافي");
      return;
    }
    Person contributor = Person(
        name: name,
        phone: phoneNumber,
        info: extraInfo,
        sadaka: donnationType,
        locationO: location);
    circularDialog();
    await _person.doc(id).set(contributor.toJason());
    Get.back(closeOverlays: true);
    Get.back();
    snackBar(
      title: "تمت الاضافة بنجاح",
      message: "تم اضافة التبرع بنجاح , شكرا".tr,
      titleColor: Colors.green,
    );
  }
}
