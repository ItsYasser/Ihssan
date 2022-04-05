import 'package:flutter/material.dart';

import '../Util/constants.dart';
import '../View/add_org.dart';

class CheckBoxItem extends StatefulWidget {
  final String text, hintText;
  final Function(bool val) value;
  CheckBoxItem(
      {Key? key, required this.text, required this.value, this.hintText = ""})
      : super(key: key);
  bool others = false;
  CheckBoxItem.others(
      {Key? key, required this.text, required this.value, this.hintText = ""})
      : super(key: key) {
    others = true;
  }
  @override
  State<CheckBoxItem> createState() => _CheckBoxItemState();
}

class _CheckBoxItemState extends State<CheckBoxItem> {
  bool isChecked = false;
  get others => widget.others;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Checkbox(
              visualDensity: VisualDensity.compact,
              value: isChecked,
              onChanged: (bool? val) {
                setState(() {
                  isChecked = val!;
                });
                widget.value(val!);
              },
              checkColor: Colors.white,
              side: BorderSide(
                width: 2,
                color: kPrimaryColor,
              ),
              fillColor: MaterialStateProperty.all(kSecondaryColor),
              shape: RoundedRectangleBorder(),
            ),
            Text(
              widget.text,
              style: TextStyle(fontSize: 16, color: kTextColor),
            ),
          ],
        ),
        if (others && isChecked)
          CustomField(
            hint: widget.hintText,
            onSaved: (val) {},
          ),
      ],
    );
  }
}
