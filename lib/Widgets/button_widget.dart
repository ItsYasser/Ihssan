// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../Util/constants.dart';

class Button extends StatelessWidget {
  final Function() onTap;
  final String text;
  final Color backGroundColor, textColor, borderColor;
  final Alignment? textAlign;
  final double borderRadius;
  final EdgeInsets margin;
  const Button({
    Key? key,
    required this.onTap,
    required this.text,
    this.backGroundColor = kSecondaryColor,
    this.textColor = Colors.white,
    this.borderColor = Colors.transparent,
    this.textAlign,
    this.borderRadius = 7,
    this.margin = const EdgeInsets.all(0),
  }) : super(key: key);
  const Button.outlined(
      {Key? key,
      required this.onTap,
      required this.text,
      this.backGroundColor = Colors.white,
      this.textColor = kPrimaryColor,
      this.borderColor = kPrimaryColor,
      this.textAlign,
      this.borderRadius = 7,
      this.margin = const EdgeInsets.all(0)})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 13,
        ),
        alignment: textAlign,
        margin: margin,
        width: double.infinity,
        decoration: BoxDecoration(
          color: backGroundColor,
          borderRadius: BorderRadius.circular(
            borderRadius,
          ),
          border: Border.all(color: borderColor),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(.5),
              offset: const Offset(0, 0),
              spreadRadius: 2,
              blurRadius: 3,
            )
          ],
        ),
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
