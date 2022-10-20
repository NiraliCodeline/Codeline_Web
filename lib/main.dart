import 'package:codeline_info_responsive_ui/WebView/webview_allstudents_screen.dart';
import 'package:codeline_info_responsive_ui/WebView/webview_inquiry_allstudentlist_Screen.dart';
import 'package:codeline_info_responsive_ui/WebView/webview_login_screen.dart';
import 'package:codeline_info_responsive_ui/constant/colors.dart';
import 'package:codeline_info_responsive_ui/screens/allview/allview_allstudentlist_screen.dart';
import 'package:codeline_info_responsive_ui/screens/allview/allview_home_screen.dart';
import 'package:codeline_info_responsive_ui/screens/allview/allview_login_screen.dart';
import 'package:codeline_info_responsive_ui/screens/splash_screen.dart';
import 'package:codeline_info_responsive_ui/WebView/webview_homescreen.dart';
import 'package:codeline_info_responsive_ui/screens/tabletview/tabletview_addnewstudent_screen.dart';
import 'package:codeline_info_responsive_ui/screens/tabletview/tabletview_allstudents_screen.dart';
import 'package:codeline_info_responsive_ui/screens/tabletview/tabletview_home_screen.dart';
import 'package:codeline_info_responsive_ui/screens/tabletview/tabletview_login_screen.dart';
import 'package:codeline_info_responsive_ui/screens/tabletview/tabletview_studentdetails_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white, // navigation bar color
      statusBarColor: AppColor.backgroundColor, // status bar color
    ));
    return Sizer(
      builder: (context, orientation, deviceType) {
        return GetMaterialApp(
            /*builder: (context, widget) => ResponsiveWrapper.builder(
                  ClampingScrollWrapper.builder(context, widget!),
                  breakpoints: const [
                    ResponsiveBreakpoint.resize(450, name: MOBILE),
                    ResponsiveBreakpoint.autoScale(800, name: MOBILE),
                    ResponsiveBreakpoint.autoScale(800, name: TABLET),
                    ResponsiveBreakpoint.autoScale(1000, name: TABLET),
                    ResponsiveBreakpoint.resize(1200, name: DESKTOP),
                    ResponsiveBreakpoint.autoScale(2460, name: "4K"),
                    // ResponsiveBreakpoint.resize(350, name: MOBILE),
                    // ResponsiveBreakpoint.autoScale(600, name: TABLET),
                    // ResponsiveBreakpoint.resize(800, name: DESKTOP),
                    // ResponsiveBreakpoint.autoScale(1700, name: 'XL'),
                  ],
                ),*/
            debugShowCheckedModeBanner: false,
            title: 'Codeline Infotech',
            theme: ThemeData.light(),
            home: WebViewAllStudentScreen());
      },
    );
  }
}
