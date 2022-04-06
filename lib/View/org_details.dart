// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_new
import 'package:flutter/material.dart';
import 'package:flutter_festival/Util/constants.dart';

import 'package:url_launcher/url_launcher.dart';

import '../Models/organisation_model.dart';
import '../Util/functions.dart';

class OrganisationDetails extends StatelessWidget {
  final Organizer org;
  double gap = 20;

  OrganisationDetails(this.org, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
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
                margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(kRadius),
                    color: Colors.white,
                    boxShadow: kBoxShadow),
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "اسم الجمعية",
                          style: TextStyle(
                              fontSize: 16, color: Colors.grey, height: 1),
                        ),
                        Text(
                          org.name!,
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
                    GestureDetector(
                      onTap: () {
                        phoneCall(org.phone!);
                      },
                      child: Container(
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
                org.phone!,
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
              for (String? item in org.services!)
                Text(
                  item!,
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
                  GestureDetector(
                    onTap: () {
                      launch(org.urlDownload!);
                    },
                    child: Icon(
                      Icons.file_download_outlined,
                      color: kSecondaryColor,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
