import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_festival/Util/constants.dart';
import 'package:get/get.dart';
import 'dart:ui' as ui;

import 'package:url_launcher/url_launcher.dart';

Future<dynamic> circularDialog() {
  return Get.dialog(
    const Center(
      child: CircularProgressIndicator(),
    ),
    barrierDismissible: false,
  );
}

bool containsAny(List<dynamic>? list1, List<dynamic>? list2) {
  bool found = false;
  list1?.forEach((element) {
    if (list2!.contains(element)) {
      found = true;
    }
  });
  return found;
}

class CustomPageRoute<T> extends PageRoute<T> {
  CustomPageRoute(this.child);
  @override
  // TODO: implement barrierColor
  Color get barrierColor => Colors.black;

  @override
  Null get barrierLabel => null;

  final Widget child;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => Duration(milliseconds: 500);
}

void phone_call(String phone) async => await launch("tel://$phone");
Future<dynamic> myDialog(String title) {
  return Get.dialog(
    Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.all(10),
        child: Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            height: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: kPrimaryColor.withOpacity(.4),
                    blurRadius: 8,
                    spreadRadius: 5)
              ],
            ),
            padding: EdgeInsets.fromLTRB(10, 10, 20, 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                CircularProgressIndicator(),
              ],
            ))),
    barrierDismissible: false,
  );
}

Future<Uint8List> getBytesFromAsset(String path, int width) async {
  ByteData data = await rootBundle.load(path);
  ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
      targetWidth: width);
  ui.FrameInfo fi = await codec.getNextFrame();
  return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
      .buffer
      .asUint8List();
}

SnackbarController snackBar(
    {String? title,
    String? message,
    Color titleColor = Colors.red,
    SnackPosition snackPosition = SnackPosition.BOTTOM}) {
  return Get.snackbar("", '',
      backgroundColor: kDarkColor.withOpacity(.9),
      borderRadius: kRadius,
      titleText: Text(
        title!,
        textAlign: TextAlign.center,
        style: TextStyle(color: titleColor, fontSize: 18),
      ),
      messageText: Text(
        message!,
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.white, fontSize: 16),
      ),
      snackPosition: snackPosition,
      colorText: Colors.black,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10));
}
