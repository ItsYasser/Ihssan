import 'package:flutter/material.dart';
import 'package:flutter_festival/Util/constants.dart';
import 'package:flutter_festival/View/map_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

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
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: size.height * 0.13,
            ),
            child: Align(
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Spacer(
                    flex: 3,
                  ),
                  Text(
                    "كيف يمكنك المساعدة ؟",
                    style: Theme.of(context)
                        .textTheme
                        .headline4
                        ?.copyWith(color: kPrimaryColor),
                  ),
                  Text(
                    "يمكنك الانضمام الينا و مساعدة المحتاجين سواء كشخص\nمتبرع و متطوع او كجمعية خيرية",
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xff26316A),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    '"إنْ أردتَ أنْ يَلينَ قلبُكَ، فأطعِمْ المسكينَ، وامسحْ رأسَ اليتيمِ"',
                    style: TextStyle(
                      fontSize: 16,
                      color: kSecondaryColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Spacer(),
                  Row(
                    children: [
                      ChoiceContainer(
                        imagePath: "assets/images/contributor.svg",
                        title: "متبرع-متطوع",
                        onTap: () {
                          Get.to(() => MapScreen(
                                choice: "المتبرعين و المتطوعين",
                              ));
                        },
                      ),
                      ChoiceContainer(
                        imagePath: "assets/images/charity.svg",
                        title: "جمعية خيرية",
                        onTap: () {
                          Get.to(() => MapScreen(
                                choice: "الجمعيات الخيرية",
                              ));
                        },
                      ),
                    ],
                  ),
                  Spacer(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ChoiceContainer extends StatelessWidget {
  final String title, imagePath;
  final Function() onTap;
  const ChoiceContainer(
      {Key? key,
      required this.title,
      required this.imagePath,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: size.height * 0.22,
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(.3),
                    blurRadius: 5,
                    spreadRadius: .5)
              ]),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SvgPicture.asset(
                  imagePath,
                ),
                Text(
                  title,
                  style: TextStyle(
                      fontSize: 15,
                      color: kPrimaryColor,
                      fontWeight: FontWeight.w700),
                )
              ]),
        ),
      ),
    );
  }
}
