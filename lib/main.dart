import 'package:flutter/material.dart';
import 'package:flutter_festival/Util/constants.dart';
import 'package:flutter_festival/View/OnBoarding/intro_slider_screen.dart';
import 'package:flutter_festival/View/background.dart';
import 'package:flutter_svg/svg.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //  SystemChrome.setSystemUIOverlayStyle(
    //       SystemUiOverlayStyle(statusBarColor: Colors.blue));
    return MaterialApp(
      title: 'Flutter Festival',
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: ChoiceScreen(),
    );
  }
}

class ChoiceScreen extends StatelessWidget {
  const ChoiceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Opacity(
          opacity: 0.1,
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
                Text(
                  "كيف يمكنك المساعدة ؟",
                  style: TextStyle(color: kPrimaryColor, fontSize: 26),
                ),
                Text(
                  "Lurem ipsum lurem ipsumLurem ipsum lurem ipsumLurem ipsum lurem ipsumLurem ipsum lurem ipsumLurem ipsum lurem ipsumLurem ipsum lurem ipsum",
                  textAlign: TextAlign.center,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: size.height * 0.2,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.red,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.withOpacity(.5),
                                  blurRadius: 2,
                                  spreadRadius: 1)
                            ]),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: size.height * 0.2,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.blue,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.withOpacity(.5),
                                  blurRadius: 2,
                                  spreadRadius: 1)
                            ]),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
