import 'package:codeline_info_responsive_ui/constant/colors.dart';
import 'package:codeline_info_responsive_ui/constant/const.dart';
import 'package:codeline_info_responsive_ui/constant/progress_indicator.dart';
import 'package:codeline_info_responsive_ui/controllers/get_students_details_controller.dart';
import 'package:codeline_info_responsive_ui/controllers/internet_connectivity_controller.dart';
import 'package:codeline_info_responsive_ui/models/req/update_Iscompleted_req_model.dart';
import 'package:codeline_info_responsive_ui/models/req/update_current_course_req_model.dart';
import 'package:codeline_info_responsive_ui/models/req/update_student_details_req_model.dart';
import 'package:codeline_info_responsive_ui/repo/update_Iscompleted_repo.dart';
import 'package:codeline_info_responsive_ui/repo/update_current_course_repo.dart';
import 'package:codeline_info_responsive_ui/repo/update_student_details_repo.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class MobileViewStudentDetails extends StatefulWidget {
  MobileViewStudentDetails({Key? key, required this.studentId})
      : super(key: key);
  final int studentId;

  @override
  State<MobileViewStudentDetails> createState() =>
      _MobileViewStudentDetailsState();
}

RxBool updateLoading = false.obs;

class _MobileViewStudentDetailsState extends State<MobileViewStudentDetails> {
  TextEditingController? nameController;
  TextEditingController? mailController;
  TextEditingController? mobileNumberController;
  TextEditingController? addressController;

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
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
    nameController = TextEditingController(
        text: getStudentsDetailsController
            .StudentDetailsList!.studentDetails!.fullName);
    mailController = TextEditingController(
        text: getStudentsDetailsController
            .StudentDetailsList!.studentDetails!.email);
    mobileNumberController = TextEditingController(
        text: getStudentsDetailsController
            .StudentDetailsList!.studentDetails!.mobile);
    addressController = TextEditingController(
        text: getStudentsDetailsController
            .StudentDetailsList!.studentDetails!.address);
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return GetBuilder<ConnectivityProvider>(
      builder: (controller) {
        return controller.isOnline
            ? Scaffold(
                key: _formkey,
                backgroundColor: AppColor.whiteColor,
                appBar: AppBar(
                  elevation: 0.0,
                  backgroundColor: AppColor.whiteColor,
                  leading: IconButton(
                      onPressed: () {
                        Get.back(result: {'update': true});
                      },
                      icon: Image(
                        height: 14.sp,
                        width: 154.sp,
                        image: AssetImage("assets/images/Vector.png"),
                      )),
                  actions: [
                    PopupMenuButton<int>(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.sp)),
                      icon: Icon(
                        Icons.more_vert,
                        color: AppColor.blackColor,
                      ),
                      color: AppColor.whiteColor,
                      itemBuilder: (context) => [
                        // popupmenu item 1
                        PopupMenuItem(
                            value: 1,
                            // row has two child icon and text.
                            child: GestureDetector(
                              onTap: () {
                                Get.back();
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return SimpleDialog(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(13.sp)),
                                        children: [
                                          SizedBox(
                                            height: 3.h,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 8.w),
                                            child: Container(
                                              child: TextFormField(
                                                controller: nameController,
                                                decoration: InputDecoration(
                                                  contentPadding:
                                                      EdgeInsets.symmetric(
                                                          vertical: 14.0.sp,
                                                          horizontal: 11.0.sp),
                                                  hintText: "NAME",
                                                  hintStyle: TextStyle(
                                                      color: AppColor
                                                          .secondaryColor,
                                                      fontSize: 12.sp,
                                                      fontFamily: "Inter",
                                                      fontWeight:
                                                          FontWeight.w500),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color:
                                                            AppColor.greyColor),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0.sp),
                                                  ),
                                                  border: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color:
                                                            AppColor.greyColor),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0.sp),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 2.h,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 8.w),
                                            child: Container(
                                              child: TextFormField(
                                                validator: (String? value) {
                                                  if (value!.isEmpty) {
                                                    return 'Please a Enter';
                                                  }
                                                  if (!RegExp(r'\S+@\S+\.\S+')
                                                      .hasMatch(value)) {
                                                    return 'Please a valid Email';
                                                  }
                                                  return null;
                                                },
                                                controller: mailController,
                                                decoration: InputDecoration(
                                                  contentPadding:
                                                      EdgeInsets.symmetric(
                                                          vertical: 14.0.sp,
                                                          horizontal: 11.0.sp),
                                                  hintText: "EMAIL ADDRESS",
                                                  hintStyle: TextStyle(
                                                      color: AppColor
                                                          .secondaryColor,
                                                      fontSize: 12.sp,
                                                      fontFamily: "Inter",
                                                      fontWeight:
                                                          FontWeight.w500),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color:
                                                            AppColor.greyColor),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0.sp),
                                                  ),
                                                  border: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color:
                                                            AppColor.greyColor),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0.sp),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 2.h,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 8.w),
                                            child: Container(
                                              child: TextFormField(
                                                inputFormatters: [
                                                  LengthLimitingTextInputFormatter(
                                                      10),
                                                ],
                                                controller:
                                                    mobileNumberController,
                                                validator: (value) {
                                                  if (value!.length != 10) {
                                                    return 'Code must be of 10 digit';
                                                  }
                                                  return null;
                                                },
                                                decoration: InputDecoration(
                                                  contentPadding:
                                                      EdgeInsets.symmetric(
                                                          vertical: 14.0.sp,
                                                          horizontal: 11.0.sp),
                                                  hintText: "MOBILE NO.",
                                                  hintStyle: TextStyle(
                                                      color: AppColor
                                                          .secondaryColor,
                                                      fontSize: 12.sp,
                                                      fontFamily: "Inter",
                                                      fontWeight:
                                                          FontWeight.w500),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color:
                                                            AppColor.greyColor),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0.sp),
                                                  ),
                                                  border: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color:
                                                            AppColor.greyColor),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0.sp),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 2.h,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 8.w),
                                            child: Container(
                                              child: TextFormField(
                                                controller: addressController,
                                                decoration: InputDecoration(
                                                  contentPadding:
                                                      EdgeInsets.symmetric(
                                                          vertical: 14.0.sp,
                                                          horizontal: 11.0.sp),
                                                  hintText: "ADDRESS",
                                                  hintStyle: TextStyle(
                                                      color: AppColor
                                                          .secondaryColor,
                                                      fontSize: 12.sp,
                                                      fontFamily: "Inter",
                                                      fontWeight:
                                                          FontWeight.w500),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color:
                                                            AppColor.greyColor),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0.sp),
                                                  ),
                                                  border: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color:
                                                            AppColor.greyColor),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0.sp),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 3.h,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 8.w),
                                            child: MaterialButton(
                                              height: 6.h,
                                              color: AppColor.primaryColor,
                                              minWidth: double.infinity,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.sp)),
                                              onPressed: () async {
                                                FocusScope.of(context)
                                                    .requestFocus(
                                                        new FocusNode());
                                                updateLoading.value = true;
                                                print(
                                                    "loader-------${getStudentsDetailsController.isLoading.value}");
                                                UpdateStudentDetailsReqModel
                                                    updateStudentDetailsReqModel =
                                                    UpdateStudentDetailsReqModel();
                                                /*UpdateStudentDetailsReqModel(
                                                        studentId: int.parse(
                                                            getStudentsDetailsController
                                                                .StudentDetailsList!
                                                                .studentDetails!
                                                                .studentId!),
                                                        fullName:
                                                            nameController!
                                                                .text,
                                                        email: mailController!
                                                            .text,
                                                        phoneNo:
                                                            mobileNumberController!
                                                                .text,
                                                        address:
                                                            addressController!
                                                                .text);*/
                                                updateStudentDetailsReqModel
                                                        .studentId =
                                                    int.parse(
                                                        getStudentsDetailsController
                                                            .StudentDetailsList!
                                                            .studentDetails!
                                                            .studentId!);
                                                updateStudentDetailsReqModel
                                                        .fullName =
                                                    nameController!.text;
                                                updateStudentDetailsReqModel
                                                        .email =
                                                    mailController!.text;
                                                updateStudentDetailsReqModel
                                                        .phoneNo =
                                                    mobileNumberController!
                                                        .text;
                                                updateStudentDetailsReqModel
                                                        .address =
                                                    addressController!.text;

                                                Get.back();
                                                getStudentsDetailsController
                                                    .isLoading.value = true;

                                                /*bool result =*/
                                                await UpdateStudentDetailsRepo
                                                    .updateStudentDetailsrepo(
                                                        updateStudentDetailsReqModel);

                                                getStudentsDetailsController
                                                    .updateStudentDetails(
                                                        updateName: nameController!
                                                            .text,
                                                        updateEmail:
                                                            mailController!
                                                                .text,
                                                        updatePhoneNumber:
                                                            mobileNumberController!
                                                                .text,
                                                        updateAddress:
                                                            addressController!
                                                                .text);

                                                getStudentsDetailsController
                                                    .isLoading.value = false;

                                                /*if (result == true) {
                                                  print(
                                                      "DetailsUPDATE SUCCESSFULLY-------->>>>>>>");
                                                  Get.back(
                                                      result: {'update': true});
                                                  updateLoading.value = false;
                                                } else {
                                                  print(
                                                      "DetailsUPDATE FAILED-------->>>>>>>");
                                                  updateLoading.value = false;
                                                  Get.snackbar("Message",
                                                      "Update Failed.....");
                                                }*/
                                              },
                                              child: Text(
                                                "Update",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 13.sp,
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: "Inter",
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 3.h,
                                          ),
                                        ],
                                      );
                                    });
                              },
                              child: Text("Update",
                                  style: TextStyle(
                                      fontFamily: 'Inter',
                                      color: AppColor.secondaryColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14.sp)),
                            )),
                        // popupmenu item 2
                        PopupMenuItem(
                          value: 2,
                          // row has two child icon and text
                          child: Text("Delete",
                              style: TextStyle(
                                  fontFamily: 'Inter',
                                  color: AppColor.secondaryColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14.sp)),
                        ),
                      ],
                    ),
                  ],
                ),
                body: GetBuilder(
                  builder: (GetStudentsDetailsController controller) {
                    return Stack(
                      children: [
                        controller.isInitialLoading.value
                            ? AppProgressLoader()
                            : Builder(builder: (context) {
                                final tagName = getStudentsDetailsController
                                    .StudentDetailsList!.studentDetails!.course;
                                print("TAGNAME---------------------${tagName}");
                                final course = tagName!.split(',');
                                print("COURSE---------------------${course}");

                                return SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  physics: BouncingScrollPhysics(),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: width * 0.017.w),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Student Details",
                                              style: TextStyle(
                                                color: AppColor.blackColor,
                                                fontSize: 30.sp,
                                                fontWeight: FontWeight.w600,
                                                fontFamily: "Inter",
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: height * 0.003.h,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: width * 0.017.w),
                                        child: Container(
                                          height: height * 0.025.h,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(top: 5.sp),
                                                child: Container(
                                                  height: 85.sp,
                                                  width: 85.sp,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.sp),
                                                      image: DecorationImage(
                                                          image: NetworkImage(
                                                              "${getStudentsDetailsController.StudentDetailsList!.studentDetails!.avatar}"),
                                                          fit: BoxFit.cover)),
                                                ),
                                              ),
                                              SizedBox(
                                                width: width * 0.035.sp,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 0, bottom: 15),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "${getStudentsDetailsController.StudentDetailsList!.studentDetails!.fullName}",
                                                      style: TextStyle(
                                                        color:
                                                            AppColor.blackColor,
                                                        fontSize: 18.sp,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontFamily: "Inter",
                                                      ),
                                                    ),
                                                    Text(
                                                      "${getStudentsDetailsController.StudentDetailsList!.studentDetails!.email}",
                                                      style: TextStyle(
                                                          fontSize: 13.sp,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontFamily: "Inter",
                                                          color: Color(
                                                              0xff868585)),
                                                    ),
                                                    Text(
                                                      "ENRL NO: CLKH${DateFormat('yyyy').format((getStudentsDetailsController.StudentDetailsList!.studentDetails!.joiningDate)!)}${getStudentsDetailsController.StudentDetailsList!.studentDetails!.studentId}",
                                                      style: TextStyle(
                                                          fontSize: 13.sp,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontFamily: "Inter",
                                                          color: Color(
                                                              0xff868585)),
                                                    ),
                                                    Text(
                                                      "Joining at : ${DateFormat('dd-MM-yyyy').format((getStudentsDetailsController.StudentDetailsList!.studentDetails!.joiningDate)!)} ",
                                                      style: TextStyle(
                                                          fontSize: 13.sp,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontFamily: "Inter",
                                                          color: Color(
                                                              0xff868585)),
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          "Status : ",
                                                          style: TextStyle(
                                                              fontSize: 13.sp,
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
                                                                            color:
                                                                                AppColor.blackColor,
                                                                            fontSize:
                                                                                16.sp,
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
                                                                                13.sp,
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
                                                                                fontSize: 15.sp,
                                                                                fontWeight: FontWeight.w600,
                                                                                fontFamily: "Inter",
                                                                              ),
                                                                            ),
                                                                            onPressed:
                                                                                () async {
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
                                                                            onPressed:
                                                                                () {
                                                                              Get.back();
                                                                            },
                                                                            child:
                                                                                Text(
                                                                              "Cancel",
                                                                              style: TextStyle(
                                                                                color: AppColor.primaryColor.withOpacity(0.5),
                                                                                fontSize: 15.sp,
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
                                                                fontSize: 13.sp,
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
                                                    )
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: height * 0.0018.h,
                                      ),
                                      Divider(
                                          height: 1.h,
                                          color: Color(0xffE5E5E5)),
                                      /*SizedBox(
                  height: height * 0.001.h,
                ),*/
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: width * 0.017.w),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                  border: Border(
                                                      bottom: BorderSide(
                                                color: Color(0xffE5E5E5),
                                                width:
                                                    1.0, // Underline thickness
                                              ))),
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: height * 0.001.h),
                                                child: Text(
                                                  "Contact Info",
                                                  style: TextStyle(
                                                    color: AppColor.blackColor,
                                                    fontSize: 18.sp,
                                                    fontWeight: FontWeight.w600,
                                                    fontFamily: "Inter",
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: height * 0.0018.h,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: width * 0.017.w),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Mobile No : ${getStudentsDetailsController.StudentDetailsList!.studentDetails!.mobile}",
                                              style: TextStyle(
                                                  fontSize: 13.sp,
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily: "Inter",
                                                  color: Color(0xff868585)),
                                            )
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: height * 0.0018.h,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: width * 0.017.w),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Address    : ",
                                              style: TextStyle(
                                                  fontSize: 13.sp,
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily: "Inter",
                                                  color: Color(0xff868585)),
                                            ),
                                            Container(
                                              child: Expanded(
                                                  child: Text(
                                                "${getStudentsDetailsController.StudentDetailsList!.studentDetails!.address}",
                                                style: TextStyle(
                                                    height: 0.17.h,
                                                    fontSize: 13.sp,
                                                    fontWeight: FontWeight.w400,
                                                    fontFamily: "Inter",
                                                    color: Color(0xff868585)),
                                              )),
                                            )
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: height * 0.003.h,
                                      ),
                                      Divider(
                                          height: 1.h,
                                          color: Color(0xffE5E5E5)),
                                      SizedBox(
                                        height: height * 0.003.h,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: width * 0.017.w),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Fees Report",
                                              style: TextStyle(
                                                color: AppColor.blackColor,
                                                fontSize: 18.sp,
                                                fontWeight: FontWeight.w600,
                                                fontFamily: "Inter",
                                              ),
                                            ),
                                            //add installment button
                                            GestureDetector(
                                              onTap: () {
                                                if (GetStorage().read("role") ==
                                                    "admin") {
                                                  getStudentsDetailsController
                                                      .resetInstallmentPopup();
                                                  showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return SimpleDialog(
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        13.sp)),
                                                        children: [
                                                          Padding(
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          width *
                                                                              0.01
                                                                                  .w),
                                                              child: GetBuilder<
                                                                  GetStudentsDetailsController>(
                                                                builder:
                                                                    (GetStudentsDetailsController
                                                                        getStdDetailsController) {
                                                                  print(
                                                                      "hello");

                                                                  return VerticalStepper(
                                                                      dashLength:
                                                                          4,
                                                                      iconColor:
                                                                          Colors
                                                                              .red,
                                                                      steps: List
                                                                          .generate(
                                                                        getStdDetailsController
                                                                            .allInstallment!
                                                                            .length,
                                                                        (index) =>
                                                                            Step(
                                                                          onTap:
                                                                              () {
                                                                            //add installment

                                                                            getStdDetailsController.updateLocalInstallment(
                                                                                index: index,
                                                                                isDone: (getStdDetailsController.allInstallment![index].completed) == "0" ? "1" : "0");
                                                                          },
                                                                          title:
                                                                              "${getStdDetailsController.allInstallment![index].amount}",
                                                                          iconStyle: getStdDetailsController.allInstallment![index].completed == "0"
                                                                              ? AppColor.whiteColor
                                                                              : AppColor.primaryColor,
                                                                          icon: getStdDetailsController.allInstallment![index].completed == "0"
                                                                              ? null
                                                                              : Icon(
                                                                                  Icons.check,
                                                                                  color: Colors.white,
                                                                                  size: 13.sp,
                                                                                ),
                                                                          content: getStdDetailsController.allInstallment![index].completed == "0"
                                                                              ? "N/A"
                                                                              : "${getStdDetailsController.allInstallment![index].date!.split(" ")[0].split("-")[2]}-${getStdDetailsController.allInstallment![index].date!.split(" ")[0].split("-")[1]}-${getStdDetailsController.allInstallment![index].date!.split(" ")[0].split("-")[0]}",
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
                                                                                    size: 14.sp,
                                                                                    color: AppColor.secondaryColor,
                                                                                  ),
                                                                                )
                                                                              : SizedBox(),
                                                                        ),
                                                                      ));
                                                                },
                                                              )),
                                                          SizedBox(
                                                            height: height *
                                                                0.002.h,
                                                          ),
                                                          Padding(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        width *
                                                                            0.025.w),
                                                            child:
                                                                MaterialButton(
                                                              height: height *
                                                                  0.007.h,
                                                              minWidth: width *
                                                                  0.09.w,
                                                              color: AppColor
                                                                  .primaryColor,
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8.sp),
                                                              ),
                                                              onPressed:
                                                                  () async {
                                                                //update installment

                                                                Get.back();
                                                                await getStudentsDetailsController
                                                                    .updateServerInstallment(
                                                                        widget
                                                                            .studentId);
                                                              },
                                                              child: Center(
                                                                child: Text(
                                                                  "Update",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          11.sp,
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
                                                          ),
                                                        ],
                                                      );
                                                    },
                                                  ).then(
                                                      (_) => setState(() {}));
                                                } else {
                                                  Get.snackbar("Message",
                                                      "you doesn't permission to Add New Student..");
                                                }
                                              },
                                              child: Container(
                                                height: height * 0.007.h,
                                                width: width * 0.09.w,
                                                decoration: BoxDecoration(
                                                  color: AppColor.primaryColor,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.sp),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    "Add Installment",
                                                    style: TextStyle(
                                                        fontSize: 11.sp,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontFamily: "Inter",
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: width * 0.005.w),
                                        child: VerticalStepper(
                                            dashLength: 4,
                                            iconColor: Colors.red,
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
                                                        size: 13.sp,
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
                                                button: SizedBox(),
                                              ),
                                            )),
                                      ),
                                      SizedBox(
                                        height: height * 0.003.h,
                                      ),
                                      Divider(
                                          height: 1.h,
                                          color: Color(0xffE5E5E5)),
                                      SizedBox(
                                        height: height * 0.003.h,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: width * 0.017.w),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Courses Details",
                                              style: TextStyle(
                                                color: AppColor.blackColor,
                                                fontSize: 18.sp,
                                                fontWeight: FontWeight.w600,
                                                fontFamily: "Inter",
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: height * 0.004.h,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: width * 0.017.w),
                                        child: Container(
                                          height: height * 0.020.h,
                                          child: GridView.builder(
                                            itemCount: course.length,
                                            physics: BouncingScrollPhysics(),
                                            gridDelegate:
                                                SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount: 3,
                                                    mainAxisExtent:
                                                        height * 0.008.h,
                                                    crossAxisSpacing:
                                                        width * 0.006.w,
                                                    mainAxisSpacing:
                                                        height * 0.002.h),
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return GestureDetector(
                                                onLongPress: () {
                                                  if (GetStorage()
                                                              .read("role") ==
                                                          "admin" ||
                                                      GetStorage()
                                                              .read("role") ==
                                                          "faculty") {
                                                    showDialog(
                                                        context: context,
                                                        builder:
                                                            (ctx) =>
                                                                AlertDialog(
                                                                    title: Text(
                                                                      "Update Course",
                                                                      style:
                                                                          TextStyle(
                                                                        color: AppColor
                                                                            .blackColor,
                                                                        fontSize:
                                                                            16.sp,
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
                                                                            13.sp,
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
                                                                                15.sp,
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
                                                                              widget.studentId;

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
                                                                                15.sp,
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
                                                  } else {
                                                    Get.snackbar("Message",
                                                        "you doesn't permission to Add New Student..");
                                                  }
                                                },
                                                child: Container(
                                                  height: height * 0.008.h,
                                                  width: width * 0.10.w,
                                                  decoration: BoxDecoration(
                                                    color: course[index] ==
                                                            getStudentsDetailsController
                                                                .StudentDetailsList!
                                                                .studentDetails!
                                                                .currentCourse
                                                        ? AppColor.primaryColor
                                                        : AppColor
                                                            .backgroundColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.sp),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      "${course[index]}",
                                                      style: TextStyle(
                                                          fontSize: 12.sp,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontFamily: "Inter",
                                                          color: course[
                                                                      index] ==
                                                                  getStudentsDetailsController
                                                                      .StudentDetailsList!
                                                                      .studentDetails!
                                                                      .currentCourse
                                                              ? AppColor
                                                                  .whiteColor
                                                              : AppColor
                                                                  .greyColor),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: height * 0.004.h,
                                      ),
                                      Divider(
                                          height: 1.h,
                                          color: Color(0xffE5E5E5)),
                                      SizedBox(
                                        height: height * 0.003.h,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: width * 0.017.w),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Batch Details",
                                              style: TextStyle(
                                                color: AppColor.blackColor,
                                                fontSize: 18.sp,
                                                fontWeight: FontWeight.w600,
                                                fontFamily: "Inter",
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: height * 0.004.h,
                                      ),
                                      Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: width * 0.017.w),
                                          child: GetBuilder(
                                            builder:
                                                (GetStudentsDetailsController
                                                    updateBatchController) {
                                              return Container(
                                                height: height * 0.020.h,
                                                child: GridView.builder(
                                                  itemCount:
                                                      updateBatchController
                                                          .allbatch!.length,
                                                  physics:
                                                      BouncingScrollPhysics(),
                                                  gridDelegate:
                                                      SliverGridDelegateWithFixedCrossAxisCount(
                                                          crossAxisCount: 3,
                                                          mainAxisExtent:
                                                              height * 0.008.h,
                                                          crossAxisSpacing:
                                                              width * 0.006.w,
                                                          mainAxisSpacing:
                                                              height * 0.002.h),
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
                                                              context: context,
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
                                                                              16.sp,
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
                                                                              13.sp,
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
                                                                              color: AppColor.primaryColor,
                                                                              fontSize: 15.sp,
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
                                                                            updateBatchController.updateLocalBatch(
                                                                                index: index,
                                                                                isDone: (updateBatchController.allbatch![index].currentBatch) == 0 ? 1 : 0);
                                                                            getStudentsDetailsController.isLoading.value =
                                                                                true;
                                                                            await updateBatchController.updateServerBatch(widget.studentId);
                                                                            getStudentsDetailsController.isLoading.value =
                                                                                false;
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
                                                                              color: AppColor.primaryColor.withOpacity(0.5),
                                                                              fontSize: 15.sp,
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
                                                              "you doesn't permission to Add New Student..");
                                                        }
                                                      },
                                                      child: Container(
                                                        height:
                                                            height * 0.008.h,
                                                        width: width * 0.10.w,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: (updateBatchController
                                                                      .allbatch![
                                                                          index]
                                                                      .currentBatch) ==
                                                                  0
                                                              ? AppColor
                                                                  .backgroundColor
                                                              : AppColor
                                                                  .primaryColor,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.sp),
                                                        ),
                                                        child: Center(
                                                          child: Text(
                                                            "${getStudentsDetailsController.StudentDetailsList!.studentDetails!.batch![index].batch}",
                                                            style: TextStyle(
                                                                fontSize: 12.sp,
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
                                                                        .greyColor
                                                                    : AppColor
                                                                        .whiteColor),
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              );
                                            },
                                          )),
                                      SizedBox(
                                        height: height * 0.004.h,
                                      ),
                                    ],
                                  ),
                                );
                              }),
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
                ))
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

