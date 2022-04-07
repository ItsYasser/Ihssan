import 'package:flutter/material.dart';
import 'package:flutter_festival/Util/constants.dart';
import 'package:flutter_festival/View/map_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../Widgets/choice_container.dart';

class ChoiceScreen extends StatelessWidget {
  const ChoiceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Opacity(
            opacity: 0.07,
            child: SvgPicture.asset(
              "assets/images/background.svg",
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 0,
            right: size.width * 0.035,
            child: SvgPicture.asset(
              "assets/images/blueLantern.svg",
              height: size.height * 0.3,
            ),
          ),
          Padding(
            padding:
                EdgeInsets.only(top: size.height * 0.13, right: 10, left: 10),
            child: Align(
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Spacer(
                    flex: 3,
                  ),
                  Text(
                    "كيف يمكنك المساعدة ؟",
                    style: Theme.of(context)
                        .textTheme
                        .headline4
                        ?.copyWith(color: kPrimaryColor, height: 1.5),
                    textAlign: TextAlign.center,
                  ),
                  const Text(
                    "يمكنك الانضمام الينا و مساعدة المحتاجين سواء كشخص\nمتبرع و متطوع او كجمعية خيرية",
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xff26316A),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const Text(
                    '"إنْ أردتَ أنْ يَلينَ قلبُكَ، فأطعِمْ المسكينَ، وامسحْ رأسَ اليتيمِ"',
                    style: TextStyle(
                      fontSize: 16,
                      color: kSecondaryColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      ChoiceContainer(
                        imagePath: "assets/images/contributor.svg",
                        title: "متبرع-متطوع",
                        onTap: () {
                          Get.to(() => const MapScreen(
                                choice: "الجمعيات الخيرية",
                              ));
                        },
                      ),
                      ChoiceContainer(
                        imagePath: "assets/images/charity.svg",
                        title: "جمعية خيرية",
                        onTap: () {
                          Get.to(() => const MapScreen(
                                choice: "المتبرعين و المتطوعين",
                              ));
                        },
                      ),
                    ],
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
