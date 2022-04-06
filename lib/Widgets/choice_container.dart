import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../Util/constants.dart';

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
                  style: const TextStyle(
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
