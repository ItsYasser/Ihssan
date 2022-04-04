import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';

import '../../Util/constants.dart';

class IntroSliderScreen extends StatefulWidget {
  IntroSliderScreen();

  @override
  _IntroSliderScreenState createState() => _IntroSliderScreenState();
}

class _IntroSliderScreenState extends State<IntroSliderScreen> {
  Widget buttonStyle(String text) => Text(
        text,
        style: Theme.of(context)
            .textTheme
            .headline1
            ?.copyWith(fontSize: 18, color: kPrimaryColor),
      );

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return IntroSlider(
      colorActiveDot: kPrimaryColor,
      colorDot: kPrimaryColor,
      renderNextBtn: buttonStyle("Next"),
      renderDoneBtn: buttonStyle("Done"),
      renderPrevBtn: buttonStyle("Back"),
      renderSkipBtn: buttonStyle("Skip"),
      slides: [
        Slide(
          backgroundColor: Colors.transparent,
          title: "Quick and Easy",
          styleTitle:
              Theme.of(context).textTheme.headline1?.copyWith(fontSize: 35),
          centerWidget: SvgPicture.asset(
            "assets/images/illustration1.svg",
            height: size.height * 0.30,
          ),
          description:
              'Deliver your packages in style and on time,with speed and simplicity!',
          styleDescription: Theme.of(context)
              .textTheme
              .headline1
              ?.copyWith(fontSize: 20, color: kPrimaryColor),
        ),
        Slide(
          backgroundColor: Colors.white,
          title: "We Deliver,You Track",
          backgroundImage: "assets/images/bg.png",
          styleTitle:
              Theme.of(context).textTheme.headline1?.copyWith(fontSize: 35),
          centerWidget: SvgPicture.asset(
            "assets/images/illustration2.svg",
            height: size.height * 0.30,
          ),
          description:
              'Make your order and track your package from the start into your hands',
          styleDescription: Theme.of(context)
              .textTheme
              .headline1
              ?.copyWith(fontSize: 20, color: kPrimaryColor),
        ),
      ],
      onDonePress: () {
        //todo implement Navigation to main screen
      },
    );
  }
}
