import 'package:flutter/material.dart';
import 'package:flutter_festival/Util/constants.dart';
import 'package:get/get.dart';

Future<dynamic> circularDialog() {
  return Get.dialog(
    const Center(
      child: CircularProgressIndicator(),
    ),
    barrierDismissible: false,
  );
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
