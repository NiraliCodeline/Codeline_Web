import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../constant/colors.dart';

///abcd
class CommonButton extends StatefulWidget {
  CommonButton({Key? key, this.onPressed, this.child, this.height, this.width})
      : super(key: key);

  final onPressed;
  final child;
  final height;
  final width;

  @override
  State<CommonButton> createState() => _CommonButtonState();
}

class _CommonButtonState extends State<CommonButton> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return MaterialButton(
      onPressed: widget.onPressed,
      height: widget.height,
      minWidth: widget.width,
      color: AppColor.primaryColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.sp)),
      child: widget.child,
    );
  }
}
