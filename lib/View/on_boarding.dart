// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_festival/Util/constants.dart';
import 'package:flutter_festival/main.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'choice_screen.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({Key? key}) : super(key: key);

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  PageController pageController = PageController(initialPage: 0);
  int currentPage = 0;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      constraints: BoxConstraints.expand(),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/background.jpg"),
        ),
      ),
      alignment: Alignment.center,
      padding: EdgeInsets.fromLTRB(
          size.width * 0.05, 0, size.width * 0.05, size.height * 0.05),
      child: Column(
        children: [
          Expanded(
            child: PageView(
              controller: pageController,
              // physics: NeverScrollableScrollPhysics(),
              children: [
                Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //TODO: fontweight bold or regular ?
                    Text(
                      "متطوع او متبرع",
                      style: Theme.of(context).textTheme.headline4?.copyWith(
                            color: kPrimaryColor,
                          ),
                    ),
                    SvgPicture.asset(
                      "assets/images/illustration2.svg",
                      height: size.height * 0.40,
                    ),

                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                          style: DefaultTextStyle.of(context).style.copyWith(
                              fontSize: 15, color: kPrimaryColor, height: 2),
                          children: <TextSpan>[
                            TextSpan(text: "بدخولك كشخص متطوع او متبرع يمكنك "),
                            TextSpan(
                              text: "رسم البهجة",
                              style: TextStyle(
                                  fontSize: 15,
                                  color: kSecondaryColor,
                                  height: 2),
                            ),
                            TextSpan(
                              text:
                                  "\nفي وجوه الكثير من المحتاجين من خلال صدقتك التي تضيفها\nعلى الخريطة و تتكفل الجمعيات الخيرية بايصالها لهم ",
                            ),
                            TextSpan(
                              text: "\nساهم في صنع البسمة",
                              style: TextStyle(
                                  fontSize: 15,
                                  color: kSecondaryColor,
                                  height: 2),
                            ),
                          ]),
                    ),
                  ],
                ),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //TODO: fontweight bold or regular ?
                    Text(
                      "الجمعيات الخيرية",
                      style: Theme.of(context).textTheme.headline4?.copyWith(
                            color: kPrimaryColor,
                          ),
                    ),
                    SvgPicture.asset(
                      "assets/images/illustration1.svg",
                      height: size.height * 0.40,
                    ),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                          style: DefaultTextStyle.of(context).style.copyWith(
                              fontSize: 15, color: kPrimaryColor, height: 2),
                          children: <TextSpan>[
                            TextSpan(text: "سجل دخولك "),
                            TextSpan(
                              text: "كجمعية خيرية ",
                              style: TextStyle(
                                  fontSize: 15,
                                  color: kSecondaryColor,
                                  height: 2),
                            ),
                            TextSpan(
                                text:
                                    "و تمكن من معرفة\nالأشخاص المتطوعين و المتبرعين اللذين يمكنهم مساعدة\nالفقراء و المحتاجين عن"),
                            TextSpan(
                              text: " طريق جمعيتكم",
                              style: TextStyle(
                                  fontSize: 15,
                                  color: kSecondaryColor,
                                  height: 2),
                            ),
                          ]),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              GestureDetector(
                onTap: () {
                  if (currentPage == 1) {
                    Get.to(() => ChoiceScreen());
                  } else {
                    currentPage = 1;
                    pageController.nextPage(
                        duration: Duration(seconds: 1), curve: Curves.ease);
                    setState(() {});
                  }
                },
                child: Text(
                  "التالي",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: kPrimaryColor,
                  ),
                ),
              ),
              Spacer(),
              dots(currentPage == 0),
              dots(currentPage == 1),
              Spacer(),
              if (currentPage != 0)
                GestureDetector(
                    onTap: () {
                      currentPage = 0;
                      pageController.previousPage(
                          duration: Duration(seconds: 1), curve: Curves.ease);
                      setState(() {});
                    },
                    child: Text(
                      "رجوع",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: kPrimaryColor,
                      ),
                    )),
            ],
          )
        ],
      ),
    );
  }

  Widget dots(bool selected) {
    print(selected);
    return AnimatedContainer(
      duration: Duration(seconds: 1),
      margin: const EdgeInsets.symmetric(horizontal: 5),
      height: 10,
      width: selected ? 30 : 10,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: selected ? kPrimaryColor : Colors.white,
        border: Border.all(),
      ),
    );
  }
}
