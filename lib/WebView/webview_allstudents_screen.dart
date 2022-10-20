import 'package:codeline_info_responsive_ui/constant/colors.dart';
import 'package:codeline_info_responsive_ui/constant/const.dart';
import 'package:codeline_info_responsive_ui/constant/progress_indicator.dart';
import 'package:codeline_info_responsive_ui/controllers/get_all_students_controller.dart';
import 'package:codeline_info_responsive_ui/controllers/get_students_details_controller.dart';
import 'package:codeline_info_responsive_ui/models/req/update_Iscompleted_req_model.dart';
import 'package:codeline_info_responsive_ui/models/req/update_Isfavourite_res_Model.dart';
import 'package:codeline_info_responsive_ui/models/req/update_current_course_req_model.dart';
import 'package:codeline_info_responsive_ui/repo/update_Iscompleted_repo.dart';
import 'package:codeline_info_responsive_ui/repo/update_Isfavourite_repo.dart';
import 'package:codeline_info_responsive_ui/repo/update_current_course_repo.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:progressive_image/progressive_image.dart';

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

  SimpleDialog addNewStudentDialog() {
    return SimpleDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Get.height * 0.012)),
      children: [
        SizedBox(
          height: Get.height * 0.02,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: Get.width * 0.02),
          child: Row(
            children: [
              Container(
                height: Get.height * 0.09,
                width: Get.width * 0.045,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Get.height * 0.012),
                    image: DecorationImage(
                        image: AssetImage(
                          "assets/images/Image 1.png",
                        ),
                        fit: BoxFit.cover)),
              ),
              SizedBox(
                width: Get.width * 0.025,
              ),
              Container(
                height: Get.height * 0.07,
                width: Get.width * 0.18,
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
                        horizontal: Get.width * 0.03),
                    labelText: "STUDENT FULL NAME",
                    labelStyle: TextStyle(
                        color: AppColor.secondaryColor,
                        fontSize: Get.height * 0.017,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w500),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColor.greyColor),
                      borderRadius: BorderRadius.circular(Get.height * 0.012),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColor.greyColor),
                      borderRadius: BorderRadius.circular(Get.height * 0.012),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColor.greyColor),
                      borderRadius: BorderRadius.circular(Get.height * 0.012),
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
            children: [
              Container(
                height: Get.height * 0.07,
                width: Get.width * 0.15,
                child: TextFormField(
                  controller: emailController,
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
                        horizontal: Get.width * 0.03),
                    labelText: "EMAIL ADDRESS",
                    labelStyle: TextStyle(
                        color: AppColor.secondaryColor,
                        fontSize: Get.height * 0.017,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w500),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColor.greyColor),
                      borderRadius: BorderRadius.circular(Get.height * 0.012),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColor.greyColor),
                      borderRadius: BorderRadius.circular(Get.height * 0.012),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColor.greyColor),
                      borderRadius: BorderRadius.circular(Get.height * 0.012),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: Get.width * 0.02,
              ),
              Container(
                height: Get.height * 0.07,
                width: Get.width * 0.15,
                child: TextFormField(
                  controller: mobileNoController,
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
                        horizontal: Get.width * 0.03),
                    labelText: "MOBILE NO.",
                    labelStyle: TextStyle(
                        color: AppColor.secondaryColor,
                        fontSize: Get.height * 0.017,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w500),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColor.greyColor),
                      borderRadius: BorderRadius.circular(Get.height * 0.012),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColor.greyColor),
                      borderRadius: BorderRadius.circular(Get.height * 0.012),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColor.greyColor),
                      borderRadius: BorderRadius.circular(Get.height * 0.012),
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
            children: [
              Container(
                height: Get.height * 0.07,
                width: Get.width * 0.15,
                child: TextFormField(
                  controller: JoiningDateController,
                  decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: EdgeInsets.all(Get.width * 0.004),
                      child: Image(
                        image: AssetImage("assets/images/Calendar.png"),
                        height: 5,
                        width: 5,
                        //fit: BoxFit.fill,
                      ),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                        vertical: Get.height * 0.025,
                        horizontal: Get.width * 0.03),
                    labelText: "JOINING DATE",
                    labelStyle: TextStyle(
                        color: AppColor.secondaryColor,
                        fontSize: Get.height * 0.017,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w500),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColor.greyColor),
                      borderRadius: BorderRadius.circular(Get.height * 0.012),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColor.greyColor),
                      borderRadius: BorderRadius.circular(Get.height * 0.012),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColor.greyColor),
                      borderRadius: BorderRadius.circular(Get.height * 0.012),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: Get.width * 0.02,
              ),
              Container(
                height: Get.height * 0.07,
                width: Get.width * 0.15,
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
                        horizontal: Get.width * 0.03),
                    labelText: "ADDRESS",
                    labelStyle: TextStyle(
                        color: AppColor.secondaryColor,
                        fontSize: Get.height * 0.017,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w500),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColor.greyColor),
                      borderRadius: BorderRadius.circular(Get.height * 0.012),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColor.greyColor),
                      borderRadius: BorderRadius.circular(Get.height * 0.012),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColor.greyColor),
                      borderRadius: BorderRadius.circular(Get.height * 0.012),
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
            children: [
              Container(
                height: Get.height * 0.14,
                width: Get.width * 0.15,
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
                      width: Get.width * 0.15,
                      child: TextFormField(
                        controller: feesController,
                        decoration: InputDecoration(
                          prefixIcon: Padding(
                            padding: EdgeInsets.all(Get.width * 0.004),
                            child: Image(
                              image:
                                  AssetImage("assets/images/Activity Feed.png"),
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
                width: Get.width * 0.02,
              ),
              Container(
                height: Get.height * 0.14,
                width: Get.width * 0.15,
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
                    Container(
                        height: Get.height * 0.095,
                        //color: Colors.green,
                        child: GridView.builder(
                          itemCount: 6,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  mainAxisExtent: Get.height * 0.04,
                                  crossAxisCount: 3,
                                  crossAxisSpacing: Get.width * 0.01,
                                  mainAxisSpacing: Get.height * 0.01),
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(Get.height * 0.012),
                                  color: AppColor.primaryColor),
                              child: Center(
                                child: Text(
                                  "Course",
                                  style: TextStyle(
                                      fontSize: Get.height * 0.015,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "Inter",
                                      color: AppColor.whiteColor),
                                ),
                              ),
                            );
                          },
                        )),
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
            children: [
              Container(
                height: Get.height * 0.15,
                width: Get.width * 0.15,
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
                              onPressed: () {},
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
                    Container(
                        height: Get.height * 0.09,
                        //color: Colors.green,
                        child: GridView.builder(
                          itemCount: 6,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  mainAxisExtent: Get.height * 0.038,
                                  crossAxisCount: 3,
                                  crossAxisSpacing: Get.width * 0.01,
                                  mainAxisSpacing: Get.height * 0.01),
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(Get.height * 0.012),
                                  color: AppColor.primaryColor),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: Get.height * 0.013,
                                      width: Get.width * 0.013,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              color: AppColor.whiteColor)),
                                      child: Center(
                                        child: Text(
                                          "1",
                                          style: TextStyle(
                                              fontSize: Get.height * 0.011,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: "Inter",
                                              color: AppColor.whiteColor),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "10000",
                                      style: TextStyle(
                                          fontSize: Get.height * 0.015,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: "Inter",
                                          color: AppColor.whiteColor),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        )),
                  ],
                ),
              ),
              SizedBox(
                width: Get.width * 0.02,
              ),
              Container(
                height: Get.height * 0.15,
                width: Get.width * 0.15,
                //color: Colors.yellow,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    MaterialButton(
                      onPressed: () {},
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
