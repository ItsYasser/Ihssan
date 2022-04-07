import 'package:flutter/material.dart';

const Color kPrimaryColor = Color(0xff1D457A);
const Color kSecondaryColor = Color(0xffF68C11);
const Color kTextFieldColor = Color(0xffF6F6F6);
const Color kTextColor = Color(0xff1D4881);
const Color kTextFieldTextColor = Color(0xff7D7C7A);
const double kRadius = 10;
List<BoxShadow> kBoxShadow = [
  BoxShadow(
    color: Colors.grey.withOpacity(.5),
    offset: const Offset(0, 0),
    spreadRadius: 1,
    blurRadius: 3,
  )
];
Color kDarkColor = kPrimaryColor.withOpacity(.4);
const String kOrgMarker = 'assets/images/lamp.png';
const String kContMarker = 'assets/images/cont.png';
enum HelpTypeEnum {
  organisation,
  person,
}
List<String> type = ["الجمعيات الخيرية", "المتبرعين و المتطوعين"];
List<String> service = [
  'التكفل بذوي الاحتياجات الخاصة',
  'مطاعم الرحمة',
  'قفة رمضان',
  'جمعيات التبرع بالدم',
  'مساعدة اليتامى'
];
List<String> cont = ['ملابس', 'مبلغ نقدي', 'غذاء', 'تطوع لدار رحمة'];
