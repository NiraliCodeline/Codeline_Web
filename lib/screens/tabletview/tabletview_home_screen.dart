import 'package:codeline_info_responsive_ui/constant/colors.dart';
import 'package:codeline_info_responsive_ui/constant/progress_indicator.dart';
import 'package:codeline_info_responsive_ui/controllers/get_dashboard_details_controller.dart';
import 'package:codeline_info_responsive_ui/controllers/internet_connectivity_controller.dart';
import 'package:codeline_info_responsive_ui/screens/allview/allview_allstudentlist_screen.dart';
import 'package:countup/countup.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TabLateViewHomeScreen extends StatefulWidget {
  const TabLateViewHomeScreen({Key? key}) : super(key: key);

  @override
  State<TabLateViewHomeScreen> createState() => _TabLateViewHomeScreenState();
}

class _TabLateViewHomeScreenState extends State<TabLateViewHomeScreen> {
  GetDashboardDetailsController getDashboardDetailsController =
      Get.put(GetDashboardDetailsController());

  ConnectivityProvider connectivityController = Get.put(ConnectivityProvider());

  RxBool isLoading = false.obs;

  void initState() {
    super.initState();
    connectivityController.startMonitoring();
    getDashboardDetailsController.fetchAllDashboardDetails();
  }

  @override
  Widget build(BuildContext context) {
    print('Height---------${Get.height}');
    print('Width---------${Get.width}');
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(Get.height * 0.1),
          child: AppBar(
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
            leadingWidth: Get.width * 0.23,
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
                      fontSize: Get.height * 0.016,
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
                      fontSize: Get.height * 0.016,
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
                      fontSize: Get.height * 0.016,
                      fontWeight: FontWeight.w400,
                      fontFamily: "Inter",
                    ),
                  )),
              /* TextButton(
                onPressed: () {},
                child: Text(
                  "favourite student",
                  style: TextStyle(
                    color: AppColor.whiteColor,
                    fontSize: Get.height * 0.014,
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
                    fontSize: Get.height * 0.014,
                    fontWeight: FontWeight.w400,
                    fontFamily: "Inter",
                  ),
                )),*/
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
                      fontSize: Get.height * 0.016,
                      fontWeight: FontWeight.w600,
                      fontFamily: "Inter",
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        body: GetBuilder<GetDashboardDetailsController>(
          builder: (controller) {
            return Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: Get.height * 0.13,
                    ),
                    Text(
                      "Welcome, Admin",
                      style: TextStyle(
                        color: AppColor.blackColor,
                        fontSize: Get.height * 0.055,
                        fontWeight: FontWeight.w600,
                        fontFamily: "Inter",
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.1,
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: Get.width * 0.05),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CircleBar(
                                  onTap: () {
                                    Get.to(AllViewAllStudentListScreen())!
                                        .then((value) {
                                      if (value['update'])
                                        getDashboardDetailsController
                                            .fetchAllDashboardDetails();

                                      print("New API calls");
                                    });
                                  },
                                  image: "assets/images/012-girl 1.png",
                                  endNumber: getDashboardDetailsController
                                      .allDashboardDetailsList!.totalStudent!
                                      .toDouble(),
                                  text: "Total Student ",
                                  text2: "Count"),
                              CircleBar(
                                  onTap: () {},
                                  image: "assets/images/029-survey 1.png",
                                  endNumber: getDashboardDetailsController
                                      .allDashboardDetailsList!.totalInquiry!
                                      .toDouble(),
                                  text: "Total Student ",
                                  text2: "Inquiry"),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: Get.height * 0.01,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: Get.width * 0.05),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CircleBar(
                                  onTap: () {},
                                  image: "assets/images/001-desk 1.png",
                                  endNumber: getDashboardDetailsController
                                      .allDashboardDetailsList!.currentDemo!
                                      .toDouble(),
                                  text: "Current Demo ",
                                  text2: "Student"),
                              CircleBar(
                                  onTap: () {},
                                  image: "assets/images/026-favourite 1.png",
                                  endNumber: getDashboardDetailsController
                                      .allDashboardDetailsList!
                                      .completedStudent!
                                      .toDouble(),
                                  text: "completed ",
                                  text2: "Student"),
                            ],
                          ),
                        )
                      ],
                    )
                  ],
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
        ));
  }

  Widget CircleBar({
    required String image,
    required double endNumber,
    required String text,
    required String text2,
    required final onTap,
  }) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            height: Get.height * 0.16,
            width: Get.width * 0.16,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                    color: AppColor.primaryColor, width: Get.width * 0.007)),
            child: Center(
              child: Image.asset(
                image,
                fit: BoxFit.fill,
                height: Get.height * 0.055,
                width: Get.width * 0.072,
              ),
            ),
          ),
        ),
        SizedBox(
          height: Get.height * 0.003,
        ),
        Countup(
          begin: 0,
          end: endNumber,
          /*getDashboardDetailsController
                                              .allDashboardDetailsList!
                                              .totalStudent!
                                              .toDouble(),*/
          duration: Duration(milliseconds: 2500),
          separator: ',',
          style: TextStyle(
            color: AppColor.blackColor,
            fontSize: Get.height * 0.028,
            fontWeight: FontWeight.w600,
            fontFamily: "Inter",
          ),
        ),
        SizedBox(
          height: Get.height * 0.01,
        ),
        Text(
          text,
          style: TextStyle(
            color: Color(0xff868585),
            fontSize: Get.height * 0.022,
            fontWeight: FontWeight.w600,
            fontFamily: "Inter",
          ),
        ),
        Text(
          text2,
          style: TextStyle(
            color: Color(0xff868585),
            fontSize: Get.height * 0.022,
            fontWeight: FontWeight.w600,
            fontFamily: "Inter",
          ),
        ),
      ],
    );
  }
}
