import 'package:codeline_info_responsive_ui/constant/colors.dart';
import 'package:codeline_info_responsive_ui/constant/progress_indicator.dart';
import 'package:codeline_info_responsive_ui/controllers/get_dashboard_details_controller.dart';
import 'package:codeline_info_responsive_ui/controllers/internet_connectivity_controller.dart';
import 'package:codeline_info_responsive_ui/screens/allview/allview_allstudentlist_screen.dart';
import 'package:countup/countup.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sizer/sizer.dart';

class MobileViewHomeScreen extends StatefulWidget {
  const MobileViewHomeScreen({Key? key}) : super(key: key);

  @override
  State<MobileViewHomeScreen> createState() => _MobileViewHomeScreenState();
}

GetDashboardDetailsController getDashboardDetailsController =
    Get.put(GetDashboardDetailsController());

ConnectivityProvider connectivityController = Get.put(ConnectivityProvider());

RxBool isLoading = false.obs;

class _MobileViewHomeScreenState extends State<MobileViewHomeScreen> {
  @override
  void initState() {
    super.initState();
    connectivityController.startMonitoring();
    getDashboardDetailsController.fetchAllDashboardDetails();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ConnectivityProvider>(
      builder: (controller) {
        return controller.isOnline
            ? Scaffold(
                resizeToAvoidBottomInset: true,
                backgroundColor: AppColor.backgroundColor,
                appBar: AppBar(
                  elevation: 0.0,
                  backgroundColor: AppColor.backgroundColor,
                  iconTheme: IconThemeData(color: AppColor.blackColor),
                ),
                drawer: MyDrawer(),
                body: GetBuilder<GetDashboardDetailsController>(
                  builder: (controller) {
                    return Stack(
                      children: [
                        SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Center(
                                child: SvgPicture.asset(
                                  "assets/images/SplashScreen_Icon.svg",
                                  fit: BoxFit.fill,
                                  height: 20.h,
                                  width: 20.h,
                                ),
                              ),
                              SizedBox(
                                height: 7.2.h,
                              ),
                              //Spacer(),
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: AppColor.whiteColor,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(40.0.sp),
                                    topRight: Radius.circular(40.0.sp),
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 3.h,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 30.sp),
                                      child: Text(
                                        "Welcome, Admin",
                                        style: TextStyle(
                                          color: AppColor.blackColor,
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: "Inter",
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 3.h,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: 30.sp, right: 30.sp),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  Get.to(AllViewAllStudentListScreen())!
                                                      .then((value) {
                                                    if (value['update'])
                                                      getDashboardDetailsController
                                                          .fetchAllDashboardDetails();

                                                    print("New API calls");
                                                  });
                                                },
                                                child: Container(
                                                  height: 12.h,
                                                  width: 12.h,
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      border: Border.all(
                                                          color: AppColor
                                                              .primaryColor,
                                                          width: 4.2.sp)),
                                                  child: Center(
                                                    child: Image.asset(
                                                      "assets/images/012-girl 1.png",
                                                      fit: BoxFit.fill,
                                                      height: 6.h,
                                                      width: 6.h,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 1.h,
                                              ),
                                              Countup(
                                                begin: 0,
                                                end: getDashboardDetailsController
                                                    .allDashboardDetailsList!
                                                    .totalStudent!
                                                    .toDouble(),
                                                duration: Duration(
                                                    milliseconds: 2500),
                                                separator: ',',
                                                style: TextStyle(
                                                  color: AppColor.blackColor,
                                                  fontSize: 3.5.h,
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: "Inter",
                                                ),
                                              ),
                                              Text(
                                                "Total Student",
                                                style: TextStyle(
                                                  color: Color(0xff868585),
                                                  fontSize: 2.5.h,
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: "Inter",
                                                ),
                                              ),
                                              Text(
                                                "Count",
                                                style: TextStyle(
                                                  color: Color(0xff868585),
                                                  fontSize: 2.5.h,
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: "Inter",
                                                ),
                                              )
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  /*Get.to(InquiryStudentListScreen())!
                                                .then((value) {
                                              if (value['update'])
                                                getDashboardDetailsController
                                                    .fetchAllDashboardDetails();

                                              print("API calls");
                                            });*/
                                                },
                                                child: Container(
                                                  height: 12.h,
                                                  width: 12.h,
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      border: Border.all(
                                                          color: AppColor
                                                              .primaryColor,
                                                          width: 4.2.sp)),
                                                  child: Center(
                                                    child: Image.asset(
                                                      "assets/images/029-survey 1.png",
                                                      fit: BoxFit.fill,
                                                      height: 6.h,
                                                      width: 6.h,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 1.h,
                                              ),
                                              Countup(
                                                begin: 0,
                                                end: getDashboardDetailsController
                                                    .allDashboardDetailsList!
                                                    .totalInquiry!
                                                    .toDouble(),
                                                duration: Duration(
                                                    milliseconds: 2500),
                                                separator: ',',
                                                style: TextStyle(
                                                  color: AppColor.blackColor,
                                                  fontSize: 3.5.h,
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: "Inter",
                                                ),
                                              ),
                                              Text(
                                                "Total Student",
                                                style: TextStyle(
                                                  color: Color(0xff868585),
                                                  fontSize: 2.5.h,
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: "Inter",
                                                ),
                                              ),
                                              Text(
                                                "Inquiry",
                                                style: TextStyle(
                                                  color: Color(0xff868585),
                                                  fontSize: 2.5.h,
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: "Inter",
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 3.h,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: 30.sp, right: 30.sp),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            children: [
                                              Container(
                                                height: 12.h,
                                                width: 12.h,
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    border: Border.all(
                                                        color: AppColor
                                                            .primaryColor,
                                                        width: 4.2.sp)),
                                                child: Center(
                                                  child: Image.asset(
                                                    "assets/images/001-desk 1.png",
                                                    fit: BoxFit.fill,
                                                    height: 6.h,
                                                    width: 6.h,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 1.h,
                                              ),
                                              Countup(
                                                begin: 0,
                                                end: getDashboardDetailsController
                                                    .allDashboardDetailsList!
                                                    .currentDemo!
                                                    .toDouble(),
                                                duration: Duration(
                                                    milliseconds: 2500),
                                                separator: ',',
                                                style: TextStyle(
                                                  color: AppColor.blackColor,
                                                  fontSize: 3.5.h,
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: "Inter",
                                                ),
                                              ),
                                              Text(
                                                "Current Demo",
                                                style: TextStyle(
                                                  color: Color(0xff868585),
                                                  fontSize: 2.5.h,
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: "Inter",
                                                ),
                                              ),
                                              Text(
                                                "Student",
                                                style: TextStyle(
                                                  color: Color(0xff868585),
                                                  fontSize: 2.5.h,
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: "Inter",
                                                ),
                                              )
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              Container(
                                                height: 12.h,
                                                width: 12.h,
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    border: Border.all(
                                                        color: AppColor
                                                            .primaryColor,
                                                        width: 4.2.sp)),
                                                child: Center(
                                                  child: Image.asset(
                                                    "assets/images/026-favourite 1.png",
                                                    fit: BoxFit.fill,
                                                    height: 6.h,
                                                    width: 6.h,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 1.h,
                                              ),
                                              Countup(
                                                begin: 0,
                                                end: getDashboardDetailsController
                                                    .allDashboardDetailsList!
                                                    .completedStudent!
                                                    .toDouble(),
                                                duration: Duration(
                                                    milliseconds: 2500),
                                                separator: ',',
                                                style: TextStyle(
                                                  color: AppColor.blackColor,
                                                  fontSize: 3.5.h,
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: "Inter",
                                                ),
                                              ),
                                              Text(
                                                "Completed",
                                                style: TextStyle(
                                                  color: Color(0xff868585),
                                                  fontSize: 2.5.h,
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: "Inter",
                                                ),
                                              ),
                                              Text(
                                                "Student",
                                                style: TextStyle(
                                                  color: Color(0xff868585),
                                                  fontSize: 2.5.h,
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: "Inter",
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 2.h,
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Obx(() {
                          return isLoading.value
                              ? Container(
                                  color: Colors.white.withOpacity(0.8),
                                  child: Center(
                                    child: AppProgressLoader(),
                                  ),
                                )
                              : SizedBox();
                        })
                      ],
                    );
                  },
                ),
              )
            : Scaffold(
                body: Center(
                  child: Text(
                    "No Internet..",
                    style: TextStyle(
                      color: AppColor.blackColor,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      fontFamily: "Inter",
                    ),
                  ),
                ),
              );
      },
    );
  }
}

final passcodeController = TextEditingController();

class MyDrawer extends StatelessWidget {
  MyDrawer({Key? key}) : super(key: key);

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      child: Drawer(
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            Container(
              height: 200.sp,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xff17A2B8),
                  Color(0xff232C42),
                ],
              )),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20.sp,
                  ),
                  Container(
                    height: 100.sp,
                    width: 100.sp,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border:
                            Border.all(color: AppColor.whiteColor, width: 5.sp),
                        image: DecorationImage(
                            image: AssetImage("assets/images/Ellipse 164.png"),
                            fit: BoxFit.fill)),
                  ),
                  SizedBox(
                    height: 10.sp,
                  ),
                  Text(
                    "Mr. Nevil Vaghasiya",
                    style: TextStyle(
                      color: AppColor.whiteColor,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      fontFamily: "Inter",
                    ),
                  ),
                  SizedBox(
                    height: 3.sp,
                  ),
                  Text(
                    "( Super Admin )",
                    style: TextStyle(
                      color: AppColor.whiteColor,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      fontFamily: "Inter",
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 23.sp,
            ),
            Padding(
              padding: EdgeInsets.only(left: 12.sp),
              child: ListTile(
                onTap: () {
                  Get.back();
                  Get.to(MobileViewHomeScreen());
                },
                leading: Image(
                    image: AssetImage("assets/images/Combo Chart.png"),
                    fit: BoxFit.fill,
                    height: 26.sp,
                    width: 26.sp),
                title: Text(
                  "Dashboard",
                  style: TextStyle(
                    color: AppColor.blackColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    fontFamily: "Inter",
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 25.sp, right: 40.sp),
              child: Divider(
                height: 2,
                color: AppColor.secondaryColor,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 12.sp),
              child: ListTile(
                onTap: () {
                  Get.back();
                  /* Get.to(AllLangStudentList())!.then((value) {
                    if (value['update'])
                      getDashboardDetailsController.fetchAllDashboardDetails();

                    print("New API calls");
                  });*/
                },
                leading: Image(
                    image: AssetImage("assets/images/Graduate_Drawer.png"),
                    fit: BoxFit.fill,
                    height: 26.sp,
                    width: 26.sp),
                title: Text(
                  "Student List",
                  style: TextStyle(
                    color: AppColor.blackColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    fontFamily: "Inter",
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 25.sp, right: 40.sp),
              child: Divider(
                height: 2,
                color: AppColor.secondaryColor,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 12.sp),
              child: ListTile(
                onTap: () {
                  Get.back();
                  /*Get.to(InquiryStudentListScreen())!.then((value) {
                    if (value['update'])
                      getDashboardDetailsController.fetchAllDashboardDetails();

                    print("API calls");
                  });*/
                },
                leading: Image(
                    image: AssetImage("assets/images/Survey.png"),
                    fit: BoxFit.fill,
                    height: 26.sp,
                    width: 26.sp),
                title: Text(
                  "Inquiry List",
                  style: TextStyle(
                    color: AppColor.blackColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    fontFamily: "Inter",
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 25.sp, right: 40.sp),
              child: Divider(
                height: 2,
                color: AppColor.secondaryColor,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 12.sp),
              child: ListTile(
                onTap: () {
                  Get.back();
                  //Get.to(FavouriteScreen());
                },
                leading: Image(
                    image: AssetImage("assets/images/Favorite Database.png"),
                    fit: BoxFit.fill,
                    height: 26.sp,
                    width: 26.sp),
                title: Text(
                  "Favourite Student",
                  style: TextStyle(
                    color: AppColor.blackColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    fontFamily: "Inter",
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 25.sp, right: 40.sp),
              child: Divider(
                height: 2,
                color: AppColor.secondaryColor,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 12.sp),
              child: ListTile(
                onTap: () {
                  /*Get.back();
                  Get.to(DemoLectureScreen());*/
                },
                leading: Image(
                    image: AssetImage("assets/images/Classroom.png"),
                    fit: BoxFit.fill,
                    height: 26.sp,
                    width: 26.sp),
                title: Text(
                  "Current Demo List",
                  style: TextStyle(
                    color: AppColor.blackColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    fontFamily: "Inter",
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 25.sp, right: 40.sp),
              child: Divider(
                height: 2,
                color: AppColor.secondaryColor,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 12.sp),
              child: ListTile(
                onTap: () {
                  Get.back();
                  if (GetStorage().read("role") == "admin") {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return SimpleDialog(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(13.sp)),
                            children: [
                              SizedBox(
                                height: 2.h,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 5.w),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      " Passcode",
                                      style: TextStyle(
                                          color: AppColor.neavyBlueColor,
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: "Inter",
                                          height: 0.8),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 5.w),
                                child: Container(
                                  child: TextFormField(
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(4),
                                    ],
                                    controller: passcodeController,
                                    validator: (value) {
                                      if (value!.length != 4) {
                                        return 'Code must be of 4 digit';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 14.0.sp,
                                          horizontal: 11.0.sp),
                                      hintText: "PASS CODE",
                                      hintStyle: TextStyle(
                                          color: AppColor.secondaryColor,
                                          fontSize: 12.sp,
                                          fontFamily: "Inter",
                                          fontWeight: FontWeight.w500),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: AppColor.greyColor),
                                        borderRadius:
                                            BorderRadius.circular(10.0.sp),
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: AppColor.greyColor),
                                        borderRadius:
                                            BorderRadius.circular(10.0.sp),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 3.h,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 7.w),
                                child: MaterialButton(
                                  height: 6.h,
                                  color: AppColor.primaryColor,
                                  minWidth: double.infinity,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.sp)),
                                  onPressed: () async {
                                    /*FocusScope.of(context)
                                        .requestFocus(new FocusNode());

                                    if (passcodeController.text.trim() != "") {
                                      Get.back();
                                      isLoading.value = true;

                                      var feesRes =
                                      await FeesReportRepo.feesreportRepo(
                                          passcode: passcodeController.text
                                              .trim()
                                              .toString());
                                      if (feesRes['result']) {
                                        print(
                                            "Fees-------------${feesRes["data"]["Report"]["total_fees"]}");

                                        Get.to(FeesScreen(
                                          totalFees: feesRes["data"]["Report"]
                                          ["total_fees"],
                                          totalDepositFees: feesRes["data"]
                                          ["Report"]["total_deposit_fees"],
                                          totalPendingFees: feesRes["data"]
                                          ["Report"]["total_pending_fees"],
                                        ));
                                        isLoading.value = false;
                                        passcodeController.clear();
                                      } else {
                                        isLoading.value = false;
                                        Get.snackbar(
                                          "Error",
                                          'This Passcode is not found! Please try again later',
                                        );
                                      }
                                    } else {
                                      isLoading.value = false;
                                      Get.snackbar(
                                          "Message", "Please Enter Value");
                                    }*/
                                  },
                                  child: Text(
                                    "Verification",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: "Inter",
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                            ],
                          );
                        });
                  } else {
                    Get.snackbar("Message",
                        "you doesn't permission to see Fees Details");
                  }
                },
                leading: Image(
                    image: AssetImage("assets/images/Survey.png"),
                    fit: BoxFit.fill,
                    height: 26.sp,
                    width: 26.sp),
                title: Text(
                  "Fees Report",
                  style: TextStyle(
                    color: AppColor.blackColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    fontFamily: "Inter",
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 25.sp, right: 40.sp),
              child: Divider(
                height: 2,
                color: AppColor.secondaryColor,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 12.sp),
              child: ListTile(
                onTap: () {
                  Get.back();
                  //Get.to(RateUsScreen());
                },
                leading: Image(
                    image: AssetImage("assets/images/Classroom.png"),
                    fit: BoxFit.fill,
                    height: 26.sp,
                    width: 26.sp),
                title: Text(
                  "Rate us",
                  style: TextStyle(
                    color: AppColor.blackColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    fontFamily: "Inter",
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 25.sp, right: 40.sp),
              child: Divider(
                height: 2,
                color: AppColor.secondaryColor,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 12.sp),
              child: ListTile(
                onTap: () async {
                  await GetStorage().remove('token');
                  //Get.offAll(LogInScreen());
                },
                leading: Image(
                    image: AssetImage("assets/images/Shutdown.png"),
                    fit: BoxFit.fill,
                    height: 26.sp,
                    width: 26.sp),
                title: Text(
                  "Logout",
                  style: TextStyle(
                    color: AppColor.blackColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    fontFamily: "Inter",
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 25.sp, right: 40.sp),
              child: Divider(
                height: 2,
                color: AppColor.secondaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
