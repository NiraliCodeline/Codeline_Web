import 'package:codeline_info_responsive_ui/WebView/webview_allstudents_screen.dart';
import 'package:codeline_info_responsive_ui/WebView/webview_inquiry_allstudentlist_Screen.dart';
import 'package:codeline_info_responsive_ui/WebView/wenview_widgets/appbar_widgets.dart';
import 'package:codeline_info_responsive_ui/constant/colors.dart';
import 'package:codeline_info_responsive_ui/controllers/get_dashboard_details_controller.dart';
import 'package:codeline_info_responsive_ui/controllers/internet_connectivity_controller.dart';
import 'package:countup/countup.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WebViewHomeScreen extends StatefulWidget {
  const WebViewHomeScreen({Key? key}) : super(key: key);

  @override
  State<WebViewHomeScreen> createState() => _WebViewHomeScreenState();
}

class _WebViewHomeScreenState extends State<WebViewHomeScreen> {
  GetDashboardDetailsController getDashboardDetailsController =
      Get.put(GetDashboardDetailsController());

  ConnectivityProvider connectivityController = Get.put(ConnectivityProvider());

  RxBool isLoading = false.obs;

  @override
  void initState() {
    super.initState();
    connectivityController.startMonitoring();
    getDashboardDetailsController.fetchAllDashboardDetails();
  }

  @override
  Widget build(BuildContext context) {
    print('Height---------${Get.height}');
    print('Width---------${Get.width}');
    return GetBuilder<ConnectivityProvider>(
      builder: (controller) {
        return controller.isOnline
            ? Scaffold(
                appBar: PreferredSize(
                  preferredSize: Size.fromHeight(Get.height * 0.1),
                  child: AppBarWidget(),
                ),
                body: GetBuilder<GetDashboardDetailsController>(
                  builder: (controller) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: Get.height * 0.18,
                        ),
                        Text(
                          "Welcome, Admin",
                          style: TextStyle(
                            color: AppColor.blackColor,
                            fontSize: Get.height * 0.06,
                            fontWeight: FontWeight.w600,
                            fontFamily: "Inter",
                          ),
                        ),
                        SizedBox(
                          height: Get.height * 0.14,
                        ),
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: Get.width * 0.1),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CircleBar(
                                image: "assets/images/012-girl 1.png",
                                endNumber: getDashboardDetailsController
                                    .allDashboardDetailsList!.totalStudent!
                                    .toDouble(),
                                text: "Total Student Count",
                                onTap: () {
                                  Get.to(WebViewAllStudentScreen())!
                                      .then((value) {
                                    if (value['update'])
                                      getDashboardDetailsController
                                          .fetchAllDashboardDetails();

                                    print("New API calls");
                                  });
                                },
                              ),
                              CircleBar(
                                image: "assets/images/029-survey 1.png",
                                endNumber: getDashboardDetailsController
                                    .allDashboardDetailsList!.totalInquiry!
                                    .toDouble(),
                                text: "Total Student Inquiry",
                                onTap: () {
                                  Get.to(WebviewInquiryAllStudentListScreen())!
                                      .then((value) {
                                    if (value['update'])
                                      getDashboardDetailsController
                                          .fetchAllDashboardDetails();

                                    print("API calls");
                                  });
                                },
                              ),
                              CircleBar(
                                image: "assets/images/001-desk 1.png",
                                endNumber: getDashboardDetailsController
                                    .allDashboardDetailsList!.currentDemo!
                                    .toDouble(),
                                text: "Current Demo Student",
                                onTap: () {},
                              ),
                              CircleBar(
                                image: "assets/images/026-favourite 1.png",
                                endNumber: getDashboardDetailsController
                                    .allDashboardDetailsList!.completedStudent!
                                    .toDouble(),
                                text: "completed Student",
                                onTap: () {},
                              ),
                            ],
                          ),
                        )
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
                      fontSize: Get.height * 0.025,
                      fontWeight: FontWeight.w600,
                      fontFamily: "Inter",
                    ),
                  ),
                ),
              );
      },
    );
  }

  Widget CircleBar({
    required String image,
    required double endNumber,
    required String text,
    required final onTap,
  }) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            height: Get.height * 0.15,
            width: Get.width * 0.15,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                    color: AppColor.primaryColor, width: Get.width * 0.004)),
            child: Center(
              child: Image.asset(
                image,
                fit: BoxFit.fill,
                height: Get.height * 0.08,
                width: Get.width * 0.04,
              ),
            ),
          ),
        ),
        SizedBox(
          height: Get.height * 0.03,
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
            fontSize: Get.height * 0.03,
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
            fontSize: Get.height * 0.023,
            fontWeight: FontWeight.w600,
            fontFamily: "Inter",
          ),
        ),
      ],
    );
  }
}
