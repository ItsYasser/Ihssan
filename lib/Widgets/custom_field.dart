import 'package:flutter/material.dart';

import '../Util/constants.dart';

class CustomField extends StatelessWidget {
  final String hint;
  final Function(String?) onSaved;
  final int? maxLines;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  const CustomField({
    Key? key,
    this.hint = "",
    required this.onSaved,
    this.maxLines = 1,
    this.keyboardType = TextInputType.text,
    this.validator,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 7),
      child: TextFormField(
        onSaved: onSaved,
        maxLines: maxLines,
        keyboardType: keyboardType,
        validator: validator ??
            (value) {
              if (value!.isEmpty) {
                return "الرجاء ملئ الخانة";
              }
              if (keyboardType == TextInputType.number ||
                  keyboardType == TextInputType.phone) {
                if (int.tryParse(value) == null) {
                  return "الرجاء التحقق من صيغة رقم الهاتف";
                } else {
                  if (value.length != 10) {
                    return "الرجاء التحقق من صيغة رقم الهاتف";
                  }
                }
              }
              return null;
            },
        decoration: InputDecoration(
          contentPadding:
              new EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          fillColor: Colors.white70,
          filled: true,
          hintText: hint,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: kPrimaryColor),
            borderRadius: BorderRadius.all(
              Radius.circular(kRadius),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: kSecondaryColor),
            borderRadius: BorderRadius.all(
              Radius.circular(kRadius - 5),
            ),
          ),
        ),
      ),
    );
  }
}
