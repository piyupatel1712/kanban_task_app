import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommonTextfield extends StatelessWidget {

  final TextEditingController? controller;
  final String labelText;
  final int? limitOfText;

    const CommonTextfield({Key? key,
     required this.controller,
     required this.labelText,
      this.limitOfText,
   }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLength: limitOfText,
      maxLengthEnforcement: MaxLengthEnforcement.enforced,
      magnifierConfiguration: TextMagnifierConfiguration.disabled,
      style: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w500,
        fontSize: 18.sp
      ),
      controller: controller,
      decoration: InputDecoration(
        labelStyle: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w500
        ),
        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
          isDense: true,
          border: const OutlineInputBorder(),
          labelText: labelText),
    );
  }
}
