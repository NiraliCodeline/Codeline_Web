import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../constant/colors.dart';

class Common_TextFormFeild extends StatefulWidget {
  Common_TextFormFeild(
      {Key? key,
      this.controller,
      this.validator,
      this.labelText,
      required this.obscure,
      this.prefixIcon,
      this.keyboardType})
      : super(key: key);

  final controller;
  final String? Function(String?)? validator;
  final labelText;
  final bool obscure;
  final prefixIcon;
  final keyboardType;

  @override
  State<Common_TextFormFeild> createState() => _Common_TextFormFeildState();
}

class _Common_TextFormFeildState extends State<Common_TextFormFeild> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      child: TextFormField(
        obscureText: widget.obscure,
        controller: widget.controller,
        validator: widget.validator,
        keyboardType: widget.keyboardType,
        decoration: InputDecoration(
          prefixIcon: widget.prefixIcon,
          contentPadding:
              EdgeInsets.symmetric(vertical: 19.0.sp, horizontal: 11.0.sp),
          labelText: widget.labelText,
          labelStyle: TextStyle(
              color: AppColor.secondaryColor,
              fontSize: 14.sp,
              fontFamily: "Inter",
              fontWeight: FontWeight.w500),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColor.greyColor),
            borderRadius: BorderRadius.circular(10.0.sp),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: AppColor.greyColor),
            borderRadius: BorderRadius.circular(10.0.sp),
          ),
        ),
      ),
    );
  }
}
