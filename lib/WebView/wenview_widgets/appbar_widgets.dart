import 'package:codeline_info_responsive_ui/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        leading: Padding(
            padding: EdgeInsets.only(
                left: Get.width * 0.04,
                top: Get.height * 0.02,
                bottom: Get.height * 0.02),
            child: Image(
              image: AssetImage("assets/images/Dashboard icon.png"),
              fit: BoxFit.fill,
            )),
        toolbarHeight: Get.height * 0.3,
        leadingWidth: Get.width * 0.15,
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            Color(0xff232C42),
            Color(0xff24425F),
          ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
        ),
        actions: [
          TextButton(
              onPressed: () {},
              child: Text(
                "Dashboard",
                style: TextStyle(
                  color: AppColor.whiteColor,
                  fontSize: Get.height * 0.018,
                  fontWeight: FontWeight.w400,
                  fontFamily: "Inter",
                ),
              )),
          TextButton(
              onPressed: () {},
              child: Text(
                "Student List",
                style: TextStyle(
                  color: AppColor.whiteColor,
                  fontSize: Get.height * 0.018,
                  fontWeight: FontWeight.w400,
                  fontFamily: "Inter",
                ),
              )),
          TextButton(
              onPressed: () {},
              child: Text(
                "Inquiry List",
                style: TextStyle(
                  color: AppColor.whiteColor,
                  fontSize: Get.height * 0.018,
                  fontWeight: FontWeight.w400,
                  fontFamily: "Inter",
                ),
              )),
          TextButton(
              onPressed: () {},
              child: Text(
                "favourite student",
                style: TextStyle(
                  color: AppColor.whiteColor,
                  fontSize: Get.height * 0.018,
                  fontWeight: FontWeight.w400,
                  fontFamily: "Inter",
                ),
              )),
          TextButton(
              onPressed: () {},
              child: Text(
                "Current Demo List",
                style: TextStyle(
                  color: AppColor.whiteColor,
                  fontSize: Get.height * 0.018,
                  fontWeight: FontWeight.w400,
                  fontFamily: "Inter",
                ),
              )),
          Padding(
            padding: EdgeInsets.only(
                left: Get.width * 0.01,
                right: Get.width * 0.03,
                top: Get.height * 0.03,
                bottom: Get.height * 0.03),
            child: MaterialButton(
              onPressed: () {},
              height: Get.height * 0.05,
              minWidth: Get.width * 0.08,
              color: AppColor.primaryColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Get.height * 0.010)),
              child: Text(
                "Logout",
                style: TextStyle(
                  color: AppColor.whiteColor,
                  fontSize: Get.height * 0.018,
                  fontWeight: FontWeight.w600,
                  fontFamily: "Inter",
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
