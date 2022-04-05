// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_new
import 'package:flutter/material.dart';
import 'package:flutter_festival/Util/constants.dart';
import 'package:flutter_festival/Widgets/checkbox.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_festival/Widgets/orgClass.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../Widgets/button_widget.dart';
import '../Widgets/custom_text_field.dart';

class OrgDetails extends StatelessWidget {
  OrgDetails({Key? key}) : super(key: key);
  late String orgName, phoneNumber;
  double gap = 20;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("تفاصيل الجمعية",
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(kRadius),
                            color: Colors.white,
                            boxShadow: kBoxShadow),
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "اسم الجمعية",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey,
                                      height: 1),
                                ),
                                Text(
                                  "جمعية البركة",
                                  style: TextStyle(
                                    fontSize: 17,
                                    color: kTextColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: kSecondaryColor,
                                ),
                              ),
                              child: Icon(
                                Icons.phone,
                                color: kSecondaryColor,
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: gap,
                      ),
                      Text(
                        "رقم الهاتف",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                          height: 1,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "+213659955555",
                        style: TextStyle(
                          fontSize: 17,
                          color: kTextColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: gap,
                      ),
                      Text(
                        "العنوان",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                          height: 1,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "حي ديبس المختار - باب الزوار - الجزائر",
                        style: TextStyle(
                          fontSize: 17,
                          color: kTextColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: gap,
                      ),
                      Text(
                        "خدمات الجمعية",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                          height: 1,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "مطاعم الرحمة",
                        style: TextStyle(
                          fontSize: 17,
                          color: kTextColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "قفة رمضان",
                        style: TextStyle(
                          fontSize: 17,
                          color: kTextColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: gap,
                      ),
                      Text(
                        "ملف توثيق الجمعية",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                          height: 1,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            "توثيق الجمعية.pdf",
                            style: TextStyle(
                              fontSize: 17,
                              color: kTextColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Icon(
                            Icons.file_download_outlined,
                            color: kSecondaryColor,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Button(
        text: "رجوع",
        onTap: () {
          Get.back();
        },
        margin: EdgeInsets.only(left: 13, right: 13, bottom: 10),
        borderRadius: 13,
      ),
    );
  }
}
