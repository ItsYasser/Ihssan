// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_new
import 'package:flutter/material.dart';
import 'package:flutter_festival/Util/constants.dart';
import 'package:flutter_festival/Widgets/checkbox.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_festival/Widgets/orgClass.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../Widgets/button_widget.dart';
import '../Widgets/custom_field.dart';
import '../Widgets/custom_text_field.dart';

class AddContributor extends StatelessWidget {
  AddContributor({Key? key}) : super(key: key);
  late String orgName, phoneNumber;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final CollectionReference organisation =
      FirebaseFirestore.instance.collection("Organisation");
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
                          hint: "جمعية الوفاء , جمعية البركة",
                          onSaved: (val) {
                            print(val);
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
                          hint: "+213669316927",
                          onSaved: (val) {
                            print(val);
                          },
                        ),
                        Text(
                          "العنوان",
                          style: TextStyle(
                              fontSize: 18,
                              color: kTextColor,
                              fontWeight: FontWeight.bold),
                        ),
                        CustomField(
                          hint: "اظغط لتحديد العنوان",
                          onSaved: (val) {
                            print(val);
                          },
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
                            value: (val) {
                              print(val);
                            }),
                        CheckBoxItem(
                            text: "مبلغ نقدي",
                            value: (val) {
                              print(val);
                            }),
                        CheckBoxItem(
                            text: "غذاء",
                            value: (val) {
                              print(val);
                            }),
                        CheckBoxItem(
                            text: "تطوع لدار رحمة",
                            value: (val) {
                              print(val);
                            }),
                        CheckBoxItem.others(
                            text: "تبرع او تطوع من نوع اخر",
                            hintText: "اختصر نوع التبرع او التطوع في بضع كلمات",
                            value: (val) {
                              print(val);
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
                            onSaved: (val) {}),
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
          Get.back();
        },
        margin: EdgeInsets.only(left: 13, right: 13, bottom: 10),
        borderRadius: 13,
      ),
    );
  }
}
