import 'dart:io';
import 'dart:math';
import 'package:codeline_info_responsive_ui/constant/api_routes.dart';
import 'package:codeline_info_responsive_ui/constant/colors.dart';
import 'package:codeline_info_responsive_ui/constant/const.dart';
import 'package:codeline_info_responsive_ui/constant/progress_indicator.dart';
import 'package:codeline_info_responsive_ui/controllers/add_new_student_controller.dart';
import 'package:codeline_info_responsive_ui/controllers/get_all_students_controller.dart';
import 'package:codeline_info_responsive_ui/controllers/get_students_details_controller.dart';
import 'package:codeline_info_responsive_ui/models/req/add_new_student_req_model.dart';
import 'package:codeline_info_responsive_ui/models/req/update_Iscompleted_req_model.dart';
import 'package:codeline_info_responsive_ui/models/req/update_Isfavourite_res_Model.dart';
import 'package:codeline_info_responsive_ui/models/req/update_current_course_req_model.dart';
import 'package:codeline_info_responsive_ui/repo/add_new_student_repo.dart';
import 'package:codeline_info_responsive_ui/repo/update_Iscompleted_repo.dart';
import 'package:codeline_info_responsive_ui/repo/update_Isfavourite_repo.dart';
import 'package:codeline_info_responsive_ui/repo/update_current_course_repo.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:intl/intl.dart';
import 'package:progressive_image/progressive_image.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/foundation.dart' show kIsWeb;

class WebViewAllStudentScreen extends StatefulWidget {
  const WebViewAllStudentScreen({Key? key}) : super(key: key);

  @override
  State<WebViewAllStudentScreen> createState() =>
      _WebViewAllStudentScreenState();
}

//final int studentId;
int? studentID = 0;

RxBool updateLoading = false.obs;

class _WebViewAllStudentScreenState extends State<WebViewAllStudentScreen> {
  List<String> items = ["All", "C", "C++", "DART", "FLUTTER"];

  String isSelected = 'All';
  var isItemSelected = 0;
  bool isFavourite = false;

  TextEditingController searchController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileNoController = TextEditingController();
  TextEditingController JoiningDateController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController feesController = TextEditingController();

  GetAllStudentsController getAllStudentsController =
      Get.put(GetAllStudentsController());

  GetStudentsDetailsController getStudentsDetailsController =
      Get.put(GetStudentsDetailsController());

  @override
  void initState() {
    super.initState();
    BatchesDropDown();
    //getInfo();
  }

  getInfo() async {
    await getStudentsDetailsController.fetchAllStudentDetails(id: studentID);
  }

