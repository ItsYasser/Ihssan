// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';

import 'package:get/get_utils/src/extensions/internacionalization.dart';

import '../../Util/constants.dart';

class CustomTextField extends StatelessWidget {
  final ValueChanged<String?>? onSaved;

  // ignore: use_key_in_widget_constructors
  // const CustomTextField({required this.onSaved});
  // final TextEditingController controller = TextEditingController();
  final String label;
  final IconData? icon;
  final bool hiddenText;
  final TextInputType? keyboardType;
  final double? iconSize;
  final Function(String?)? validator;
  final String? initialValue;

  final bool readOnly;

  final TextEditingController? controller;
  CustomTextField({
    Key? key,
    required this.label,
    this.icon,
    this.hiddenText = false,
    this.keyboardType = TextInputType.text,
    this.iconSize = 24.0,
    this.onSaved,
    this.validator,
    this.initialValue,
    this.controller,
    this.readOnly = false,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        textAlignVertical: TextAlignVertical.center,
        keyboardType: keyboardType,
        maxLines: 1,
        readOnly: readOnly,
        // validator: validator ??
        //     (value) {
        //       if (value?.isEmpty) {
        //         return "Must not be empty !".tr;
        //       }
        //       if (keyboardType == TextInputType.number ||
        //           keyboardType == TextInputType.phone) {
        //         if (int.tryParse(value) == null) {
        //           //TODO: translate it (add it to dicto)
        //           return "Must be a phone number".tr;
        //         }
        //       }
        //       return null;
        //     },
        initialValue: initialValue,
        controller: controller,
        onSaved: onSaved,
        obscureText: hiddenText,
        decoration: InputDecoration(
          fillColor: kTextFieldColor,
          errorMaxLines: 2,
          filled: true,
          prefixIcon: Icon(
            icon,
            color: kTextFieldTextColor,
            size: iconSize,
          ),
          label: Text(
            label,
            style: TextStyle(color: kTextFieldTextColor),
          ),
          border:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.all(Radius.circular(kRadius)),
          ),
        ),

        // onSaved: onSaved,
      ),
    );
  }
}
