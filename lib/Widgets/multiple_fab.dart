import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../Util/constants.dart';
import '../View/add_contributor.dart';
import '../View/add_org.dart';

class MultipleFab extends StatelessWidget {
  bool _dialVisible = true;
  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      animatedIcon: AnimatedIcons.add_event,
      animatedIconTheme: const IconThemeData(size: 22.0),
      visible: _dialVisible,
      curve: Curves.bounceIn,
      overlayColor: Colors.black,
      overlayOpacity: 0.5,
      tooltip: 'Speed Dial',
      heroTag: 'speed-dial-hero-tag',
      backgroundColor: kPrimaryColor,
      foregroundColor: Colors.white,
      elevation: 8.0,
      shape: const CircleBorder(),
      children: [
        SpeedDialChild(
            child: SvgPicture.asset(
              "assets/images/charity.svg",
              width: 25,
              height: 25,
            ),
            backgroundColor: Colors.white,
            label: 'اضافة جمعية    ',
            labelStyle:
                Theme.of(context).textTheme.bodyText2?.copyWith(fontSize: 18.0),
            onTap: () {
              Get.to(() => AddOrg());
            }),
        SpeedDialChild(
            child: SvgPicture.asset(
              "assets/images/contributor.svg",
              width: 25,
              height: 25,
            ),
            backgroundColor: Colors.white,
            label: "تطوع او تبرع",
            labelStyle:
                Theme.of(context).textTheme.bodyText2?.copyWith(fontSize: 18.0),
            onTap: () {
              Get.to(() => AddContributor());
            }),
      ],
    );
  }
}
