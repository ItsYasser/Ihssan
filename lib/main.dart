import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_festival/Util/constants.dart';
import 'package:flutter_festival/View/splash.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'View/on_boarding.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Ihssan',
        debugShowCheckedModeBanner: false,
        home: const HomePage(),
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
      body: FutureBuilder<void>(
          future: Future.delayed(const Duration(seconds: 7)),
          builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return const Splash();
              default:
                if (snapshot.hasError)
                  return Text('Error: ${snapshot.error}');
                else
                  return const OnBoarding();
            }
          }),
    );
  }
}
