// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_new
import 'package:flutter/material.dart';
import 'package:flutter_festival/Controller/add_contributor_controller.dart';
import 'package:flutter_festival/Util/constants.dart';
import 'package:flutter_festival/Util/functions.dart';
import 'package:flutter_festival/Util/location.dart';
import 'package:flutter_festival/View/pick_from_map.dart';
import 'package:flutter_festival/Widgets/checkbox.dart';
import 'package:flutter_svg/svg.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import '../Widgets/button_widget.dart';
import '../Widgets/custom_field.dart';

class AddContributor extends StatelessWidget {
  AddContributor({Key? key}) : super(key: key);
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AddContributorController controller = Get.put(AddContributorController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("إضافة تبرع - تطوع",
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
                          "اسم المتبرع - المتطوع",
                          style: TextStyle(
                              fontSize: 18,
                              color: kTextColor,
                              fontWeight: FontWeight.bold),
                        ),
                        CustomField(
                          hint: "ياسر , امين ....",
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
                          hint: "0696316927",
                          keyboardType: TextInputType.phone,
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
                                  organisation: false,
                                ));
                              },
                            ),
                          ],
                        ),
                        Text(
                          "نوع التبرع",
                          style: TextStyle(
                              fontSize: 18,
                              color: kTextColor,
                              fontWeight: FontWeight.bold),
                        ),
                        CheckBoxItem(
                            text: "ملابس",
                            value: (val, checked) {
                              controller.donations(val, checked!);
                            }),
                        CheckBoxItem(
                            text: "مبلغ نقدي",
                            value: (val, checked) {
                              controller.donations(val, checked!);
                            }),
                        CheckBoxItem(
                            text: "غذاء",
                            value: (val, checked) {
                              controller.donations(val, checked!);
                            }),
                        CheckBoxItem(
                            text: "تطوع لدار رحمة",
                            value: (val, checked) {
                              controller.donations(val, checked!);
                            }),
                        CheckBoxItem.others(
                            text: "تبرع او تطوع من نوع اخر",
                            hintText: "اختصر نوع التبرع او التطوع في بضع كلمات",
                            value: (val, checked) {
                              controller.donations(val, checked!);
                            }),
                        Text(
                          "معلومات اضافية",
                          style: TextStyle(
                              fontSize: 18,
                              color: kTextColor,
                              fontWeight: FontWeight.bold),
                        ),
                        CustomField(
                            maxLines: 5,
                            hint: "قدم معلومات او شرح اكثر",
                            validator: (val) {
                              return null;
                            },
                            onSaved: (val) {
                              controller.extraInfo = val!;
                            }),
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
        onTap: () {
          _formKey.currentState?.save();
          if (_formKey.currentState!.validate()) {
            controller.addPerson();
          }
          // Get.back();
        },
        margin: EdgeInsets.only(left: 13, right: 13, bottom: 10),
        borderRadius: 13,
      ),
    );
  }
}

class ContainerIconText extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function()? onTap;

  const ContainerIconText(
      {Key? key, required this.title, required this.icon, required this.onTap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              kRadius,
            ),
            color: Colors.white,
            border: Border.all(
              color: kPrimaryColor,
            )),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          Icon(
            icon,
            color: kSecondaryColor,
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            title,
            style: TextStyle(color: kPrimaryColor, fontSize: 16),
          ),
        ]),
      ),
    );
  }
}
