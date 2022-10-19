import 'package:codeline_info_responsive_ui/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class AppProgressLoader extends StatelessWidget {
  const AppProgressLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: LoadingAnimationWidget.threeArchedCircle(
      color: AppColor.primaryColor,
      size: 40,
    ));
  }
}
