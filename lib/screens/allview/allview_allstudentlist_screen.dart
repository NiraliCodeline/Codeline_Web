import 'package:codeline_info_responsive_ui/Responsive/Responsive.dart';
import 'package:codeline_info_responsive_ui/WebView/webview_allstudents_screen.dart';
import 'package:codeline_info_responsive_ui/screens/mobileview/mobileview_alllangstudentlist.dart';
import 'package:codeline_info_responsive_ui/screens/tabletview/tabletview_allstudents_screen.dart';
import 'package:flutter/material.dart';

class AllViewAllStudentListScreen extends StatefulWidget {
  const AllViewAllStudentListScreen({Key? key}) : super(key: key);

  @override
  State<AllViewAllStudentListScreen> createState() =>
      _AllViewAllStudentListScreenState();
}

class _AllViewAllStudentListScreenState
    extends State<AllViewAllStudentListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Responsive(
      deskTop: WebViewAllStudentScreen(),
      tablet: TabletViewAllLangStudentList(),
      mobile: MobileViewAllLangStudentList(),
    ));
  }
}
