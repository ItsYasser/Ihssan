import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_festival/Widgets/donneur.Class.dart';
import 'package:get/get.dart';
import '../Models/organisation_model.dart';
import '../Util/functions.dart';

class AddOrganisationController extends GetxController {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final refrence = FirebaseStorage.instance;

  late String name="", phoneNumber="",url="";
  late File file =File("");
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

  Future<String> uploadFile(String destination, File file) async {
    TaskSnapshot task ;
      final ref = refrence.ref(destination);
      task = await ref.putFile(file);
      return task.ref.getDownloadURL();

  }
  Future<PlatformFile> selectFile() async {
    late PlatformFile file =PlatformFile(name: "", size:200) ;
    final files = await FilePicker.platform
        .pickFiles(allowMultiple: false, allowCompression: true);
    if (files == null) {
      snackBar(
          title: "Warning",
          message: "You haven't upload any files!");
    } else {
      file = files.files.single;
    }
    return file;
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
        urlDownload: url,
        name: name,
        phone: phoneNumber,
        services: services,
      );

      await _organisation.doc(id).set(organisation.toJson());
      Get.back(closeOverlays: true);
      snackBar(
        title: "تمت الاضافة بنجاح",
        message: "تم اضافة الخدمة بنجاح , شكرا".tr,
        titleColor: Colors.green,
      );
    }
  }
}
