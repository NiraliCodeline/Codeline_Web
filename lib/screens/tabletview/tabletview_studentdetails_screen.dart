import 'package:codeline_info_responsive_ui/constant/colors.dart';
import 'package:codeline_info_responsive_ui/constant/const.dart';
import 'package:codeline_info_responsive_ui/constant/progress_indicator.dart';
import 'package:codeline_info_responsive_ui/controllers/get_students_details_controller.dart';
import 'package:codeline_info_responsive_ui/controllers/internet_connectivity_controller.dart';
import 'package:codeline_info_responsive_ui/models/req/update_Iscompleted_req_model.dart';
import 'package:codeline_info_responsive_ui/models/req/update_current_course_req_model.dart';
import 'package:codeline_info_responsive_ui/repo/update_Iscompleted_repo.dart';
import 'package:codeline_info_responsive_ui/repo/update_current_course_repo.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

class TabLateViewStudentDetailsScreen extends StatefulWidget {
  const TabLateViewStudentDetailsScreen({Key? key, required this.studentId})
      : super(key: key);
  final int studentId;

  @override
  State<TabLateViewStudentDetailsScreen> createState() =>
      _TabLateViewStudentDetailsScreenState();
}

class _TabLateViewStudentDetailsScreenState
    extends State<TabLateViewStudentDetailsScreen> {
  GetStudentsDetailsController getStudentsDetailsController =
      Get.put(GetStudentsDetailsController());

  ConnectivityProvider connectivityController = Get.put(ConnectivityProvider());

  @override
  void initState() {
    super.initState();
    connectivityController.startMonitoring();
    getInfo();
  }

  getInfo() async {
    await getStudentsDetailsController.fetchAllStudentDetails(
        id: widget.studentId);
    // nameController = TextEditingController(
    //     text: getStudentsDetailsController
    //         .StudentDetailsList!.studentDetails!.fullName);
    // mailController = TextEditingController(
    //     text: getStudentsDetailsController
    //         .StudentDetailsList!.studentDetails!.email);
    // mobileNumberController = TextEditingController(
    //     text: getStudentsDetailsController
    //         .StudentDetailsList!.studentDetails!.mobile);
    // addressController = TextEditingController(
    //     text: getStudentsDetailsController
    //         .StudentDetailsList!.studentDetails!.address);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: AppColor.whiteColor,
        leading: IconButton(
            color: Colors.red,
            onPressed: () {
              Get.back(result: {'update': true});
            },
            icon: Padding(
              padding: EdgeInsets.only(
                  top: Get.height * 0.015,
                  bottom: Get.height * 0.015,
                  left: Get.width * 0.05),
              child: Image(
                height: Get.height * 0.08,
                width: Get.width * 0.08,
                image: AssetImage("assets/images/Vector.png"),
              ),
            )),
        toolbarHeight: Get.height * 0.07,
        leadingWidth: Get.width * 0.1,
        actions: [
          Padding(
            padding: EdgeInsets.only(
                right: Get.width * 0.05, left: Get.width * 0.02),
            child: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.more_vert_outlined,
                  size: Get.height * 0.035,
                  color: AppColor.blackColor,
                )),
          ),
        ],
      ),
      body: GetBuilder(
        builder: (GetStudentsDetailsController controller) {
          return Stack(
            children: [
              controller.isInitialLoading.value
                  ? AppProgressLoader()
                  : Builder(
                      builder: (BuildContext context) {
                        final tagName = getStudentsDetailsController
                            .StudentDetailsList!.studentDetails!.course;
                        print("TAGNAME---------------------${tagName}");
                        final course = tagName!.split(',');
                        print("COURSE---------------------${course}");
                        return SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: Get.width * 0.05),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: Get.height * 0.03,
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.only(left: Get.width * 0.02),
                                  child: Text(
                                    "Student Details",
                                    style: TextStyle(
                                      color: AppColor.blackColor,
                                      fontSize: Get.height * 0.035,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: "Inter",
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: Get.height * 0.01,
                                ),
                                Container(
                                  height: Get.height * 0.16,
                                  //color: Colors.yellow,
                                  child: Row(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(
                                            left: Get.width * 0.04),
                                        height: Get.height * 0.12,
                                        width: Get.width * 0.18,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                                Get.height * 0.012),
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                    "${getStudentsDetailsController.StudentDetailsList!.studentDetails!.avatar}"),
                                                fit: BoxFit.cover)),
                                      ),
                                      SizedBox(
                                        width: Get.width * 0.05,
                                      ),
                                      Container(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${getStudentsDetailsController.StudentDetailsList!.studentDetails!.fullName}",
                                              style: TextStyle(
                                                color: AppColor.blackColor,
                                                fontSize: Get.height * 0.027,
                                                fontWeight: FontWeight.w600,
                                                fontFamily: "Inter",
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: Get.height * 0.005),
                                              child: Text(
                                                "${getStudentsDetailsController.StudentDetailsList!.studentDetails!.email}",
                                                style: TextStyle(
                                                    fontSize:
                                                        Get.height * 0.0185,
                                                    fontWeight: FontWeight.w400,
                                                    fontFamily: "Inter",
                                                    color: Color(0xff868585)),
                                              ),
                                            ),
                                            Text(
                                              "ENRL NO : CLKH${DateFormat('yyyy').format((getStudentsDetailsController.StudentDetailsList!.studentDetails!.joiningDate)!)}${getStudentsDetailsController.StudentDetailsList!.studentDetails!.studentId}",
                                              style: TextStyle(
                                                  fontSize: Get.height * 0.018,
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily: "Inter",
                                                  color: Color(0xff868585)),
                                            ),
                                            Text(
                                              "Joining at : ${DateFormat('dd-MM-yyyy').format((getStudentsDetailsController.StudentDetailsList!.studentDetails!.joiningDate)!)} ",
                                              style: TextStyle(
                                                  fontSize: Get.height * 0.018,
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily: "Inter",
                                                  color: Color(0xff868585)),
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  "Status: ",
                                                  style: TextStyle(
                                                      fontSize:
                                                          Get.height * 0.018,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontFamily: "Inter",
                                                      color: Color(0xff868585)),
                                                ),
                                                GestureDetector(
                                                  onTap: () async {
                                                    showDialog(
                                                        context: context,
                                                        builder:
                                                            (ctx) =>
                                                                AlertDialog(
                                                                    title: Text(
                                                                      "Update Status",
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
                                                                                0.016,
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
                                                                                Get.height * 0.018,
                                                                            fontWeight:
                                                                                FontWeight.w600,
                                                                            fontFamily:
                                                                                "Inter",
                                                                          ),
                                                                        ),
                                                                        onPressed:
                                                                            () async {
                                                                          Get.back();

                                                                          UpdateIsCompletedReqModel
                                                                              updateIsCompletedReqModel =
                                                                              UpdateIsCompletedReqModel();
                                                                          updateIsCompletedReqModel.studentId = int.parse(getStudentsDetailsController
                                                                              .StudentDetailsList!
                                                                              .studentDetails!
                                                                              .studentId!);
                                                                          if (getStudentsDetailsController.StudentDetailsList!.studentDetails!.courseCompleted ==
                                                                              "0") {
                                                                            updateIsCompletedReqModel.courseCompleted =
                                                                                1;
                                                                          } else {
                                                                            updateIsCompletedReqModel.courseCompleted =
                                                                                0;
                                                                          }

                                                                          await UpdateIsCompletedRepo.updateIsCompletedrepo(
                                                                              updateIsCompletedReqModel);
                                                                          getStudentsDetailsController
                                                                              .onInit();
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
                                                                                Get.height * 0.018,
                                                                            fontWeight:
                                                                                FontWeight.w600,
                                                                            fontFamily:
                                                                                "Inter",
                                                                          ),
                                                                        ),
                                                                      )
                                                                    ])).then(
                                                      (_) => setState(() {}),
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
                                                            Get.height * 0.018,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontFamily: "Inter",
                                                        color: getStudentsDetailsController
                                                                    .StudentDetailsList!
                                                                    .studentDetails!
                                                                    .courseCompleted ==
                                                                "0"
                                                            ? Color(0xffFFB74B)
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
                                      fontSize: Get.height * 0.027,
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
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Mobile No  :  ${getStudentsDetailsController.StudentDetailsList!.studentDetails!.mobile}",
                                        style: TextStyle(
                                            fontSize: Get.height * 0.020,
                                            fontWeight: FontWeight.w400,
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
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Address     :  ",
                                        style: TextStyle(
                                            fontSize: Get.height * 0.020,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: "Inter",
                                            color: Color(0xff868585)),
                                      ),
                                      Container(
                                        child: Expanded(
                                            child: Text(
                                          "${getStudentsDetailsController.StudentDetailsList!.studentDetails!.address}",
                                          style: TextStyle(
                                              height: Get.height * 0.0010,
                                              fontSize: Get.height * 0.020,
                                              fontWeight: FontWeight.w400,
                                              fontFamily: "Inter",
                                              color: Color(0xff868585)),
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
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Fees Report",
                                        style: TextStyle(
                                          color: AppColor.blackColor,
                                          fontSize: Get.height * 0.027,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: "Inter",
                                        ),
                                      ),
                                      MaterialButton(
                                        onPressed: () {
                                          if (GetStorage().read("role") ==
                                              "admin") {
                                            getStudentsDetailsController
                                                .resetInstallmentPopup();
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return SimpleDialog(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              Get.height *
                                                                  0.012)),
                                                  children: [
                                                    SizedBox(
                                                      height: Get.height * 0.02,
                                                    ),
                                                    Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal:
                                                                    Get.width *
                                                                        0.02),
                                                        child: GetBuilder<
                                                            GetStudentsDetailsController>(
                                                          builder:
                                                              (getStdDetailsController) {
                                                            return VerticalStepper(
                                                              dashLength: 8,
                                                              steps: List.generate(
                                                                  getStdDetailsController.allInstallment!.length,
                                                                  (index) => Step(
                                                                      onTap: () {
                                                                        //add installment

                                                                        getStdDetailsController.updateLocalInstallment(
                                                                            index:
                                                                                index,
                                                                            isDone: (getStdDetailsController.allInstallment![index].completed) == "0"
                                                                                ? "1"
                                                                                : "0");
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
                                                      height: Get.height * 0.02,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal:
                                                                  Get.width *
                                                                      0.04),
                                                      child: MaterialButton(
                                                        onPressed: () async {
                                                          //update installment

                                                          Get.back();
                                                          await getStudentsDetailsController
                                                              .updateServerInstallment(
                                                                  widget
                                                                      .studentId);
                                                        },
                                                        height:
                                                            Get.height * 0.06,
                                                        minWidth:
                                                            Get.width * 0.08,
                                                        color: AppColor
                                                            .primaryColor,
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                    Get.height *
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
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: Get.height * 0.02,
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
                                        minWidth: Get.width * 0.09,
                                        color: AppColor.primaryColor,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                Get.height * 0.012)),
                                        child: Text(
                                          "Add Installment",
                                          style: TextStyle(
                                              fontSize: Get.height * 0.018,
                                              fontWeight: FontWeight.w500,
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
                                              iconStyle:
                                                  getStudentsDetailsController
                                                              .StudentDetailsList!
                                                              .studentDetails!
                                                              .allInstallments![
                                                                  index]
                                                              .completed ==
                                                          "0"
                                                      ? AppColor.whiteColor
                                                      : AppColor.primaryColor,
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
                                                      color: Colors.white,
                                                      size: Get.height * 0.018,
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
                                                height: Get.height * 0.035,
                                              ))),
                                    )),
                                SizedBox(
                                  height: Get.height * 0.02,
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.only(left: Get.width * 0.02),
                                  child: Text(
                                    "Courses Details",
                                    style: TextStyle(
                                      color: AppColor.blackColor,
                                      fontSize: Get.height * 0.027,
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
                                    height: Get.height * 0.15,
                                    //color: Colors.yellow,
                                    child: GridView.builder(
                                      itemCount: 4,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                              mainAxisExtent:
                                                  Get.height * 0.058,
                                              crossAxisCount: 3,
                                              crossAxisSpacing:
                                                  Get.width * 0.015,
                                              mainAxisSpacing:
                                                  Get.height * 0.015),
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return GestureDetector(
                                          onTap: () {
                                            if (GetStorage().read("role") ==
                                                    "admin" ||
                                                GetStorage().read("role") ==
                                                    "faculty") {
                                              showDialog(
                                                  context: context,
                                                  builder: (ctx) => AlertDialog(
                                                          title: Text(
                                                            "Update Course",
                                                            style: TextStyle(
                                                              color: AppColor
                                                                  .blackColor,
                                                              fontSize:
                                                                  Get.height *
                                                                      0.018,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontFamily:
                                                                  "Inter",
                                                            ),
                                                          ),
                                                          content: Text(
                                                            "Are you sure?",
                                                            style: TextStyle(
                                                              color: AppColor
                                                                  .secondaryColor,
                                                              fontSize:
                                                                  Get.height *
                                                                      0.015,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontFamily:
                                                                  "Inter",
                                                            ),
                                                          ),
                                                          actions: <Widget>[
                                                            TextButton(
                                                              child: Text(
                                                                "OK",
                                                                style:
                                                                    TextStyle(
                                                                  color: AppColor
                                                                      .primaryColor,
                                                                  fontSize:
                                                                      Get.height *
                                                                          0.017,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontFamily:
                                                                      "Inter",
                                                                ),
                                                              ),
                                                              onPressed:
                                                                  () async {
                                                                UpdateCurrentCourseReqModel
                                                                    updateCurrentCourseReqModel =
                                                                    UpdateCurrentCourseReqModel();
                                                                updateCurrentCourseReqModel
                                                                        .course =
                                                                    course[
                                                                        index];
                                                                updateCurrentCourseReqModel
                                                                        .studentId =
                                                                    widget
                                                                        .studentId;

                                                                Get.back();
                                                                getStudentsDetailsController
                                                                    .isLoading
                                                                    .value = true;
                                                                await UpdateCurrentCourseRepo
                                                                    .updateCurrentCourserepo(
                                                                        updateCurrentCourseReqModel);

                                                                getStudentsDetailsController
                                                                    .updateLocalCourse(
                                                                        index:
                                                                            index,
                                                                        course:
                                                                            course[index]);

                                                                print(
                                                                    "HELLO ${getStudentsDetailsController.isLoading.value}");
                                                                getStudentsDetailsController
                                                                        .isLoading
                                                                        .value =
                                                                    false;
                                                                print(
                                                                    "hello ${getStudentsDetailsController.isLoading.value}");
                                                              },
                                                            ),
                                                            TextButton(
                                                              onPressed: () {
                                                                Get.back();
                                                              },
                                                              child: Text(
                                                                "Cancel",
                                                                style:
                                                                    TextStyle(
                                                                  color: AppColor
                                                                      .primaryColor
                                                                      .withOpacity(
                                                                          0.5),
                                                                  fontSize:
                                                                      Get.height *
                                                                          0.017,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontFamily:
                                                                      "Inter",
                                                                ),
                                                              ),
                                                            )
                                                          ])).then(
                                                (_) => setState(() {}),
                                              );
                                            } else {
                                              Get.snackbar("Message",
                                                  "you doesn't have permission to Add New Student..");
                                            }
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      Get.height * 0.012),
                                              color: course[index] ==
                                                      getStudentsDetailsController
                                                          .StudentDetailsList!
                                                          .studentDetails!
                                                          .currentCourse
                                                  ? AppColor.primaryColor
                                                  : AppColor
                                                      .sideOpenDrawerColor,
                                            ),
                                            child: Center(
                                              child: Text(
                                                "${course[index]}",
                                                style: TextStyle(
                                                    fontSize:
                                                        Get.height * 0.018,
                                                    fontWeight: FontWeight.w500,
                                                    fontFamily: "Inter",
                                                    color: course[index] ==
                                                            getStudentsDetailsController
                                                                .StudentDetailsList!
                                                                .studentDetails!
                                                                .currentCourse
                                                        ? AppColor.whiteColor
                                                        : AppColor.blackColor),
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
                                  padding:
                                      EdgeInsets.only(left: Get.width * 0.02),
                                  child: Text(
                                    "Batch Details",
                                    style: TextStyle(
                                      color: AppColor.blackColor,
                                      fontSize: Get.height * 0.027,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: "Inter",
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: Get.height * 0.02,
                                ),
                                GetBuilder(
                                  builder: (GetStudentsDetailsController
                                      updateBatchController) {
                                    return Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: Get.width * 0.02),
                                        height: Get.height * 0.15,
                                        //color: Colors.yellow,
                                        child: GridView.builder(
                                          itemCount: updateBatchController
                                              .allbatch!.length,
                                          gridDelegate:
                                              SliverGridDelegateWithFixedCrossAxisCount(
                                                  mainAxisExtent:
                                                      Get.height * 0.058,
                                                  crossAxisCount: 3,
                                                  crossAxisSpacing:
                                                      Get.width * 0.015,
                                                  mainAxisSpacing:
                                                      Get.height * 0.015),
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return GestureDetector(
                                              onLongPress: () {
                                                if (GetStorage().read("role") ==
                                                        "admin" ||
                                                    GetStorage().read("role") ==
                                                        "hr") {
                                                  showDialog(
                                                      context: context,
                                                      builder:
                                                          (ctx) => AlertDialog(
                                                                  title: Text(
                                                                    "Update BatchTime",
                                                                    style:
                                                                        TextStyle(
                                                                      color: AppColor
                                                                          .blackColor,
                                                                      fontSize:
                                                                          Get.height *
                                                                              0.018,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      fontFamily:
                                                                          "Inter",
                                                                    ),
                                                                  ),
                                                                  content: Text(
                                                                    "Are you sure?",
                                                                    style:
                                                                        TextStyle(
                                                                      color: AppColor
                                                                          .secondaryColor,
                                                                      fontSize:
                                                                          Get.height *
                                                                              0.015,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
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
                                                                        updateBatchController
                                                                            .allbatch!
                                                                            .forEach((element) async {
                                                                          if (element.currentBatch ==
                                                                              1) {
                                                                            print('element.batch>>>>>${element.batch}');
                                                                            element.currentBatch =
                                                                                0;
                                                                          }
                                                                        });
                                                                        Get.back();
                                                                        updateBatchController.updateLocalBatch(
                                                                            index:
                                                                                index,
                                                                            isDone: (updateBatchController.allbatch![index].currentBatch) == 0
                                                                                ? 1
                                                                                : 0);
                                                                        getStudentsDetailsController
                                                                            .isLoading
                                                                            .value = true;
                                                                        await updateBatchController
                                                                            .updateServerBatch(widget.studentId);
                                                                        getStudentsDetailsController
                                                                            .isLoading
                                                                            .value = false;
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
                                                                          color: AppColor
                                                                              .primaryColor
                                                                              .withOpacity(0.5),
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
                                                      (_) => setState(() {}));
                                                } else {
                                                  Get.snackbar("Message",
                                                      "you doesn't have permission to Add New Student..");
                                                }
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          Get.height * 0.012),
                                                  color: (updateBatchController
                                                              .allbatch![index]
                                                              .currentBatch) ==
                                                          0
                                                      ? AppColor
                                                          .sideOpenDrawerColor
                                                      : AppColor.primaryColor,
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    "${getStudentsDetailsController.StudentDetailsList!.studentDetails!.batch![index].batch}",
                                                    style: TextStyle(
                                                        fontSize:
                                                            Get.height * 0.018,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontFamily: "Inter",
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
                          ),
                        );
                      },
                    ),
              controller.isLoading == true
                  ? Container(
                      color: Colors.white.withOpacity(0.8),
                      child: Center(
                        child: AppProgressLoader(),
                      ),
                    )
                  : SizedBox(),
            ],
          );
        },
      ),
    );
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
              left: Get.width * 0.035,
              child: DottedLine(
                lineThickness: Get.width * 0.003,
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
              left: Get.width * 0.035,
              child: DottedLine(
                lineThickness: Get.width * 0.003,
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
          horizontalTitleGap: Get.width * 0.03,
          onTap: widget.onTap,
          leading: Container(
            height: Get.height * 0.04,
            width: Get.width * 0.04,
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
                fontSize: Get.height * 0.020, color: AppColor.blackColor),
          ),
          subtitle: Row(
            children: [
              Text(
                widget.content!,
                style: TextStyle(
                    fontSize: Get.height * 0.016,
                    color: Color(0xff868585),
                    fontWeight: FontWeight.w400),
              ),
              widget.button!,
            ],
          )),
    );
  }
}
