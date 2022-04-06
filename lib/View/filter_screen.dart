import 'package:flutter/material.dart';
import 'package:flutter_festival/Controller/filter_controller.dart';
import 'package:flutter_festival/Widgets/button_widget.dart';
import 'package:get/get.dart';

import '../Util/constants.dart';
import '../Widgets/help_type.dart';

class FilterScreen extends StatelessWidget {
  FilterController filter = Get.find<FilterController>();

  FilterScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Button(
        margin: const EdgeInsets.all(10),
        onTap: () {
          filter.update();
          Get.back();
        },
        text: "اظهار النتائج",
      ),
      backgroundColor: Colors.white,
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 25, 12, 0),
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: const [
                Text(
                  "نوع المساعدة",
                  style: TextStyle(
                    fontSize: 16,
                    color: kPrimaryColor,
                    height: 1,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                HelpType(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
