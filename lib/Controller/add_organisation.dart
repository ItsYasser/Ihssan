import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_festival/Widgets/donneur.Class.dart';
import 'package:get/get.dart';

import '../Models/organisation_model.dart';
import '../Util/functions.dart';

class AddOrganisationController extends GetxController {
  late String name, phoneNumber;
  List<String> services = [];
  final CollectionReference _organisation =
      FirebaseFirestore.instance.collection('Organisation');

  void servicesHandler(String val, bool checked) {
    if (checked) {
      if (services.contains(val)) return;
      services.add(val);
    } else {
      if (services.contains(val)) services.remove(val);
      return;
    }
  }

  void addOrganisation() async {
    String id = _organisation.doc().id;
    if (services.isEmpty) {
      snackBar(
          title: "خطأ في عملية الاضافة",
          message: "يجب عليك تقديم خدمة واحدة على الاقل");
      return;
    } else {
      Organizer organisation = Organizer(
        name: name,
        phone: phoneNumber,
        services: services,
      );
      circularDialog();
      await _organisation.doc(id).set(organisation.toJason());
      Get.back(closeOverlays: true);
      Get.back();
      snackBar(
        title: "تمت الاضافة بنجاح",
        message: "تم اضافة الخدمة بنجاح , شكرا".tr,
        titleColor: Colors.green,
      );
    }
  }
}
