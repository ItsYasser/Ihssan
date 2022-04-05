// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_new
import 'package:flutter/material.dart';
import 'package:flutter_festival/Util/constants.dart';
import 'package:flutter_festival/Widgets/checkbox.dart';
import 'package:flutter_svg/svg.dart';

import '../Widgets/button_widget.dart';
import '../Widgets/custom_text_field.dart';

class AddOrg extends StatelessWidget {
  const AddOrg({Key? key}) : super(key: key);

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
        backgroundColor: Colors.transparent,
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Opacity(
              opacity: 0.07,
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
                      CustomField(hint: "جمعية الوفاء , جمعية البركة"),
                      Text(
                        "رقم الهاتف",
                        style: TextStyle(
                            fontSize: 18,
                            color: kTextColor,
                            fontWeight: FontWeight.bold),
                      ),
                      CustomField(hint: "+213669316927"),
                      Text(
                        "العنوان",
                        style: TextStyle(
                            fontSize: 18,
                            color: kTextColor,
                            fontWeight: FontWeight.bold),
                      ),
                      CustomField(hint: "اظغط لتحديد العنوان"),
                      Text(
                        "خدمات الجمعية",
                        style: TextStyle(
                            fontSize: 18,
                            color: kTextColor,
                            fontWeight: FontWeight.bold),
                      ),
                      CheckBoxItem(
                          text: "التكفل بذوي الاحتياجات الخاصة",
                          value: (val) {
                            print(val);
                          }),
                      CheckBoxItem(
                          text: "مطاعم الرحمة",
                          value: (val) {
                            print(val);
                          }),
                      CheckBoxItem(
                          text: "قفة رمضان",
                          value: (val) {
                            print(val);
                          }),
                      CheckBoxItem(
                          text: "مساعدة اليتامى",
                          value: (val) {
                            print(val);
                          }),
                      CheckBoxItem.others(
                          text: "خدمة أخرى",
                          hintText: "اختصر الخدمة في بضع كلمات ",
                          value: (val) {
                            print(val);
                          })
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Button(
        text: "اضف",
        onTap: () {},
        margin: EdgeInsets.symmetric(
          horizontal: 13,
          vertical: 15,
        ),
        borderRadius: 13,
      ),
    );
  }
}

class CustomField extends StatelessWidget {
  final String hint;

  const CustomField({Key? key, this.hint = ""}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 7),
      child: TextFormField(
        decoration: InputDecoration(
          contentPadding:
              new EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          fillColor: Colors.white70,
          filled: true,
          hintText: hint,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: kPrimaryColor),
            borderRadius: BorderRadius.all(
              Radius.circular(kRadius),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: kSecondaryColor),
            borderRadius: BorderRadius.all(
              Radius.circular(kRadius - 5),
            ),
          ),
        ),
      ),
    );
  }
}