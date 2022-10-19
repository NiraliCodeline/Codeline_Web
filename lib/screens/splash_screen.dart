import 'package:codeline_info_responsive_ui/constant/colors.dart';
import 'package:codeline_info_responsive_ui/repo/loginRepo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sizer/sizer.dart';
import '../controllers/get_dashboard_details_controller.dart';
import '../controllers/internet_connectivity_controller.dart';

//String? bearerToken;
String? bearerToken =
    "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VySWQiOiI0IiwidXNlcm5hbWUiOiJtYWxhbmluaWtzQGdtYWlsLmNvbSIsInVzZXJUeXBlIjoiYWRtaW4ifQ.R6dHZTsnrH2x3hgWDFJUlo0cGF6IiBvUFAaVflj2ljo";

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  AnimationController? animationController;
  Animation<double>? animation;

  GetDashboardDetailsController getDashboardDetailsController =
      Get.put(GetDashboardDetailsController());

  ConnectivityProvider connectivityController = Get.put(ConnectivityProvider());

  @override
  void initState() {
    super.initState();
    connectivityController.startMonitoring();
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 3));
    animation = Tween(begin: 0.0, end: 1.0).animate(animationController!);
    animationController?.forward();

    var tokenRead = GetStorage().read('token');

    print("Read Token-----------${tokenRead}");

    if (tokenRead == null) {
      Future.delayed(Duration(seconds: 3), () {
        // Get.offAll(LogInScreen());
        bearerToken = token;
      });
    } else {
      bearerToken = "Bearer ${tokenRead}";
      print("SplashBearerToken---------${bearerToken}");
      getDashboardDetailsController.fetchAllDashboardDetails().then((value) {
        //Get.offAll(HomeScreen());
      });
    }

    /*Future<dynamic>.delayed(Duration(seconds: 3), () {
      var token = GetStorage().read('token');
      if (token == null) {
        Get.offAll(LogInScreen());
      } else {
        getDashboardDetailsController.fetchAllDashboardDetails().then((value) {
          Get.offAll(HomeScreen());
        });
      }

      token == null ? Get.offAll(LogInScreen()) : Get.offAll(HomeScreen());
    });*/

    /*getDashboardDetailsController.fetchAllDashboardDetails().then((value) {
      var token = GetStorage().read('token');
      token == null ? Get.offAll(LogInScreen()) : Get.offAll(HomeScreen());
      print("TOKEN--------------${token}");
    });*/
  }

  @override
  void dispose() {
    // TODO: implement dispose
    animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: Get.height * 0.27.sp,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.06.sp),
            child: FadeTransition(
              opacity: animation!,
              child: Container(
                height: 190.sp,
                width: Get.width.sp,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/CodelineSpalsh.png"),
                        fit: BoxFit.fill)),
                /*child: SvgPicture.asset(
                  "assets/images/SplashScreen_Icon.svg",
                  fit: BoxFit.fill,
                ),*/
              ),
            ),
          ),
          SizedBox(height: Get.height * 0.17.sp),
          Text(
            "Welcome to Codeline Management",
            style: TextStyle(
                fontFamily: 'Inter',
                color: AppColor.greyColor,
                fontWeight: FontWeight.w500,
                fontSize: 15.sp),
          ),
          SizedBox(height: Get.height * 0.015.sp),
          Text(
            "@Copyright 2022",
            style: TextStyle(
                color: AppColor.blackColor,
                fontWeight: FontWeight.w700,
                fontFamily: 'Inter',
                fontSize: 19.sp),
          ),
        ],
      ),
    );
  }
}