  @override
  Widget build(BuildContext context) {
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
      ),
      body: Container(
        height: Get.height,
        width: Get.width,
        //color: Colors.green,
        child: Row(
          children: [
            Container(
              height: Get.height,
              width: Get.width * 0.14,
              color: AppColor.sideOpenDrawerColor,
              child: Column(
                children: [
                  SizedBox(
                    height: Get.height * 0.05,
                  ),
                  Flexible(
                    child: ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: EdgeInsets.only(bottom: Get.height * 0.02),
                          child: GestureDetector(
                            onTap: items[index] == ""
                                ? null
                                : () {
                                    setState(() {
                                      isSelected = items[index];
                                      isItemSelected = index;
                                    });
                                    //_scrollToIndex(isItemSelected);
                                  },
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: Get.width * 0.025),
                              height: Get.height * 0.05,
                              width: Get.width * 0.09,
                              decoration: BoxDecoration(
                                  color: items[index] == ""
                                      ? AppColor.greyColor.withOpacity(0.0)
                                      : isSelected == items[index]
                                          ? AppColor.primaryColor
                                          : AppColor.backgroundColor,
                                  borderRadius: BorderRadius.circular(
                                      Get.height * 0.012)),
                              child: Center(
                                child: Text(
                                  "${items[index]}",
                                  style: TextStyle(
                                    fontSize: Get.height * 0.015,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: "Inter",
                                    color: items[index] == ""
                                        ? AppColor.greyColor.withOpacity(0.0)
                                        : isSelected == items[index]
                                            ? Colors.white
                                            : Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
            Container(
                padding: EdgeInsets.symmetric(horizontal: Get.width * 0.03),
                height: Get.height,
                width: Get.width * 0.3,
                //color: Colors.yellow,
                child: GetBuilder(
                  builder: (GetAllStudentsController controller) {
                    if (controller.isLoading == true) {
                      return AppProgressLoader();
                    }

                    return Column(
                      children: [
                        SizedBox(
                          height: Get.height * 0.05,
                        ),
                        Container(
                          child: Focus(
                            autofocus: true,
                            onFocusChange: (hasFocus) {
                              if (hasFocus) {
                                print("Hello $hasFocus");
                              } else {
                                print("Hello $hasFocus");
                              }
                            },
                            child: TextFormField(
                              onChanged: onSearchTextChanged,
                              controller: searchController,
                              decoration: InputDecoration(
                                suffixIcon: IconButton(
                                  icon: const Icon(Icons.close),
                                  onPressed: () {
                                    searchController.clear();
                                    onSearchTextChanged('');
                                    FocusScope.of(context).unfocus();
                                  },
                                ),
                                prefixIcon: Padding(
                                  padding: EdgeInsets.all(Get.width * 0.004),
                                  child: Image(
                                    image:
                                        AssetImage("assets/images/icons.png"),
                                    height: 5,
                                    width: 5,
                                    //fit: BoxFit.fill,
                                  ),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: Get.height * 0.025,
                                    horizontal: Get.width * 0.03),
                                labelText: "Search Student",
                                labelStyle: TextStyle(
                                    color: AppColor.secondaryColor,
                                    fontSize: Get.height * 0.017,
                                    fontFamily: "Inter",
                                    fontWeight: FontWeight.w500),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: AppColor.greyColor),
                                  borderRadius:
                                      BorderRadius.circular(Get.height * 0.012),
                                ),
                                border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: AppColor.greyColor),
                                  borderRadius:
                                      BorderRadius.circular(Get.height * 0.012),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: AppColor.greyColor),
                                  borderRadius:
                                      BorderRadius.circular(Get.height * 0.012),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: Get.height * 0.05,
                        ),
                        Flexible(
                            child: getAllStudentsController
                                        .searchResult.isNotEmpty ||
                                    searchController.text.isNotEmpty
                                ? getAllStudentsController.searchResult.isEmpty
                                    ? Center(
                                        child: Text(
                                          "No Student Found",
                                          style: TextStyle(
                                              fontSize: Get.height * 0.014,
                                              fontWeight: FontWeight.w400,
                                              fontFamily: "Inter",
                                              color: AppColor.secondaryColor
                                                  .withOpacity(0.8)),
                                        ),
                                      )
                                    : ListView.builder(
                                        itemCount: isSelected != 'All'
                                            ? controller.searchResult
                                                .where((element) =>
                                                    element.currentCourse ==
                                                    isSelected)
                                                .toList()
                                                .length
                                            : controller.searchResult.length,
                                        shrinkWrap: true,
                                        physics: BouncingScrollPhysics(),
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          DateTime? now = controller
                                              .searchResult[index].joiningDate;
                                          String formattedDate =
                                              DateFormat('yyyy-MM-dd')
                                                  .format(now!);

                                          var value =
                                              controller.searchResult[index];

                                          return buildContainer(
                                              data: isSelected != 'All'
                                                  ? controller.searchResult
                                                      .where((element) =>
                                                          element
                                                              .currentCourse ==
                                                          isSelected)
                                                      .toList()
                                                  : controller.searchResult,
                                              index: index,
                                              formattedDate: formattedDate,
                                              value: value);
                                        },
                                      )
                                : ListView.builder(
                                    physics: BouncingScrollPhysics(),
                                    scrollDirection: Axis.vertical,
                                    itemCount: isSelected != 'All'
                                        ? controller.allStudentList!.data!
                                            .where((element) =>
                                                element.currentCourse ==
                                                isSelected)
                                            .toList()
                                            .length
                                        : controller
                                            .allStudentList!.data!.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      DateTime? now = getAllStudentsController
                                          .allStudentList!
                                          .data![index]
                                          .joiningDate;
                                      String formattedDate =
                                          DateFormat('yyyy-MM-dd').format(now!);

                                      var value = controller
                                          .allStudentList!.data![index];
                                      return buildContainer(
                                          data: isSelected != 'All'
                                              ? (controller
                                                  .allStudentList!.data!
                                                  .where((element) =>
                                                      element.currentCourse ==
                                                      isSelected)
                                                  .toList())
                                              : controller
                                                  .allStudentList!.data!,
                                          index: index,
                                          formattedDate: formattedDate,
                                          value: value);
                                    },
                                  ))
                      ],
                    );
                  },
                )),
            SizedBox(
              width: Get.width * 0.01,
            ),
            GetBuilder(
              builder: (GetStudentsDetailsController controller) {
                if (getAllStudentsController.id == 0) {
                  return SizedBox();
                }
                return Container(
                  height: Get.height,
                  width: Get.width * 0.3,
                  margin: EdgeInsets.symmetric(
                      vertical: Get.height * 0.04,
                      horizontal: Get.width * 0.007),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Get.height * 0.02),
                      border: Border.all(color: AppColor.greyColor, width: 2.0)
                      //color: Colors.green
                      ),
                  child: GetBuilder(
                    builder: (GetStudentsDetailsController controller) {
                      return Stack(
                        children: [
                          controller.isInitialLoading.value
                              ? AppProgressLoader()
                              : Builder(
                                  builder: (BuildContext context) {
                                    final tagName = getStudentsDetailsController
                                        .StudentDetailsList!
                                        .studentDetails!
                                        .course;
                                    print(
                                        "TAGNAME---------------------${tagName}");
                                    final course = tagName!.split(',');
                                    print(
                                        "COURSE---------------------${course}");
                                    return SingleChildScrollView(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: Get.height * 0.03,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: Get.width * 0.02),
                                            child: Text(
                                              "Student Details",
                                              style: TextStyle(
                                                color: AppColor.blackColor,
                                                fontSize: Get.height * 0.033,
                                                fontWeight: FontWeight.w600,
                                                fontFamily: "Inter",
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: Get.height * 0.01,
                                          ),
                                          Container(
                                            height: Get.height * 0.15,
                                            //color: Colors.yellow,
                                            child: Row(
                                              children: [
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      left: Get.width * 0.02),
                                                  height: Get.height * 0.1,
                                                  width: Get.width * 0.05,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              Get.height *
                                                                  0.012),
                                                      image: DecorationImage(
                                                          image: NetworkImage(
                                                              "${getStudentsDetailsController.StudentDetailsList!.studentDetails!.avatar}"),
                                                          fit: BoxFit.cover)),
                                                ),
                                                SizedBox(
                                                  width: Get.width * 0.02,
                                                ),
                                                Container(
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "${getStudentsDetailsController.StudentDetailsList!.studentDetails!.fullName}",
                                                        style: TextStyle(
                                                          color: AppColor
                                                              .blackColor,
                                                          fontSize: Get.height *
                                                              0.021,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontFamily: "Inter",
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                vertical:
                                                                    Get.height *
                                                                        0.005),
                                                        child: Text(
                                                          "${getStudentsDetailsController.StudentDetailsList!.studentDetails!.email}",
                                                          style: TextStyle(
                                                              fontSize:
                                                                  Get.height *
                                                                      0.016,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontFamily:
                                                                  "Inter",
                                                              color: Color(
                                                                  0xff868585)),
                                                        ),
                                                      ),
                                                      Text(
                                                        "ENRL NO : CLKH${DateFormat('yyyy').format((getStudentsDetailsController.StudentDetailsList!.studentDetails!.joiningDate)!)}${getStudentsDetailsController.StudentDetailsList!.studentDetails!.studentId}",
                                                        style: TextStyle(
                                                            fontSize:
                                                                Get.height *
                                                                    0.016,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontFamily: "Inter",
                                                            color: Color(
                                                                0xff868585)),
                                                      ),
                                                      Text(
                                                        "Joining at : ${DateFormat('dd-MM-yyyy').format((getStudentsDetailsController.StudentDetailsList!.studentDetails!.joiningDate)!)} ",
                                                        style: TextStyle(
                                                            fontSize:
                                                                Get.height *
                                                                    0.016,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontFamily: "Inter",
                                                            color: Color(
                                                                0xff868585)),
                                                      ),
                                                      Row(
                                                        children: [
                                                          Text(
                                                            "Status: ",
                                                            style: TextStyle(
                                                                fontSize:
                                                                    Get.height *
                                                                        0.016,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                fontFamily:
                                                                    "Inter",
                                                                color: Color(
                                                                    0xff868585)),
                                                          ),
                                                          GestureDetector(
                                                            onTap: () async {
                                                              showDialog(
                                                                  context:
                                                                      context,
                                                                  builder: (ctx) =>
                                                                      AlertDialog(
                                                                          title:
                                                                              Text(
                                                                            "Update Status",
                                                                            style:
                                                                                TextStyle(
                                                                              color: AppColor.blackColor,
                                                                              fontSize: Get.height * 0.018,
                                                                              fontWeight: FontWeight.w600,
                                                                              fontFamily: "Inter",
                                                                            ),
                                                                          ),
                                                                          content:
                                                                              Text(
                                                                            "Are you sure?",
                                                                            style:
                                                                                TextStyle(
                                                                              color: AppColor.secondaryColor,
                                                                              fontSize: Get.height * 0.016,
                                                                              fontWeight: FontWeight.w600,
                                                                              fontFamily: "Inter",
                                                                            ),
                                                                          ),
                                                                          actions: <
                                                                              Widget>[
                                                                            TextButton(
                                                                              child: Text(
                                                                                "OK",
                                                                                style: TextStyle(
                                                                                  color: AppColor.primaryColor,
                                                                                  fontSize: Get.height * 0.018,
                                                                                  fontWeight: FontWeight.w600,
                                                                                  fontFamily: "Inter",
                                                                                ),
                                                                              ),
                                                                              onPressed: () async {
                                                                                Get.back();

                                                                                UpdateIsCompletedReqModel updateIsCompletedReqModel = UpdateIsCompletedReqModel();
                                                                                updateIsCompletedReqModel.studentId = int.parse(getStudentsDetailsController.StudentDetailsList!.studentDetails!.studentId!);
                                                                                if (getStudentsDetailsController.StudentDetailsList!.studentDetails!.courseCompleted == "0") {
                                                                                  updateIsCompletedReqModel.courseCompleted = 1;
                                                                                } else {
                                                                                  updateIsCompletedReqModel.courseCompleted = 0;
                                                                                }

                                                                                await UpdateIsCompletedRepo.updateIsCompletedrepo(updateIsCompletedReqModel);
                                                                                getStudentsDetailsController.onInit();
                                                                              },
                                                                            ),
                                                                            TextButton(
                                                                              onPressed: () {
                                                                                Get.back();
                                                                              },
                                                                              child: Text(
                                                                                "Cancel",
                                                                                style: TextStyle(
                                                                                  color: AppColor.primaryColor.withOpacity(0.5),
                                                                                  fontSize: Get.height * 0.018,
                                                                                  fontWeight: FontWeight.w600,
                                                                                  fontFamily: "Inter",
                                                                                ),
                                                                              ),
                                                                            )
                                                                          ])).then(
                                                                (_) => setState(
                                                                    () {}),
                                                              );
                                                            },
                                                            child: Text(
                                                              getStudentsDetailsController
                                                                          .StudentDetailsList!
                                                                          .studentDetails!
                                                                          .courseCompleted ==
                                                                      "0"
                                                                  ? "Running"
                                                                  : "Complete",
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      Get.height *
                                                                          0.016,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  fontFamily:
                                                                      "Inter",
                                                                  color: getStudentsDetailsController
                                                                              .StudentDetailsList!
                                                                              .studentDetails!
                                                                              .courseCompleted ==
                                                                          "0"
                                                                      ? Color(
                                                                          0xffFFB74B)
                                                                      : Color(
                                                                          0xff17B857)),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: Get.height * 0.01,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: Get.width * 0.02),
                                            child: Text(
                                              "Contact Info",
                                              style: TextStyle(
                                                color: AppColor.blackColor,
                                                fontSize: Get.height * 0.023,
                                                fontWeight: FontWeight.w600,
                                                fontFamily: "Inter",
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: Get.height * 0.015,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: Get.width * 0.02),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Mobile No  :  ${getStudentsDetailsController.StudentDetailsList!.studentDetails!.mobile}",
                                                  style: TextStyle(
                                                      fontSize:
                                                          Get.height * 0.016,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontFamily: "Inter",
                                                      color: Color(0xff868585)),
                                                )
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: Get.height * 0.005,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: Get.width * 0.02),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Address     :  ",
                                                  style: TextStyle(
                                                      fontSize:
                                                          Get.height * 0.016,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontFamily: "Inter",
                                                      color: Color(0xff868585)),
                                                ),
                                                Container(
                                                  child: Expanded(
                                                      child: Text(
                                                    "${getStudentsDetailsController.StudentDetailsList!.studentDetails!.address}",
                                                    style: TextStyle(
                                                        height:
                                                            Get.height * 0.0015,
                                                        fontSize:
                                                            Get.height * 0.016,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontFamily: "Inter",
                                                        color:
                                                            Color(0xff868585)),
                                                  )),
                                                )
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: Get.height * 0.02,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: Get.width * 0.02),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "Fees Report",
                                                  style: TextStyle(
                                                    color: AppColor.blackColor,
                                                    fontSize:
                                                        Get.height * 0.023,
                                                    fontWeight: FontWeight.w600,
                                                    fontFamily: "Inter",
                                                  ),
                                                ),
                                                MaterialButton(
                                                  onPressed: () {
                                                    if (GetStorage()
                                                            .read("role") ==
                                                        "admin") {
                                                      getStudentsDetailsController
                                                          .resetInstallmentPopup();
                                                      showDialog(
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return SimpleDialog(
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius: BorderRadius
                                                                    .circular(Get
                                                                            .height *
                                                                        0.012)),
                                                            children: [
                                                              SizedBox(
                                                                height:
                                                                    Get.height *
                                                                        0.02,
                                                              ),
                                                              Padding(
                                                                  padding: EdgeInsets.symmetric(
                                                                      horizontal:
                                                                          Get.width *
                                                                              0.02),
                                                                  child: GetBuilder<
                                                                      GetStudentsDetailsController>(
                                                                    builder:
                                                                        (getStdDetailsController) {
                                                                      return VerticalStepper(
                                                                        dashLength:
                                                                            5,
                                                                        steps: List.generate(
                                                                            getStdDetailsController.allInstallment!.length,
                                                                            (index) => Step(
                                                                                onTap: () {
                                                                                  //add installment

                                                                                  getStdDetailsController.updateLocalInstallment(index: index, isDone: (getStdDetailsController.allInstallment![index].completed) == "0" ? "1" : "0");
                                                                                },
                                                                                title: "${getStdDetailsController.allInstallment![index].amount}",
                                                                                iconStyle: getStdDetailsController.allInstallment![index].completed == "0" ? AppColor.whiteColor : AppColor.primaryColor,
                                                                                icon: getStdDetailsController.allInstallment![index].completed == "0"
                                                                                    ? null
                                                                                    : Icon(
                                                                                        Icons.check,
                                                                                        color: Colors.white,
                                                                                        size: Get.height * 0.018,
                                                                                      ),
                                                                                content: getStdDetailsController.allInstallment![index].completed == "0" ? "N/A" : "${getStdDetailsController.allInstallment![index].date!.split(" ")[0].split("-")[2]}-${getStdDetailsController.allInstallment![index].date!.split(" ")[0].split("-")[1]}-${getStdDetailsController.allInstallment![index].date!.split(" ")[0].split("-")[0]}",
                                                                                button: getStdDetailsController.allInstallment![index].completed == "0" && (index == 0 || getStdDetailsController.allInstallment![index - 1].completed == "1")
                                                                                    ? IconButton(
                                                                                        onPressed: () async {
                                                                                          DateTime? _newDate = await showDatePicker(
                                                                                            context: context,
                                                                                            initialDate: DateTime.now(),
                                                                                            firstDate: DateTime(1900),
                                                                                            lastDate: DateTime(3100),
                                                                                            builder: (context, child) {
                                                                                              return Theme(
                                                                                                data: Theme.of(context).copyWith(
                                                                                                  colorScheme: ColorScheme.light(
                                                                                                    primary: AppColor.primaryColor, // <-- SEE HERE
                                                                                                    onPrimary: AppColor.whiteColor, // <-- SEE HERE
                                                                                                    onSurface: AppColor.blackColor, // <-- SEE HERE
                                                                                                  ),
                                                                                                  textButtonTheme: TextButtonThemeData(
                                                                                                    style: TextButton.styleFrom(
                                                                                                      foregroundColor: AppColor.primaryColor, // button text color
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                                child: child!,
                                                                                              );
                                                                                            },
                                                                                          );
                                                                                          if (_newDate != null) {
                                                                                            setState(() {
                                                                                              if (getStdDetailsController.allInstallment![index].completed == "0" && (getStdDetailsController.allInstallment![index].completed == "0" || getStdDetailsController.allInstallment![index + 1].completed == "0")) {
                                                                                                dateTime = _newDate;
                                                                                                dateSelected = "${dateTime!.year}-${dateTime!.month}-${dateTime!.day}";
                                                                                                getStudentsDetailsController.update();
                                                                                              }
                                                                                            });
                                                                                            getStdDetailsController.updateLocalInstallment(index: index, isDone: (getStdDetailsController.allInstallment![index].completed) == "0" ? "1" : "0");
                                                                                            print("DateSelected----------${dateSelected}");
                                                                                          }
                                                                                        },
                                                                                        icon: Icon(
                                                                                          Icons.edit,
                                                                                          size: Get.height * 0.035,
                                                                                          color: AppColor.secondaryColor,
                                                                                        ),
                                                                                      )
                                                                                    : SizedBox(
                                                                                        //height: Get.height * 0.035,
                                                                                        ))),
                                                                      );
                                                                    },
                                                                  )),
                                                              SizedBox(
                                                                height:
                                                                    Get.height *
                                                                        0.02,
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets.symmetric(
                                                                    horizontal:
                                                                        Get.width *
                                                                            0.04),
                                                                child:
                                                                    MaterialButton(
                                                                  onPressed:
                                                                      () async {
                                                                    //update installment

                                                                    Get.back();
                                                                    await getStudentsDetailsController.updateServerInstallment(
                                                                        studentID!
                                                                        //widget.studentId
                                                                        );
                                                                  },
                                                                  height:
                                                                      Get.height *
                                                                          0.06,
                                                                  minWidth:
                                                                      Get.width *
                                                                          0.08,
                                                                  color: AppColor
                                                                      .primaryColor,
                                                                  shape: RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(Get.height *
                                                                              0.012)),
                                                                  child: Text(
                                                                    "Update",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            Get.height *
                                                                                0.015,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w500,
                                                                        fontFamily:
                                                                            "Inter",
                                                                        color: Colors
                                                                            .white),
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height:
                                                                    Get.height *
                                                                        0.02,
                                                              ),
                                                            ],
                                                          );
                                                        },
                                                      );
                                                    } else {
                                                      Get.snackbar("Message",
                                                          "you doesn't have permission to Add New Student..");
                                                    }
                                                  },
                                                  height: Get.height * 0.06,
                                                  minWidth: Get.width * 0.08,
                                                  color: AppColor.primaryColor,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              Get.height *
                                                                  0.012)),
                                                  child: Text(
                                                    "Add Installment",
                                                    style: TextStyle(
                                                        fontSize:
                                                            Get.height * 0.015,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontFamily: "Inter",
                                                        color: Colors.white),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: Get.height * 0.02,
                                          ),
                                          Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: Get.width * 0.02),
                                              child: VerticalStepper(
                                                dashLength: 5,
                                                steps: List.generate(
                                                    getStudentsDetailsController
                                                        .StudentDetailsList!
                                                        .studentDetails!
                                                        .allInstallments!
                                                        .length,
                                                    (index) => Step(
                                                        onTap: null,
                                                        title:
                                                            "${getStudentsDetailsController.StudentDetailsList!.studentDetails!.allInstallments![index].amount}",
                                                        iconStyle: getStudentsDetailsController
                                                                    .StudentDetailsList!
                                                                    .studentDetails!
                                                                    .allInstallments![
                                                                        index]
                                                                    .completed ==
                                                                "0"
                                                            ? AppColor
                                                                .whiteColor
                                                            : AppColor
                                                                .primaryColor,
                                                        icon: getStudentsDetailsController
                                                                    .StudentDetailsList!
                                                                    .studentDetails!
                                                                    .allInstallments![
                                                                        index]
                                                                    .completed ==
                                                                "0"
                                                            ? null
                                                            : Icon(
                                                                Icons.check,
                                                                color: Colors
                                                                    .white,
                                                                size:
                                                                    Get.height *
                                                                        0.018,
                                                              ),
                                                        content: getStudentsDetailsController
                                                                    .StudentDetailsList!
                                                                    .studentDetails!
                                                                    .allInstallments![
                                                                        index]
                                                                    .completed ==
                                                                "0"
                                                            ? "N/A"
                                                            : "${getStudentsDetailsController.StudentDetailsList!.studentDetails!.allInstallments![index].date!.split(" ")[0].split("-")[2]}-${getStudentsDetailsController.StudentDetailsList!.studentDetails!.allInstallments![index].date!.split(" ")[0].split("-")[1]}-${getStudentsDetailsController.StudentDetailsList!.studentDetails!.allInstallments![index].date!.split(" ")[0].split("-")[0]}",
                                                        button: SizedBox(
                                                          height: Get.height *
                                                              0.035,
                                                        ))),
                                              )),
                                          SizedBox(
                                            height: Get.height * 0.02,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: Get.width * 0.02),
                                            child: Text(
                                              "Courses Details",
                                              style: TextStyle(
                                                color: AppColor.blackColor,
                                                fontSize: Get.height * 0.023,
                                                fontWeight: FontWeight.w600,
                                                fontFamily: "Inter",
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: Get.height * 0.02,
                                          ),
                                          Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: Get.width * 0.02),
                                              height: Get.height * 0.12,
                                              //color: Colors.yellow,
                                              child: GridView.builder(
                                                itemCount: 4,
                                                gridDelegate:
                                                    SliverGridDelegateWithFixedCrossAxisCount(
                                                        mainAxisExtent:
                                                            Get.height * 0.05,
                                                        crossAxisCount: 3,
                                                        crossAxisSpacing:
                                                            Get.width * 0.01,
                                                        mainAxisSpacing:
                                                            Get.height * 0.01),
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  return GestureDetector(
                                                    onTap: () {
                                                      if (GetStorage().read(
                                                                  "role") ==
                                                              "admin" ||
                                                          GetStorage().read(
                                                                  "role") ==
                                                              "faculty") {
                                                        showDialog(
                                                            context: context,
                                                            builder: (ctx) =>
                                                                AlertDialog(
                                                                    title: Text(
                                                                      "Update Course",
                                                                      style:
                                                                          TextStyle(
                                                                        color: AppColor
                                                                            .blackColor,
                                                                        fontSize:
                                                                            Get.height *
                                                                                0.018,
                                                                        fontWeight:
                                                                            FontWeight.w600,
                                                                        fontFamily:
                                                                            "Inter",
                                                                      ),
                                                                    ),
                                                                    content:
                                                                        Text(
                                                                      "Are you sure?",
                                                                      style:
                                                                          TextStyle(
                                                                        color: AppColor
                                                                            .secondaryColor,
                                                                        fontSize:
                                                                            Get.height *
                                                                                0.015,
                                                                        fontWeight:
                                                                            FontWeight.w600,
                                                                        fontFamily:
                                                                            "Inter",
                                                                      ),
                                                                    ),
                                                                    actions: <
                                                                        Widget>[
                                                                      TextButton(
                                                                        child:
                                                                            Text(
                                                                          "OK",
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                AppColor.primaryColor,
                                                                            fontSize:
                                                                                Get.height * 0.017,
                                                                            fontWeight:
                                                                                FontWeight.w600,
                                                                            fontFamily:
                                                                                "Inter",
                                                                          ),
                                                                        ),
                                                                        onPressed:
                                                                            () async {
                                                                          UpdateCurrentCourseReqModel
                                                                              updateCurrentCourseReqModel =
                                                                              UpdateCurrentCourseReqModel();
                                                                          updateCurrentCourseReqModel.course =
                                                                              course[index];
                                                                          updateCurrentCourseReqModel.studentId =
                                                                              studentID;
                                                                          //widget.studentId;

                                                                          Get.back();
                                                                          getStudentsDetailsController
                                                                              .isLoading
                                                                              .value = true;
                                                                          await UpdateCurrentCourseRepo.updateCurrentCourserepo(
                                                                              updateCurrentCourseReqModel);

                                                                          getStudentsDetailsController.updateLocalCourse(
                                                                              index: index,
                                                                              course: course[index]);

                                                                          print(
                                                                              "HELLO ${getStudentsDetailsController.isLoading.value}");
                                                                          getStudentsDetailsController
                                                                              .isLoading
                                                                              .value = false;
                                                                          print(
                                                                              "hello ${getStudentsDetailsController.isLoading.value}");
                                                                        },
                                                                      ),
                                                                      TextButton(
                                                                        onPressed:
                                                                            () {
                                                                          Get.back();
                                                                        },
                                                                        child:
                                                                            Text(
                                                                          "Cancel",
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                AppColor.primaryColor.withOpacity(0.5),
                                                                            fontSize:
                                                                                Get.height * 0.017,
                                                                            fontWeight:
                                                                                FontWeight.w600,
                                                                            fontFamily:
                                                                                "Inter",
                                                                          ),
                                                                        ),
                                                                      )
                                                                    ])).then(
                                                          (_) =>
                                                              setState(() {}),
                                                        );
                                                      } else {
                                                        Get.snackbar("Message",
                                                            "you doesn't have permission to Add New Student..");
                                                      }
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    Get.height *
                                                                        0.012),
                                                        color: course[index] ==
                                                                getStudentsDetailsController
                                                                    .StudentDetailsList!
                                                                    .studentDetails!
                                                                    .currentCourse
                                                            ? AppColor
                                                                .primaryColor
                                                            : AppColor
                                                                .sideOpenDrawerColor,
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          "${course[index]}",
                                                          style: TextStyle(
                                                              fontSize:
                                                                  Get.height *
                                                                      0.015,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontFamily:
                                                                  "Inter",
                                                              color: course[
                                                                          index] ==
                                                                      getStudentsDetailsController
                                                                          .StudentDetailsList!
                                                                          .studentDetails!
                                                                          .currentCourse
                                                                  ? AppColor
                                                                      .whiteColor
                                                                  : AppColor
                                                                      .blackColor),
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              )),
                                          SizedBox(
                                            height: Get.height * 0.02,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: Get.width * 0.02),
                                            child: Text(
                                              "Batch Details",
                                              style: TextStyle(
                                                color: AppColor.blackColor,
                                                fontSize: Get.height * 0.023,
                                                fontWeight: FontWeight.w600,
                                                fontFamily: "Inter",
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: Get.height * 0.02,
                                          ),
                                          GetBuilder(
                                            builder:
                                                (GetStudentsDetailsController
                                                    updateBatchController) {
                                              return Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal:
                                                          Get.width * 0.02),
                                                  height: Get.height * 0.12,
                                                  //color: Colors.yellow,
                                                  child: GridView.builder(
                                                    itemCount:
                                                        updateBatchController
                                                            .allbatch!.length,
                                                    gridDelegate:
                                                        SliverGridDelegateWithFixedCrossAxisCount(
                                                            mainAxisExtent:
                                                                Get.height *
                                                                    0.05,
                                                            crossAxisCount: 3,
                                                            crossAxisSpacing:
                                                                Get.width *
                                                                    0.01,
                                                            mainAxisSpacing:
                                                                Get.height *
                                                                    0.01),
                                                    itemBuilder:
                                                        (BuildContext context,
                                                            int index) {
                                                      return GestureDetector(
                                                        onLongPress: () {
                                                          if (GetStorage().read(
                                                                      "role") ==
                                                                  "admin" ||
                                                              GetStorage().read(
                                                                      "role") ==
                                                                  "hr") {
                                                            showDialog(
                                                                context:
                                                                    context,
                                                                builder: (ctx) =>
                                                                    AlertDialog(
                                                                        title:
                                                                            Text(
                                                                          "Update BatchTime",
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                AppColor.blackColor,
                                                                            fontSize:
                                                                                Get.height * 0.018,
                                                                            fontWeight:
                                                                                FontWeight.w600,
                                                                            fontFamily:
                                                                                "Inter",
                                                                          ),
                                                                        ),
                                                                        content:
                                                                            Text(
                                                                          "Are you sure?",
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                AppColor.secondaryColor,
                                                                            fontSize:
                                                                                Get.height * 0.015,
                                                                            fontWeight:
                                                                                FontWeight.w600,
                                                                            fontFamily:
                                                                                "Inter",
                                                                          ),
                                                                        ),
                                                                        actions: <
                                                                            Widget>[
                                                                          TextButton(
                                                                            child:
                                                                                Text(
                                                                              "OK",
                                                                              style: TextStyle(
                                                                                color: AppColor.primaryColor,
                                                                                fontSize: Get.height * 0.017,
                                                                                fontWeight: FontWeight.w600,
                                                                                fontFamily: "Inter",
                                                                              ),
                                                                            ),
                                                                            onPressed:
                                                                                () async {
                                                                              updateBatchController.allbatch!.forEach((element) async {
                                                                                if (element.currentBatch == 1) {
                                                                                  print('element.batch>>>>>${element.batch}');
                                                                                  element.currentBatch = 0;
                                                                                }
                                                                              });
                                                                              Get.back();
                                                                              updateBatchController.updateLocalBatch(index: index, isDone: (updateBatchController.allbatch![index].currentBatch) == 0 ? 1 : 0);
                                                                              getStudentsDetailsController.isLoading.value = true;
                                                                              await updateBatchController.updateServerBatch(studentID!
                                                                                  //widget.studentId
                                                                                  );
                                                                              getStudentsDetailsController.isLoading.value = false;
                                                                            },
                                                                          ),
                                                                          TextButton(
                                                                            onPressed:
                                                                                () {
                                                                              Get.back();
                                                                            },
                                                                            child:
                                                                                Text(
                                                                              "Cancel",
                                                                              style: TextStyle(
                                                                                color: AppColor.primaryColor.withOpacity(0.5),
                                                                                fontSize: Get.height * 0.017,
                                                                                fontWeight: FontWeight.w600,
                                                                                fontFamily: "Inter",
                                                                              ),
                                                                            ),
                                                                          )
                                                                        ])).then(
                                                                (_) => setState(
                                                                    () {}));
                                                          } else {
                                                            Get.snackbar(
                                                                "Message",
                                                                "you doesn't have permission to Add New Student..");
                                                          }
                                                        },
                                                        child: Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                    Get.height *
                                                                        0.012),
                                                            color: (updateBatchController
                                                                        .allbatch![
                                                                            index]
                                                                        .currentBatch) ==
                                                                    0
                                                                ? AppColor
                                                                    .sideOpenDrawerColor
                                                                : AppColor
                                                                    .primaryColor,
                                                          ),
                                                          child: Center(
                                                            child: Text(
                                                              "${getStudentsDetailsController.StudentDetailsList!.studentDetails!.batch![index].batch}",
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      Get.height *
                                                                          0.015,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontFamily:
                                                                      "Inter",
                                                                  color: (updateBatchController
                                                                              .allbatch![
                                                                                  index]
                                                                              .currentBatch) ==
                                                                          0
                                                                      ? AppColor
                                                                          .blackColor
                                                                      : AppColor
                                                                          .whiteColor),
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ));
                                            },
                                          ),
                                          SizedBox(
                                            height: Get.height * 0.02,
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                )
                        ],
                      );
                    },
                  ),
                );
              },
            )
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding:
            EdgeInsets.only(right: Get.width * 0.02, bottom: Get.height * 0.02),
        child: Container(
          height: Get.height * 0.08,
          width: Get.width * 0.06,
          //color: Colors.yellow,
          child: FloatingActionButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return addNewStudentDialog();
                },
              );
            },
            elevation: 0.0,
            backgroundColor: AppColor.primaryColor,
            child: Icon(
              Icons.add,
              size: Get.height * 0.06,
              color: AppColor.whiteColor,
            ),
          ),
        ),
      ),
    );
  }

  // add New Student api call

  TextEditingController amountController = TextEditingController();

  AddNewStudentController _addNewStudentController =
      Get.put(AddNewStudentController());

  RxBool isLoading = false.obs;

  AddNewStudentReqModel addNewStudentReqModel = AddNewStudentReqModel();
  Future updateClick() async {
    isLoading.value = true;
    String? url = await uploadUserImage(
      fileName: "${Random().nextInt(1000)}${pickedFile!.path.split('/').first}",
    );

    print("IMAGE URL-----------1${url}");
    addNewStudentReqModel.avatar = url;

    addNewStudentReqModel.fullName = fullNameController.text.trim();
    addNewStudentReqModel.email = emailController.text.trim();
    addNewStudentReqModel.mobile = mobileNoController.text.trim();
    addNewStudentReqModel.joiningDate = dateSelected;
    addNewStudentReqModel.address = addressController.text.trim();
    addNewStudentReqModel.course = _addNewStudentController.course;
    addNewStudentReqModel.totalFees = feesController.text.trim();
    addNewStudentReqModel.favorite = false;
    addNewStudentReqModel.studentId = 70;

    for (int i = 0; i < _addNewStudentController.batches.length; i++) {
      addNewStudentReqModel.batch.add(Batch(
          batch: _addNewStudentController.batches[i],
          currentBatch: _addNewStudentController.batches[i] ==
                  _addNewStudentController.batchesTime
              ? 1
              : 0));
    }

    print("batch Length: ${addNewStudentReqModel.batch.length}");

    for (int i = 0; i < _addNewStudentController.installments.length; i++) {
      addNewStudentReqModel.installments.add(Installment(
          isDone: false,
          installmentNo: (i + 1),
          amount: _addNewStudentController.installments[i]));
    }

    addNewStudentReqModel.installments.forEach((element) {
      print("amount: ${element.amount}");
      print("installmentNo: ${element.installmentNo}");
      print("isDone: ${element.isDone}");
    });

    bool result = await AddNewStudentRepo.getAllStudents(addNewStudentReqModel);

    if (result == true) {
      print("UPDATE SUCCESSFULLY-------->>>>>>>");
      Get.back(result: {'update': true});
    } else {
      print("UPDATE FAILED-------->>>>>>>");
      Get.snackbar("Message", "Update Failed.....");
    }
  }

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  DateTime? _dateTime;

  var dateSelected;

  List<String> batchList = [
    "10 to 12",
    "12 to 2",
    "2 to 4",
    "4 to 6",
  ];

  List<String> courseItems = [
    "C",
    "C++",
    "DART",
    "FLUTTER",
    "UI/UX",
    "Node.js"
  ];

  BatchesDropDown() {
    batchList.forEach((value) {
      _addNewStudentController.batches.add(value);
    });
  }

  //File? _image;
  bool imageAvailable = false;
  Uint8List? imageFile;
  var pickedFile;
  Uint8List? pickedFileBytes;
  File _file = File("zz");
  Uint8List webImage = Uint8List(10);
  chooseImage1() async {
    pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    // pickedFile = await ImagePickerWeb.getImageAsBytes();
    pickedFileBytes = await pickedFile!.readAsBytes();
    setState(() {
      _file = File("a");
      webImage = pickedFileBytes!;
      imageAvailable = true;
      imageFile = pickedFileBytes!;
    });
    print('WEB IMAGE----------${pickedFile.path}');
    // uploadImageToStorage(pickedFile);
  }

  chooseImage() async {
    var image = await ImagePickerWeb.getImageAsBytes();

    setState(() {
      imageFile = image!;
      imageAvailable = true;
    });
    // File imgfile = File(image);
    // Uint8List imgbytes1 = imgfile.readAsBytesSync();
    // print('imageFile***********');
    // File decodedimgfile = await File("image.jpg").writeAsBytes(imageFile!);
    // print('imageFile---------${decodedimgfile}');
  }

  /*Future getImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;

    final imageTemporary = File(image.path);

    setState(() {
      this._image = imageTemporary;
    });
    print("Image---------${_image}");
  }*/

  Future<String?> uploadUserImage({String? fileName}) async {
    Map<String, String> header = {
      "Authorization": '${bearerToken}',
      "Content-Type": "multipart/form-data"
    };

    print("FileName:${fileName}");
    dio.FormData formData = new dio.FormData.fromMap({
      "image_url": await dio.MultipartFile.fromFile(pickedFile.path,
          filename: pickedFile.path.split("/").last),
    });
    dio.Response response = await dio.Dio().post("${ApiRoutes.uploadAvatar}",
        data: formData, options: dio.Options(headers: header));

    print("data ${response.data}");

    if (response.data['image_url'] != null) {
      return response.data['image_url'];
    } else {
      return null;
    }
  }

  StatefulBuilder addNewStudentDialog() {
    return StatefulBuilder(
      builder: (BuildContext context, void Function(void Function()) setState) {
        return Form(
          key: _formkey,
          child: SimpleDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(Get.height * 0.012)),
            children: [
              SizedBox(
                height: Get.height * 0.02,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Get.width * 0.02),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: Get.height * 0.1,
                      width: Get.width * 0.045,
                      child: Stack(
                        children: [
                          Container(
                            height: Get.height * 0.09,
                            width: Get.width * 0.045,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(Get.height * 0.012),
                            ),
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.circular(Get.height * 0.012),
                              child: imageAvailable == false
                                  ? Image.asset(
                                      "assets/images/person.image.png",
                                      fit: BoxFit.cover,
                                      height: Get.height * 0.09,
                                      width: Get.width * 0.045,
                                    )
                                  : Image.memory(
                                      imageFile!,
                                      fit: BoxFit.cover,
                                      height: Get.height * 0.09,
                                      width: Get.width * 0.045,
                                    ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: GestureDetector(
                              onTap: chooseImage1,
                              child: Container(
                                height: Get.height * 0.03,
                                width: Get.width * 0.03,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: AppColor.whiteColor, width: 1),
                                    color: Colors.grey.withOpacity(0.5),
                                    shape: BoxShape.circle),
                                child: Center(
                                    child: Icon(
                                  Icons.camera_alt_outlined,
                                  color: AppColor.whiteColor,
                                  size: Get.height * 0.020,
                                )),
                              ),
                            ),
                          ),
                          /*_image == null
                              ? SizedBox()
                              : Positioned(
                                  right: -5,
                                  top: 0,
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _image = null;
                                      });
                                    },
                                    child: Container(
                                      height: Get.height * 0.025,
                                      width: Get.width * 0.025,
                                      decoration: BoxDecoration(
                                          color: Colors.red.shade700,
                                          shape: BoxShape.circle),
                                      child: Icon(
                                        Icons.close,
                                        size: Get.height * 0.018,
                                        color: AppColor.whiteColor,
                                      ),
                                    ),
                                  ))*/
                        ],
                      ),
                    ),
                    Container(
                      height: Get.height * 0.07,
                      width: Get.width * 0.13,
                      child: TextFormField(
                        controller: fullNameController,
                        decoration: InputDecoration(
                          prefixIcon: Padding(
                            padding: EdgeInsets.all(Get.width * 0.004),
                            child: Image(
                              image: AssetImage("assets/images/User.png"),
                              height: 5,
                              width: 5,
                              //fit: BoxFit.fill,
                            ),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            vertical: Get.height * 0.025,
                          ),
                          labelText: "STUDENT FULL NAME",
                          labelStyle: TextStyle(
                              color: AppColor.secondaryColor,
                              fontSize: Get.height * 0.017,
                              fontFamily: "Inter",
                              fontWeight: FontWeight.w500),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: AppColor.greyColor),
                            borderRadius:
                                BorderRadius.circular(Get.height * 0.012),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: AppColor.greyColor),
                            borderRadius:
                                BorderRadius.circular(Get.height * 0.012),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: AppColor.greyColor),
                            borderRadius:
                                BorderRadius.circular(Get.height * 0.012),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: Get.height * 0.07,
                      width: Get.width * 0.13,
                      child: TextFormField(
                        controller: emailController,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'Please a Enter';
                          }
                          if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                            return 'Please a valid Email';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          prefixIcon: Padding(
                            padding: EdgeInsets.all(Get.width * 0.004),
                            child: Image(
                              image: AssetImage("assets/images/Mail.png"),
                              height: 5,
                              width: 5,
                              //fit: BoxFit.fill,
                            ),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            vertical: Get.height * 0.025,
                          ),
                          labelText: "EMAIL ADDRESS",
                          labelStyle: TextStyle(
                              color: AppColor.secondaryColor,
                              fontSize: Get.height * 0.017,
                              fontFamily: "Inter",
                              fontWeight: FontWeight.w500),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: AppColor.greyColor),
                            borderRadius:
                                BorderRadius.circular(Get.height * 0.012),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: AppColor.greyColor),
                            borderRadius:
                                BorderRadius.circular(Get.height * 0.012),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: AppColor.greyColor),
                            borderRadius:
                                BorderRadius.circular(Get.height * 0.012),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Get.width * 0.02),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: Get.height * 0.07,
                      width: Get.width * 0.16,
                      child: TextFormField(
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(10),
                        ],
                        controller: mobileNoController,
                        validator: (value) {
                          if (value!.length != 10) {
                            return 'Mobile Number must be of 10 digit';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          prefixIcon: Padding(
                            padding: EdgeInsets.all(Get.width * 0.004),
                            child: Image(
                              image: AssetImage("assets/images/Phone.png"),
                              height: 5,
                              width: 5,
                              //fit: BoxFit.fill,
                            ),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            vertical: Get.height * 0.025,
                          ),
                          labelText: "MOBILE NO.",
                          labelStyle: TextStyle(
                              color: AppColor.secondaryColor,
                              fontSize: Get.height * 0.017,
                              fontFamily: "Inter",
                              fontWeight: FontWeight.w500),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: AppColor.greyColor),
                            borderRadius:
                                BorderRadius.circular(Get.height * 0.012),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: AppColor.greyColor),
                            borderRadius:
                                BorderRadius.circular(Get.height * 0.012),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: AppColor.greyColor),
                            borderRadius:
                                BorderRadius.circular(Get.height * 0.012),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        DateTime? _newDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime(3100),
                          builder: (context, child) {
                            return Theme(
                              data: Theme.of(context).copyWith(
                                colorScheme: ColorScheme.light(
                                  primary:
                                      AppColor.primaryColor, // <-- SEE HERE
                                  onPrimary:
                                      AppColor.whiteColor, // <-- SEE HERE
                                  onSurface:
                                      AppColor.blackColor, // <-- SEE HERE
                                ),
                                textButtonTheme: TextButtonThemeData(
                                  style: TextButton.styleFrom(
                                    foregroundColor: AppColor
                                        .primaryColor, // button text color
                                  ),
                                ),
                              ),
                              child: child!,
                            );
                          },
                        );
                        if (_newDate != null) {
                          setState(() {
                            _dateTime = _newDate;
                            dateSelected =
                                "${_dateTime!.year}-${_dateTime!.month}-${_dateTime!.day}";
                          });
                        }
                      },
                      child: Container(
                        height: Get.height * 0.061,
                        width: Get.width * 0.16,
                        margin: EdgeInsets.only(bottom: Get.height * 0.01),
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Get.height * 0.012),
                            border: Border.all(color: AppColor.greyColor)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image(
                              image: AssetImage("assets/images/Calendar.png"),
                              height: Get.height * 0.025,
                              width: Get.width * 0.025,
                              //fit: BoxFit.fill,
                            ),
                            _dateTime == null
                                ? Text(
                                    'JOINING DATE',
                                    style: TextStyle(
                                        color: AppColor.secondaryColor,
                                        fontSize: Get.height * 0.017,
                                        fontFamily: "Inter",
                                        fontWeight: FontWeight.w600),
                                  )
                                : Text(
                                    "${_dateTime!.day}-${_dateTime!.month}-${_dateTime!.year}",
                                    style: TextStyle(
                                      color: AppColor.blackColor,
                                      fontSize: Get.height * 0.017,
                                      fontFamily: "Inter",
                                      //fontWeight: FontWeight.w400
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Get.width * 0.02),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: Get.height * 0.07,
                      width: Get.width * 0.16,
                      child: TextFormField(
                        controller: addressController,
                        decoration: InputDecoration(
                          prefixIcon: Padding(
                            padding: EdgeInsets.all(Get.width * 0.004),
                            child: Image(
                              image: AssetImage("assets/images/Visit.png"),
                              height: 5,
                              width: 5,
                              //fit: BoxFit.fill,
                            ),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            vertical: Get.height * 0.025,
                          ),
                          labelText: "ADDRESS",
                          labelStyle: TextStyle(
                              color: AppColor.secondaryColor,
                              fontSize: Get.height * 0.017,
                              fontFamily: "Inter",
                              fontWeight: FontWeight.w500),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: AppColor.greyColor),
                            borderRadius:
                                BorderRadius.circular(Get.height * 0.012),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: AppColor.greyColor),
                            borderRadius:
                                BorderRadius.circular(Get.height * 0.012),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: AppColor.greyColor),
                            borderRadius:
                                BorderRadius.circular(Get.height * 0.012),
                          ),
                        ),
                      ),
                    ),
                    GetBuilder(
                      builder: (AddNewStudentController batchController) {
                        return Container(
                          height: Get.height * 0.065,
                          width: Get.width * 0.16,
                          child: FormField<String>(
                            builder: (FormFieldState<String> state) {
                              return InputDecorator(
                                decoration: InputDecoration(
                                  /*contentPadding:
                                    EdgeInsets.symmetric(
                                        vertical: Get.height * 0.025,
                                        horizontal: Get.width * 0.03),*/
                                  prefixIcon: Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: Image(
                                      image: AssetImage(
                                          "assets/images/batch2.png"),
                                      height: 5,
                                      width: 5,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: AppColor.greyColor),
                                    borderRadius: BorderRadius.circular(
                                        Get.height * 0.012),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: AppColor.greyColor),
                                    borderRadius: BorderRadius.circular(
                                        Get.height * 0.012),
                                  ),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    icon: Icon(
                                      Icons.keyboard_arrow_down_outlined,
                                      color: AppColor.secondaryColor,
                                    ),
                                    style: TextStyle(
                                      fontSize: Get.height * 0.018,
                                      //color: text_gray_color,
                                      fontFamily: "Inter",
                                    ),
                                    hint: Text(
                                      "BATCH TIME",
                                      style: TextStyle(
                                          color: AppColor.secondaryColor,
                                          fontSize: Get.height * 0.017,
                                          fontFamily: "Inter",
                                          fontWeight: FontWeight.w500),
                                    ),
                                    value: batchController.batchSelected,
                                    isExpanded: true,
                                    isDense: true,
                                    onChanged: (newValue) {
                                      //batchController.setSelected(newValue!);
                                      batchController.batchSelected = newValue!;
                                      batchController.update();
                                      batchController.batchesTime = newValue;

                                      print(
                                          "NEW BATCH--------------${batchController.batchesTime}");
                                    },
                                    items: batchController.batches
                                        .map((valueItem) {
                                      return DropdownMenuItem(
                                        value: valueItem,
                                        child: Text(
                                          valueItem,
                                          style: TextStyle(
                                              color: AppColor.secondaryColor,
                                              fontSize: Get.height * 0.017,
                                              fontFamily: "Inter",
                                              fontWeight: FontWeight.w500),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Get.width * 0.02),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: Get.height * 0.14,
                      width: Get.width * 0.16,
                      //color: Colors.yellow,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Total Fess",
                            style: TextStyle(
                              color: AppColor.blackColor,
                              fontSize: Get.height * 0.023,
                              fontWeight: FontWeight.w600,
                              fontFamily: "Inter",
                            ),
                          ),
                          SizedBox(
                            height: Get.height * 0.02,
                          ),
                          Container(
                            height: Get.height * 0.07,
                            width: Get.width * 0.16,
                            child: TextFormField(
                              controller: feesController,
                              decoration: InputDecoration(
                                prefixIcon: Padding(
                                  padding: EdgeInsets.all(Get.width * 0.004),
                                  child: Image(
                                    image: AssetImage(
                                        "assets/images/Activity Feed.png"),
                                    height: 5,
                                    width: 5,
                                    //fit: BoxFit.fill,
                                  ),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: Get.height * 0.025,
                                    horizontal: Get.width * 0.03),
                                labelText: "Fees",
                                labelStyle: TextStyle(
                                    color: AppColor.secondaryColor,
                                    fontSize: Get.height * 0.017,
                                    fontFamily: "Inter",
                                    fontWeight: FontWeight.w500),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: AppColor.greyColor),
                                  borderRadius:
                                      BorderRadius.circular(Get.height * 0.012),
                                ),
                                border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: AppColor.greyColor),
                                  borderRadius:
                                      BorderRadius.circular(Get.height * 0.012),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: AppColor.greyColor),
                                  borderRadius:
                                      BorderRadius.circular(Get.height * 0.012),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: Get.height * 0.14,
                      width: Get.width * 0.16,
                      // color: Colors.yellow,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Course",
                            style: TextStyle(
                              color: AppColor.blackColor,
                              fontSize: Get.height * 0.023,
                              fontWeight: FontWeight.w600,
                              fontFamily: "Inter",
                            ),
                          ),
                          SizedBox(
                            height: Get.height * 0.01,
                          ),
                          GetBuilder(
                            builder: (AddNewStudentController controller) {
                              return Container(
                                  height: Get.height * 0.095,
                                  //color: Colors.green,
                                  child: GridView.builder(
                                    itemCount: courseItems.length,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                            mainAxisExtent: Get.height * 0.04,
                                            crossAxisCount: 3,
                                            crossAxisSpacing: Get.width * 0.01,
                                            mainAxisSpacing: Get.height * 0.01),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return GestureDetector(
                                        onTap: () {
                                          if (!controller.course
                                              .contains(courseItems[index])) {
                                            print(
                                                "COURSE ADDED-------${courseItems[index]}");
                                            controller
                                                .addCourse(courseItems[index]);
                                          } else {
                                            courseItems.forEach((element) {
                                              print("Element---------$element");
                                              if (courseItems[index] ==
                                                  element) {
                                                controller
                                                    .removeCourse(element);
                                              }
                                            });
                                          }
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                                Get.height * 0.012),
                                            color: controller.course.contains(
                                                    courseItems[index])
                                                ? AppColor.primaryColor
                                                : AppColor.sideOpenDrawerColor,
                                          ),
                                          child: Center(
                                            child: Text(
                                              courseItems[index],
                                              style: TextStyle(
                                                  fontSize: Get.height * 0.013,
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: "Inter",
                                                  color: controller.course
                                                          .contains(courseItems[
                                                              index])
                                                      ? Colors.white
                                                      : Colors.black),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ));
                            },
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Get.width * 0.02),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: Get.height * 0.15,
                      width: Get.width * 0.16,
                      // color: Colors.yellow,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Installment",
                                style: TextStyle(
                                  color: AppColor.blackColor,
                                  fontSize: Get.height * 0.023,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "Inter",
                                ),
                              ),
                              Container(
                                height: Get.height * 0.04,
                                child: FloatingActionButton(
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return SimpleDialog(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        Get.height * 0.012)),
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "Installment",
                                                    style: TextStyle(
                                                      color: Color(0xff3F3F3F),
                                                      fontSize:
                                                          Get.height * 0.024,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontFamily: "Inter",
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: Get.height * 0.03,
                                              ),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal:
                                                        Get.width * 0.02),
                                                child: TextFormField(
                                                  // keyboardType: TextInputType
                                                  //     .number,
                                                  obscureText: false,
                                                  controller: amountController,
                                                  // validator: widget.validator,
                                                  decoration: InputDecoration(
                                                    prefixIcon: Icon(
                                                      Icons
                                                          .currency_rupee_rounded,
                                                      color:
                                                          AppColor.blackColor,
                                                    ),
                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                      vertical:
                                                          Get.height * 0.02,
                                                    ),
                                                    labelText: 'Amount',
                                                    labelStyle: TextStyle(
                                                        color: AppColor
                                                            .secondaryColor,
                                                        fontSize:
                                                            Get.height * 0.015,
                                                        fontFamily: "Inter",
                                                        fontWeight:
                                                            FontWeight.w400),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: AppColor
                                                              .blackColor),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              Get.height *
                                                                  0.012),
                                                    ),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: AppColor
                                                              .greyColor),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              Get.height *
                                                                  0.012),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: Get.height * 0.03,
                                              ),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal:
                                                        Get.width * 0.06),
                                                child: MaterialButton(
                                                  height: Get.height * 0.065,
                                                  minWidth: Get.width * 0.09,
                                                  color: AppColor.primaryColor,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              Get.height *
                                                                  0.012)),
                                                  child: Center(
                                                    child: Text(
                                                      "ADD",
                                                      style: TextStyle(
                                                          fontSize: Get.height *
                                                              0.017,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontFamily: "Inter",
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    if (amountController.text
                                                            .trim() !=
                                                        "") {
                                                      //amountController.text = "1000";
                                                      print(
                                                          'Asssssssss${amountController.text.split('x')}');
                                                      var first =
                                                          amountController.text
                                                              .split('x')
                                                              .first;
                                                      print(
                                                          'first${amountController.text.split('x').first}');
                                                      var last = int.parse(
                                                          amountController.text
                                                              .split('x')
                                                              .last);
                                                      print(
                                                          'last${amountController.text.split('x').last.runtimeType}');
                                                      var length =
                                                          amountController.text
                                                              .split('x')
                                                              .length;
                                                      print('length$length');

                                                      if (length == 1) {
                                                        _addNewStudentController
                                                            .addInstallment(
                                                                int.parse(
                                                                    amountController
                                                                        .text));
                                                        print('if');
                                                      } else {
                                                        for (var i = 0;
                                                            i < last;
                                                            i++) {
                                                          _addNewStudentController
                                                              .addInstallment(
                                                                  int.parse(
                                                                      first));
                                                          print('index$i');
                                                        }
                                                      }

                                                      amountController.clear();
                                                      Get.back();
                                                    }
                                                  },
                                                ),
                                              ),
                                              SizedBox(
                                                height: Get.height * 0.02,
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    elevation: 0.0,
                                    backgroundColor: AppColor.primaryColor,
                                    child: Icon(
                                      Icons.add,
                                      size: Get.height * 0.03,
                                      color: AppColor.whiteColor,
                                    )),
                              )
                            ],
                          ),
                          SizedBox(
                            height: Get.height * 0.02,
                          ),
                          GetBuilder<AddNewStudentController>(
                            builder: (addNewStudentController) {
                              return addNewStudentController
                                      .installments.isEmpty
                                  ? Container(
                                      height: Get.height * 0.09,
                                      child: Center(
                                        child: Text(
                                          "Please Add Installment",
                                          style: TextStyle(
                                              fontSize: Get.height * 0.018,
                                              fontWeight: FontWeight.w400,
                                              fontFamily: "Inter",
                                              color: AppColor.secondaryColor
                                                  .withOpacity(0.8)),
                                        ),
                                      ),
                                    )
                                  : Container(
                                      height: Get.height * 0.09,
                                      //color: Colors.green,
                                      child: GridView.builder(
                                        itemCount: addNewStudentController
                                            .installments.length,
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                                mainAxisExtent:
                                                    Get.height * 0.038,
                                                crossAxisCount: 3,
                                                crossAxisSpacing:
                                                    Get.width * 0.01,
                                                mainAxisSpacing:
                                                    Get.height * 0.01),
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return GestureDetector(
                                            onLongPress: () =>
                                                removeInstallment(index),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          Get.height * 0.012),
                                                  color: AppColor.primaryColor),
                                              child: Center(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      height:
                                                          Get.height * 0.013,
                                                      width: Get.width * 0.013,
                                                      decoration: BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          border: Border.all(
                                                              color: AppColor
                                                                  .whiteColor)),
                                                      child: Center(
                                                        child: Text(
                                                          "${index + 1}",
                                                          style: TextStyle(
                                                              fontSize:
                                                                  Get.height *
                                                                      0.011,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontFamily:
                                                                  "Inter",
                                                              color: AppColor
                                                                  .whiteColor),
                                                        ),
                                                      ),
                                                    ),
                                                    Text(
                                                      "${addNewStudentController.installments[index]}",
                                                      style: TextStyle(
                                                          fontSize: Get.height *
                                                              0.015,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontFamily: "Inter",
                                                          color: AppColor
                                                              .whiteColor),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ));
                            },
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: Get.height * 0.15,
                      width: Get.width * 0.16,
                      //color: Colors.yellow,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          MaterialButton(
                            onPressed: () async {
                              print("DATETIME---------------${dateSelected}");
                              print(
                                  "BATCHTIME LENGTH---------------${_addNewStudentController.batches.length}");
                              print(
                                  "BATCHTIME VALUE---------------${_addNewStudentController.batches[1]}");

                              int allInstallmentSum = 0;
                              _addNewStudentController.installments
                                  .forEach((element) {
                                allInstallmentSum += element;
                              });
                              print(
                                  "FEES CONTROLLER-1---------${allInstallmentSum}");
                              print(
                                  "FEES CONTROLLER-2--------${feesController.text}");
                              if (int.parse(feesController.text) ==
                                  allInstallmentSum) {
                                print("FEES CONTROLLER-0---------");

                                FocusScope.of(context).unfocus();

                                if (_formkey.currentState!.validate()) {
                                  if (fullNameController.text.trim() != "" &&
                                      emailController.text.trim() != "" &&
                                      mobileNoController.text.trim() != "" &&
                                      addressController.text.trim() != "" &&
                                      feesController.text.trim() != "") {
                                    await updateClick();
                                    isLoading.value = false;
                                  } else {
                                    isLoading.value = false;
                                    Get.snackbar(
                                        "Message", "Please Enter Value");
                                  }
                                } else {
                                  isLoading.value = false;
                                  Get.snackbar(
                                      "Message", "Please Enter Valid Value");
                                }
                              } else {
                                isLoading.value = false;
                                Get.snackbar("Message",
                                    "Please check Fees and installment");
                              }
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(Get.height * 0.012)),
                            color: AppColor.primaryColor,
                            height: Get.height * 0.06,
                            minWidth: Get.width * 0.15,
                            child: Text(
                              "Add & Save",
                              style: TextStyle(
                                  fontSize: Get.height * 0.019,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "Inter",
                                  color: Colors.white),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
            ],
          ),
        );
      },
    );
  }

  GestureDetector buildContainer(
      {List<dynamic>? data, int? index, String? formattedDate, var value}) {
    return GestureDetector(
      onTap: () {
        studentID = int.parse(data[index].studentId);
        getAllStudentsController
            .onItemTapped(int.parse(data[index].studentId!));

        print("STUDENT ID-------->>>>>>>>>>${studentID}");
        getStudentsDetailsController.fetchAllStudentDetails(id: studentID);

        /*setState(() {
          getStudentsDetailsController.fetchAllStudentDetails(
              id: int.parse(data[index].studentId));
          print("STUDENT ID-------->>>>>>>>>>${data[index].studentId}");
          //studentId = int.parse(data[index].studentId);
        });*/
      },
      child: Container(
        margin: EdgeInsets.only(bottom: Get.height * 0.03),
        height: Get.height * 0.12,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Get.height * 0.012),
            border: Border.all(color: AppColor.greyColor)),
        child: Stack(
          children: [
            Row(
              children: [
                Container(
                  margin: EdgeInsets.only(left: Get.width * 0.01),
                  height: Get.height * 0.09,
                  width: Get.width * 0.045,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Get.height * 0.012),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(Get.height * 0.012),
                    child: ProgressiveImage(
                      placeholder: AssetImage('assets/images/Rectangle 1.png'),
                      thumbnail: NetworkImage(data![index!].avatar.toString()),
                      fit: BoxFit.cover,
                      image: NetworkImage(data[index].avatar.toString()),
                      height: Get.height * 0.09,
                      width: Get.width * 0.045,
                    ),
                  ),
                ),
                SizedBox(
                  width: Get.width * 0.01,
                ),
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${data[index].fullName.toString()}",
                        style: TextStyle(
                          color: AppColor.blackColor,
                          fontSize: Get.height * 0.021,
                          fontWeight: FontWeight.w600,
                          fontFamily: "Inter",
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: Get.height * 0.005),
                        child: Text(
                          "${data[index].email.toString()}",
                          style: TextStyle(
                              fontSize: Get.height * 0.016,
                              fontWeight: FontWeight.w400,
                              fontFamily: "Inter",
                              color: Color(0xff868585)),
                        ),
                      ),
                      Text(
                        "Joining at : ${formattedDate}",
                        style: TextStyle(
                            fontSize: Get.height * 0.016,
                            fontWeight: FontWeight.w400,
                            fontFamily: "Inter",
                            color: Color(0xff868585)),
                      )
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              right: Get.width * 0.003,
              top: Get.height * 0.002,
              child: IconButton(
                onPressed: () async {
                  print(
                      "IDF-------${int.parse(getAllStudentsController.allStudentList!.data![index].studentId!)}");
                  if (getAllStudentsController
                          .allStudentList!.data![index].favorite ==
                      "0") {
                    print("IF CONDITION");
                    getAllStudentsController.updateIsFav(index, true);
                    isFavourite = true;

                    print("ADD FAVOURITE-----------${isFavourite}");
                  } else {
                    print("ELSE CONDITION");
                    getAllStudentsController.updateIsFav(index, false);
                    isFavourite = false;

                    print("REMOVE FAVOURITE-----------${isFavourite}");
                  }
                  UpdateIsFavouriteResModel updateIsFavouriteResModel =
                      UpdateIsFavouriteResModel();
                  updateIsFavouriteResModel.studentId = int.parse(
                      getAllStudentsController
                          .allStudentList!.data![index].studentId!);
                  updateIsFavouriteResModel.favourite =
                      isFavourite == true ? 1 : 0;

                  await UpdateIsfavouriteRepo.updateIsfavouriterepo(
                      updateIsFavouriteResModel);
                },
                icon: Icon(
                  getAllStudentsController
                              .allStudentList!.data![index].favorite ==
                          "1"
                      ? Icons.favorite
                      : Icons.favorite_outline_rounded,
                  color: getAllStudentsController
                              .allStudentList!.data![index].favorite ==
                          "1"
                      ? AppColor.primaryColor
                      : AppColor.secondaryColor,
                  size: Get.height * 0.030,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void removeInstallment(int index) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
                title: Text("Remove Detail"),
                content: Text("Are you sure?"),
                actions: <Widget>[
                  TextButton(
                    child: Text(
                      "OK",
                      style: TextStyle(
                        color: AppColor.primaryColor,
                        fontSize: Get.height * 0.018,
                        fontWeight: FontWeight.w600,
                        fontFamily: "Inter",
                      ),
                    ),
                    onPressed: () async {
                      print("Remove........");
                      _addNewStudentController.removeInstallment(index);
                      Get.back();
                    },
                  ),
                  TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: Text(
                      "Cancel",
                      style: TextStyle(
                        color: AppColor.primaryColor.withOpacity(0.5),
                        fontSize: Get.height * 0.018,
                        fontWeight: FontWeight.w600,
                        fontFamily: "Inter",
                      ),
                    ),
                  )
                ])).then(
      (_) => setState(() {}),
    );
    /*_addNewStudentController.removeInstallment(index);*/
  }

  onSearchTextChanged(String text) async {
    getAllStudentsController.searchResult.clear();
    if (text.isEmpty) {
      getAllStudentsController.update();
      return;
    }

    for (var userDetail in getAllStudentsController.allStudentList!.data!) {
      print("userDetail.fullName ${userDetail.fullName}");
      print("text $text");

      //userDetail.fullName!.split(" ")[0].toLowerCase().contains(text.toLowerCase())
      //userDetail.fullName!.split(" ")[0].toLowerCase().contains(text.toLowerCase())

      String firstName = userDetail.fullName!.split(" ")[0];

      String lastName = userDetail.fullName!.split(" ").length > 1
          ? userDetail.fullName!.split(" ")[1]
          : "";

      if (firstName.toLowerCase().contains(text.toLowerCase()) ||
          lastName.toLowerCase().contains(text.toLowerCase())) {
        getAllStudentsController.addSearchResult(userDetail);
      } else {
        getAllStudentsController.update();
      }
    }
  }
}

