import 'package:codeline_info_responsive_ui/Responsive/Responsive.dart';
import 'package:codeline_info_responsive_ui/WebView/webview_login_screen.dart';
import 'package:codeline_info_responsive_ui/screens/mobileview/mobileview_login_screen.dart';
import 'package:codeline_info_responsive_ui/screens/tabletview/tabletview_login_screen.dart';
import 'package:flutter/material.dart';

class AllViewLogInScreen extends StatefulWidget {
  AllViewLogInScreen({Key? key}) : super(key: key);

  @override
  State<AllViewLogInScreen> createState() => _AllViewLogInScreenState();
}

class _AllViewLogInScreenState extends State<AllViewLogInScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Responsive(
      deskTop: WebViewLogInScreen(),
      tablet: TabLateViewLogInScreen(),
      mobile: MobileViewLogInScreen(),
    ));
  }
}