class VerticalStepper extends StatefulWidget {
  List<Step> steps;
  double dashLength;
  Color iconColor;
  VerticalStepper(
      {required this.steps, required this.dashLength, required this.iconColor});

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
              top: 23,
              left: 22.sp,
              child: DottedLine(
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
              top: 2.sp,
              left: 22.sp,
              child: DottedLine(
                direction: Axis.vertical,
                lineLength: 20,
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
          //initiallyExpanded: widget.isExpanded,
          //onExpansionChanged: widget.onExpansion,
          // expandedCrossAxisAlignment: CrossAxisAlignment.start,
          leading: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Container(
                  child: Stack(children: [
                    Container(
                      height: 23,
                      width: 23,
                      decoration: BoxDecoration(
                          color: widget.iconStyle,
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColor.greyColor)),
                      child: Center(
                        child: widget.icon,
                      ),
                    )
                    /*Icon(
                      Icons.circle,
                      color: widget.iconStyle != null
                          ? widget.iconStyle
                          : Colors.white,
                    ),*/
                  ]),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          offset: Offset(0.0, 1.5),
                          blurRadius: 0.5)
                    ],
                  ),
                ),
              ),
            ],
          ),
          title: Text(
            widget.title!,
            style: TextStyle(fontSize: 14.sp, color: AppColor.blackColor),
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

/*extension on List {
  bool checkRangeExist(index) {
    try {
      this[index];
      return true;
    } catch (e) {
      return false;
    }
  }
}*/
