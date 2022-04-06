import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../Util/constants.dart';

class SliderItem extends StatelessWidget {
  final String title, imagePath;
  final Widget description;

  const SliderItem(
      {Key? key,
      required this.title,
      required this.imagePath,
      required this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
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
          imagePath,
          height: size.height * 0.40,
        ),
        description
      ],
    );
  }
}
