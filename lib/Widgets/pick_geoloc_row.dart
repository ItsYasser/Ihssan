import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import '../Util/constants.dart';
import '../Util/functions.dart';
import '../Util/location.dart';
import '../View/add_contributor.dart';
import '../View/pick_from_map.dart';

class PickGeolocRow extends StatefulWidget {
  PickGeolocRow({
    Key? key,
    required this.func,
    this.isPerson = true,
  }) : super(key: key);

  final Function(GeoPoint geoPoint) func;
  final bool isPerson;

  @override
  State<PickGeolocRow> createState() => _PickGeolocRowState();
}

class _PickGeolocRowState extends State<PickGeolocRow> {
  Position? pos;
  bool isLocPicked = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ContainerIconText(
              title: "موقعي الحالي",
              icon: Icons.my_location,
              onTap: () async {
                // print(pos);
                myDialog("يتم الان تحديد موقعك , الرجاء الانتظار");
                pos = await determinePosition();
                Get.back();
                if (pos != null) {
                  setState(() {
                    isLocPicked = true;
                    widget.func(GeoPoint(pos!.latitude, pos!.longitude));
                  });
                }
              },
            ),
            Text(
              "او",
              style: TextStyle(
                  fontSize: 18, color: kTextColor, fontWeight: FontWeight.bold),
            ),
            ContainerIconText(
              title: "حدد من الخريطة",
              icon: Icons.map,
              onTap: () {
                Get.to(PickFromMap(
                  organisation: !widget.isPerson,
                ))!
                    .then((value) {
                  if (value != null) {
                    setState(() {
                      isLocPicked = value;
                    });
                  } else {
                    setState(() {
                      isLocPicked = false;
                    });
                  }
                });
              },
            ),
          ],
        ),
        displayMsg(isLocPicked),
      ],
    );
  }

  Row displayMsg(bool success) {
    String msg = success ? "تم تحديد الموقع بنجاح" : "لم يتم تحديد الموقع بعد";
    Color color = success ? Colors.green : kSecondaryColor;
    return Row(
      children: [
        Text(
          msg,
          style: TextStyle(
            color: color,
          ),
        ),
        Icon(
          success ? Icons.check_rounded : Icons.close,
          color: color,
        ),
        if (success)
          GestureDetector(
            onTap: () {
              setState(() {
                isLocPicked = false;
                pos = null;
                widget.func(GeoPoint(0, 0));
              });
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Text(
                "حذف",
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
