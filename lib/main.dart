import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_festival/Util/constants.dart';
import 'package:flutter_festival/View/add_contributor.dart';

import 'package:flutter_festival/View/add_org.dart';
import 'package:flutter_festival/View/background.dart';
import 'package:flutter_festival/View/choice_screen.dart';
import 'package:flutter_festival/View/contributor_details.dart';
import 'package:flutter_festival/View/map_screen.dart';
import 'package:flutter_festival/View/org_detals.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'View/on_boarding.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //  SystemChrome.setSystemUIOverlayStyle(
    //       SystemUiOverlayStyle(statusBarColor: Colors.blue));
    return GetMaterialApp(
        title: 'Flutter Festival',
        home: HomePage(),
        theme: ThemeData(
          splashColor: kPrimaryColor,
          primaryColor: kPrimaryColor,
          fontFamily: GoogleFonts.cairo().fontFamily,
        ));
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: MapScreen(),
    );
  }
}
