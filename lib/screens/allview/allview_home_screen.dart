import 'package:codeline_info_responsive_ui/Responsive/Responsive.dart';
import 'package:codeline_info_responsive_ui/WebView/webview_homescreen.dart';
import 'package:codeline_info_responsive_ui/screens/mobileview/mobileview_home_screen.dart';
import 'package:codeline_info_responsive_ui/screens/tabletview/tabletview_home_screen.dart';
import 'package:flutter/material.dart';

class AllViewHomeScreen extends StatefulWidget {
  const AllViewHomeScreen({Key? key}) : super(key: key);

  @override
  State<AllViewHomeScreen> createState() => _AllViewHomeScreenState();
}

class _AllViewHomeScreenState extends State<AllViewHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Responsive(
      deskTop: WebViewHomeScreen(),
      tablet: TabLateViewHomeScreen(),
      mobile: MobileViewHomeScreen(),
    ));
  }
}
