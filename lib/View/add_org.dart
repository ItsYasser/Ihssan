// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_new
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_festival/Controller/add_organisation.dart';
import 'package:flutter_festival/Util/constants.dart';
import 'package:flutter_festival/Util/functions.dart';
import 'package:flutter_festival/View/add_contributor.dart';
import 'package:flutter_festival/View/pick_from_map.dart';
import 'package:flutter_festival/Widgets/checkbox.dart';
import 'package:flutter_svg/svg.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import '../Util/functions.dart';
import '../Util/location.dart';
import '../Widgets/button_widget.dart';
import '../Widgets/custom_field.dart';
import '../Widgets/custom_text_field.dart';

class AddOrg extends StatefulWidget {
  AddOrg({Key? key}) : super(key: key);

  @override
  State<AddOrg> createState() => _AddOrgState();
}

class _AddOrgState extends State<AddOrg> {
  late String orgName = "", phoneNumber = "";
  String upFile = "تحميل الملف";
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AddOrganisationController controller = Get.put(AddOrganisationController());
  String getFileName(String string) {
    return string.split('/').last;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("إضافة جمعية",
            style: Theme.of(context).textTheme.headline4?.copyWith(
                  color: kPrimaryColor,
                )),
        elevation: 0,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Icon(
            Icons.arrow_back_ios_rounded,
            color: kPrimaryColor,
          ),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Opacity(
              opacity: .2,
              child: SvgPicture.asset(
                "assets/images/background.svg",
                fit: BoxFit.cover,
              ),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 25, 12, 0),
                child: SingleChildScrollView(
                  physics: ClampingScrollPhysics(),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "اسم الجمعية",
                          style: TextStyle(
                              fontSize: 18,
                              color: kTextColor,
                              fontWeight: FontWeight.bold),
                        ),
                        CustomField(
                          hint: "جمعية الوفاء , جمعية البركة",
                          onSaved: (val) {
                            controller.name = val!;
                          },
                        ),
                        Text(
                          "رقم الهاتف",
                          style: TextStyle(
                              fontSize: 18,
                              color: kTextColor,
                              fontWeight: FontWeight.bold),
                        ),
                        CustomField(
                          keyboardType: TextInputType.phone,
                          hint: "0669316927",
                          onSaved: (val) {
                            controller.phoneNumber = val!;
                          },
                        ),
                        Text(
                          "الموقع الجغرافي",
                          style: TextStyle(
                              fontSize: 18,
                              color: kTextColor,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "اختر طريقة لتحديد موقعك الجغرافي",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ContainerIconText(
                              title: "موقعي الحالي",
                              icon: Icons.my_location,
                              onTap: () async {
                                myDialog(
                                    "يتم الان تحديد موقعك , الرجاء الانتظار");
                                Position pos = await determinePosition();
                                Get.back();
                                controller.location =
                                    GeoPoint(pos.latitude, pos.longitude);
                              },
                            ),
                            Text(
                              "او",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: kTextColor,
                                  fontWeight: FontWeight.bold),
                            ),
                            ContainerIconText(
                              title: "حدد من الخريطة",
                              icon: Icons.map,
                              onTap: () {
                                Get.to(PickFromMap(
                                  organisation: true,
                                ));
                              },
                            ),
                          ],
                        ),
                        Text(
                          "خدمات الجمعية",
                          style: TextStyle(
                              fontSize: 18,
                              color: kTextColor,
                              fontWeight: FontWeight.bold),
                        ),
                        CheckBoxItem(
                            text: "التكفل بذوي الاحتياجات الخاصة",
                            value: (val, checked) {
                              controller.servicesHandler(val, checked!);
                            }),
                        CheckBoxItem(
                            text: "مطاعم الرحمة",
                            value: (val, checked) {
                              controller.servicesHandler(val, checked!);
                            }),
                        CheckBoxItem(
                            text: "قفة رمضان",
                            value: (val, checked) {
                              controller.servicesHandler(val, checked!);
                            }),
                        CheckBoxItem(
                            text: "مساعدة اليتامى",
                            value: (val, checked) {
                              controller.servicesHandler(val, checked!);
                            }),
                        CheckBoxItem.others(
                            text: "خدمة أخرى",
                            hintText: "اختصر الخدمة في بضع كلمات ",
                            value: (val, checked) {
                              controller.servicesHandler(val, checked!);
                            }),
                        Text(
                          "ملف توثيق الجمعية",
                          style: TextStyle(
                              fontSize: 18,
                              color: kTextColor,
                              fontWeight: FontWeight.bold),
                        ),
                        GestureDetector(
                          onTap: () async {
                            await controller.selectFile().then((value) {
                              circularDialog();
                              controller.file = File(value.path ?? "");
                              upFile = getFileName(value.path ?? "");
                              setState(() {
                                Get.back();
                              });
                            });
                          },
                          child: Container(
                            width: double.infinity,
                            margin: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(kRadius),
                                color: Colors.white,
                                boxShadow: kBoxShadow),
                            padding: EdgeInsets.all(15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  upFile,
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.grey),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Icon(
                                  Icons.file_upload_outlined,
                                  color: Colors.grey,
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Button(
        text: "اضف",
        onTap: () async {
          _formKey.currentState?.save();
          if (_formKey.currentState!.validate()) {
            circularDialog();
            await controller
                .uploadFile("Files/${controller.name}/$upFile", controller.file)
                .then((value) {
              print(value);
              controller.url = value;
              controller.addOrganisation();
              Get.back();
            });
          }
        },
        margin: EdgeInsets.only(left: 13, right: 13, bottom: 10),
        borderRadius: 13,
      ),
    );
  }
}
