// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_new
import 'package:flutter/material.dart';
import 'package:flutter_festival/Controller/data_controller.dart';
import 'package:flutter_festival/Util/constants.dart';
import 'package:flutter_festival/Widgets/button_widget.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../Models/person_model.dart';
import '../Util/functions.dart';
import '../Util/location_services.dart';

class ContributorDetails extends StatelessWidget {
  final Person person;
  ContributorDetails({Key? key, required this.person}) : super(key: key);

  double gap = 20;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Directionality(
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
                  margin:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
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
                            "اسم المتبرع - المتطوع",
                            style: TextStyle(
                                fontSize: 16, color: Colors.grey, height: 1),
                          ),
                          Text(
                            person.name!,
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
                          phoneCall(person.phone!);
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
                  person.phone!,
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
                  "نوع التبرع",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                    height: 1,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                for (String? item in person.sadaka!)
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
                if (person.info!.isNotEmpty || person.info != "")
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "معلومات اضافية",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                          height: 1,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        person.info!,
                        style: TextStyle(
                          fontSize: 17,
                          color: kTextColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Button(
        margin: const EdgeInsets.all(7),
        onTap: () async {
          DataController data = Get.find<DataController>();
          data.draw(
              LatLng(person.locationO!.latitude, person.locationO!.longitude));
          Get.back();
        },
        text: "حدد مسارك الى المتبرع",
      ),
    );
  }
}