class VerticalStepper extends StatefulWidget {
  List<Step> steps;
  double dashLength;

  VerticalStepper({
    required this.steps,
    required this.dashLength,
  });

  @override
  _VerticalStepperState createState() => _VerticalStepperState();
}

class _VerticalStepperState extends State<VerticalStepper> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Positioned(
              height: 1000,
              top: Get.height * 0.020,
              left: Get.width * 0.02,
              child: DottedLine(
                lineThickness: Get.width * 0.0012,
                dashLength:
                    this.widget.dashLength != null ? this.widget.dashLength : 5,
                direction: Axis.vertical,
                lineLength: double.infinity,
                dashColor: AppColor.greyColor,
              ),
            ),
            Column(
              children: [
                for (int i = 0; i < widget.steps.length - 1; i++)
                  Container(
                    child: widget.steps[i],
                  )
              ],
            )
          ],
        ),
        Stack(
          children: [
            Positioned(
              top: Get.height * 0.002,
              left: Get.width * 0.02,
              child: DottedLine(
                lineThickness: Get.width * 0.0012,
                direction: Axis.vertical,
                lineLength: Get.height * 0.025,
                dashColor: AppColor.greyColor,
                dashLength: this.widget.dashLength,
              ),
            ),
            Container(
              child: widget.steps.last,
            )
          ],
        )
      ],
    );
  }
}

class Step extends StatefulWidget {
  final String? title;
  final String? content;
  final Color? iconStyle;
  final Function()? onTap;
  final icon;
  final Widget? button;

  const Step({
    this.title,
    this.content,
    this.iconStyle,
    this.onTap,
    this.icon,
    this.button,

    //this.shimmer = false,
    //this.isExpanded = false,
    //this.onExpansion,
  });

  @override
  _StepState createState() => _StepState();
}

class _StepState extends State<Step> {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData().copyWith(dividerColor: Colors.transparent),
      child: ListTile(
          onTap: widget.onTap,
          leading: Container(
            height: Get.height * 0.025,
            width: Get.width * 0.025,
            decoration: BoxDecoration(
                color: widget.iconStyle,
                shape: BoxShape.circle,
                border: Border.all(color: AppColor.greyColor)),
            child: Center(
              child: widget.icon,
            ),
          ),
          title: Text(
            widget.title!,
            style: TextStyle(
                fontSize: Get.height * 0.015, color: AppColor.blackColor),
          ),
          subtitle: Row(
            children: [
              Text(widget.content!),
              widget.button!,
            ],
          )),
    );
  }
}
