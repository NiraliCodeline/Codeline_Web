import 'dart:convert';

import 'package:codeline_info_responsive_ui/WebView/wenview_widgets/appbar_widgets.dart';
import 'package:codeline_info_responsive_ui/constant/colors.dart';
import 'package:codeline_info_responsive_ui/constant/progress_indicator.dart';
import 'package:codeline_info_responsive_ui/controllers/add_new_Inquiry_controller.dart';
import 'package:codeline_info_responsive_ui/controllers/get_Inquiry_details_controller.dart';
import 'package:codeline_info_responsive_ui/controllers/get_allInquiry_controller.dart';
import 'package:codeline_info_responsive_ui/controllers/get_all_demo_controller.dart';
import 'package:codeline_info_responsive_ui/controllers/internet_connectivity_controller.dart';
import 'package:codeline_info_responsive_ui/models/req/add_new_Inquiry_req_model.dart';
import 'package:codeline_info_responsive_ui/models/req/start_demo_req_model.dart';
import 'package:codeline_info_responsive_ui/repo/add_new_Inquiry_repo.dart';
import 'package:codeline_info_responsive_ui/repo/start_demo_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class WebviewInquiryAllStudentListScreen extends StatefulWidget {
  const WebviewInquiryAllStudentListScreen({Key? key}) : super(key: key);

  @override
  State<WebviewInquiryAllStudentListScreen> createState() =>
      _WebviewInquiryAllStudentListScreenState();
}

int? inquiryID = 0;

class _WebviewInquiryAllStudentListScreenState
    extends State<WebviewInquiryAllStudentListScreen> {
  TextEditingController searchController = TextEditingController();

  GetAllInquiryController getAllInquiryController =
      Get.put(GetAllInquiryController());

  GetAllDemoController getAllDemoController = Get.put(GetAllDemoController());

  ConnectivityProvider connectivityController = Get.put(ConnectivityProvider());

  GetInquiryDetailsController getInquiryDetailsController =
      Get.put(GetInquiryDetailsController());

  Future StartDemoClick(var data) async {
    DateTime today = DateTime.now();
    var currentDate = today.day;
    var currentMonth = today.month;
    var currentYear = today.year;

    var startDate = "${currentYear}-${currentMonth}-${currentDate}";

    print("CURRENT DATE------${startDate}");

    DateTime dayOfFutureDate = today.add(Duration(days: 3));
    var futureDate = dayOfFutureDate.day;
    var futureMonth = dayOfFutureDate.month;
    var futureYear = dayOfFutureDate.year;

    var endDate = "${futureYear}-${futureMonth}-${futureDate}";

    print("FUTURE DATE------${endDate}");

    StartDemoReqModel startDemoReqModel = StartDemoReqModel();
    startDemoReqModel.inquiryId = int.parse(data.inquiryId!);
    startDemoReqModel.startDate = startDate;
    startDemoReqModel.endDate = endDate;

    await StartDemoRepo.startDemorepo(startDemoReqModel);
  }

  @override
  void initState() {
    super.initState();
    connectivityController.startMonitoring();
    CounsellerDropDown();
  }

  @override
  Widget build(BuildContext context) {
    GetInquiryDetailsController getInquiryDetailsController =
        Get.put(GetInquiryDetailsController());
    return GetBuilder<ConnectivityProvider>(
      builder: (controller) {
        return controller.isOnline
            ? Scaffold(
                appBar: PreferredSize(
                  preferredSize: Size.fromHeight(Get.height * 0.1),
                  child: AppBarWidget(),
                ),
                body: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        height: Get.height,
                        width: Get.width / 3.5,
                        margin:
                            EdgeInsets.symmetric(horizontal: Get.width * 0.02),
                        //color: Colors.green,
                        child: GetBuilder<GetAllInquiryController>(
                          builder: (controller) {
                            if (controller.isLoading == true) {
                              return AppProgressLoader();
                            }
                            return Stack(
                              children: [
                                Column(
                                  children: [
                                    SizedBox(
                                      height: Get.height * 0.05,
                                    ),
                                    Container(
                                      child: TextFormField(
                                        controller: searchController,
                                        decoration: InputDecoration(
                                          prefixIcon: Padding(
                                            padding: EdgeInsets.all(
                                                Get.width * 0.004),
                                            child: Image(
                                              image: AssetImage(
                                                  "assets/images/icons.png"),
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
                                            borderSide: BorderSide(
                                                color: AppColor.greyColor),
                                            borderRadius: BorderRadius.circular(
                                                Get.height * 0.012),
                                          ),
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: AppColor.greyColor),
                                            borderRadius: BorderRadius.circular(
                                                Get.height * 0.012),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: AppColor.greyColor),
                                            borderRadius: BorderRadius.circular(
                                                Get.height * 0.012),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: Get.height * 0.05,
                                    ),
                                    Flexible(
                                        child: getAllInquiryController
                                                    .searchResult.isNotEmpty ||
                                                searchController.text.isNotEmpty
                                            ? getAllInquiryController
                                                    .searchResult.isEmpty
                                                ? Center(
                                                    child: Text(
                                                      "No Student Found",
                                                      style: TextStyle(
                                                          fontSize: Get.height *
                                                              0.015,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontFamily: "Inter",
                                                          color: AppColor
                                                              .secondaryColor
                                                              .withOpacity(
                                                                  0.8)),
                                                    ),
                                                  )
                                                : ListView.builder(
                                                    itemCount: controller
                                                        .searchResult.length,
                                                    shrinkWrap: true,
                                                    physics:
                                                        BouncingScrollPhysics(),
                                                    itemBuilder:
                                                        (BuildContext context,
                                                            int index) {
                                                      var value = controller
                                                          .searchResult[index];

                                                      return buildStudentCard(
                                                          id: int.parse(
                                                              value.inquiryId!),
                                                          fullname:
                                                              value.fullName!,
                                                          email: value.email!,
                                                          date: DateFormat(
                                                                  'dd-MM-yyyy')
                                                              .format((value
                                                                  .inquiryDate)!));
                                                    },
                                                  )
                                            : ListView.builder(
                                                physics:
                                                    BouncingScrollPhysics(),
                                                scrollDirection: Axis.vertical,
                                                itemCount:
                                                    getAllInquiryController
                                                        .allInquiryStudentList!
                                                        .data!
                                                        .length,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  var data =
                                                      getAllInquiryController
                                                          .allInquiryStudentList!
                                                          .data![index];
                                                  return buildStudentCard(
                                                      id: int.parse(
                                                          data.inquiryId!),
                                                      fullname: data.fullName!,
                                                      email: data.email!,
                                                      date: DateFormat(
                                                              'dd-MM-yyyy')
                                                          .format((data
                                                              .inquiryDate)!));
                                                },
                                              ))
                                  ],
                                ),
                                Positioned(
                                  bottom: Get.height * 0.02,
                                  right: Get.width * 0.01,
                                  child: Container(
                                    height: Get.height * 0.07,
                                    width: Get.width * 0.06,
                                    child: FloatingActionButton(
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return Form(
                                                key: _formkey,
                                                child: buildSimpleDialog());
                                          },
                                        ).then((value) {
                                          if (value['update'])
                                            getAllInquiryController
                                                .fetchAllInquiryStudent();
                                          print("New API calls");
                                        });
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
                                )
                              ],
                            );
                          },
                        )),
                    GetBuilder(
                      builder: (GetAllInquiryController controller) {
                        if (getAllInquiryController.id == 0) {
                          return SizedBox();
                        }
                        return Container(
                            margin: EdgeInsets.symmetric(
                                vertical: Get.height * 0.04,
                                horizontal: Get.width * 0.003),
                            height: Get.height,
                            width: Get.width / 3.5,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(Get.height * 0.02),
                                border: Border.all(
                                    color: AppColor.greyColor, width: 2.0)
                                //color: Colors.green
                                ),
                            child: GetBuilder<GetInquiryDetailsController>(
                              builder: (controller) {
                                print(
                                    "Ingnjjdbfvfvfvhf---------${getInquiryDetailsController.isLoading.value}");
                                if (getInquiryDetailsController
                                        .isLoading.value ==
                                    true) {
                                  print(
                                      "IsLoader----------${controller.isLoading.value}");
                                  return AppProgressLoader();
                                }
                                final tagName = getInquiryDetailsController
                                    .allInquiryDetailsList!
                                    .inquiryDetails![0]
                                    .course;
                                print("TAGNAME---------------------${tagName}");
                                final course = tagName!.split(',');
                                print("COURSE---------------------${course}");
                                print(
                                    "------------------${getInquiryDetailsController.allInquiryDetailsList!.inquiryDetails![0].fullName}");
                                var data = getInquiryDetailsController
                                    .allInquiryDetailsList!.inquiryDetails![0];
                                return SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: Get.height * 0.03,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: Get.width * 0.02),
                                        child: Text(
                                          "Inquiry Details",
                                          style: TextStyle(
                                            color: AppColor.blackColor,
                                            fontSize: Get.height * 0.033,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: "Inter",
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: Get.height * 0.025,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: Get.width * 0.02),
                                        child: Container(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "${data.fullName}",
                                                style: TextStyle(
                                                  color: AppColor.blackColor,
                                                  fontSize: Get.height * 0.021,
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: "Inter",
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical:
                                                        Get.height * 0.005),
                                                child: Text(
                                                  "${data.email}",
                                                  style: TextStyle(
                                                      fontSize:
                                                          Get.height * 0.016,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontFamily: "Inter",
                                                      color: Color(0xff868585)),
                                                ),
                                              ),
                                              Text(
                                                "Joining at : ${DateFormat('dd-MM-yyyy').format((data.inquiryDate)!)} ",
                                                style: TextStyle(
                                                    fontSize:
                                                        Get.height * 0.016,
                                                    fontWeight: FontWeight.w400,
                                                    fontFamily: "Inter",
                                                    color: Color(0xff868585)),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: Get.height * 0.025,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: Get.width * 0.02),
                                        child: Text(
                                          "Student Details",
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
                                              "Mobile No  :  ${data.mobile}",
                                              style: TextStyle(
                                                  fontSize: Get.height * 0.016,
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily: "Inter",
                                                  color: Color(0xff868585)),
                                            )
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: Get.height * 0.0075,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: Get.width * 0.02),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Education     :  ${data.education}",
                                              style: TextStyle(
                                                  fontSize: Get.height * 0.016,
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily: "Inter",
                                                  color: Color(0xff868585)),
                                            )
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: Get.height * 0.0075,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: Get.width * 0.02),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Reference     :  ${data.reference}",
                                              style: TextStyle(
                                                  fontSize: Get.height * 0.016,
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily: "Inter",
                                                  color: Color(0xff868585)),
                                            )
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: Get.height * 0.0075,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: Get.width * 0.02),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Counselled     :  ${data.counselled}",
                                              style: TextStyle(
                                                  fontSize: Get.height * 0.016,
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily: "Inter",
                                                  color: Color(0xff868585)),
                                            )
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: Get.height * 0.025,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: Get.width * 0.02),
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
                                        height: Get.height * 0.025,
                                      ),
                                      Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: Get.width * 0.02),
                                          height: Get.height * 0.12,
                                          //color: Colors.yellow,
                                          child: GridView.builder(
                                            itemCount: course.length,
                                            gridDelegate:
                                                SliverGridDelegateWithFixedCrossAxisCount(
                                                    mainAxisExtent:
                                                        Get.height * 0.05,
                                                    crossAxisCount: 3,
                                                    crossAxisSpacing:
                                                        Get.width * 0.01,
                                                    mainAxisSpacing:
                                                        Get.height * 0.01),
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            Get.height * 0.012),
                                                    color:
                                                        AppColor.primaryColor),
                                                child: Center(
                                                  child: Text(
                                                    "${course[index]}",
                                                    style: TextStyle(
                                                        fontSize:
                                                            Get.height * 0.015,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontFamily: "Inter",
                                                        color: AppColor
                                                            .whiteColor),
                                                  ),
                                                ),
                                              );
                                            },
                                          )),
                                      SizedBox(
                                        height: Get.height * 0.025,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: Get.width * 0.02),
                                        child: Text(
                                          "Inquiry Status",
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
                                        padding: EdgeInsets.only(
                                            left: Get.width * 0.02),
                                        child: Container(
                                          height: Get.height * 0.05,
                                          width: Get.width * 0.08,
                                          decoration: BoxDecoration(
                                              color: AppColor.whiteColor,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      Get.height * 0.012),
                                              border: Border.all(
                                                  color: Color(0xffFF9900))),
                                          child: Center(
                                            child: Text(
                                              "Pending",
                                              style: TextStyle(
                                                  fontSize: Get.height * 0.020,
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: "Inter",
                                                  color: Color(0xffFF9900)),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: Get.height * 0.025,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: Get.width * 0.02),
                                        child: Text(
                                          "Remarks",
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
                                        child: Container(
                                          // height: Get.height * 0.05,
                                          // width: Get.width * 0.08,
                                          decoration: BoxDecoration(
                                              color: AppColor.whiteColor,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      Get.height * 0.012),
                                              border: Border.all(
                                                  color: Color(0xffD9D9D9))),
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: Get.width * 0.02,
                                                vertical: Get.height * 0.02),
                                            child: Text(
                                              "${data.remarks}",
                                              style: TextStyle(
                                                  fontSize: Get.height * 0.020,
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: "Inter",
                                                  color: Color(0xff868585)),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: Get.height * 0.025,
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ));
                      },
                    ),
                    Container(
                        height: Get.height,
                        width: Get.width / 3.5,
                        // color: Colors.red,
                        margin:
                            EdgeInsets.symmetric(horizontal: Get.width * 0.02),
                        child: GetBuilder<GetAllDemoController>(
                          builder: (controller) {
                            if (controller.isLoading == true) {
                              return AppProgressLoader();
                            }

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: Get.height * 0.05,
                                ),
                                Text(
                                  "Demo Lecture",
                                  style: TextStyle(
                                    color: AppColor.blackColor,
                                    fontSize: Get.height * 0.033,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "Inter",
                                  ),
                                ),
                                SizedBox(
                                  height: Get.height * 0.05,
                                ),
                                Flexible(
                                    child: ListView.builder(
                                  physics: BouncingScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  itemCount: getAllDemoController
                                      .allDemoStudentList!.data!.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    var data = getAllDemoController
                                        .allDemoStudentList!.data![index];
                                    return Container(
                                      margin: EdgeInsets.only(
                                        bottom: Get.height * 0.03,
                                      ),
                                      height: Get.height * 0.12,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              Get.height * 0.012),
                                          border: Border.all(
                                              color: AppColor.greyColor)),
                                      child: Container(
                                        margin: EdgeInsets.only(
                                            left: Get.width * 0.02),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${data.fullName}",
                                              style: TextStyle(
                                                color: AppColor.blackColor,
                                                fontSize: Get.height * 0.021,
                                                fontWeight: FontWeight.w600,
                                                fontFamily: "Inter",
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: Get.height * 0.005),
                                              child: Text(
                                                "${data.email}",
                                                style: TextStyle(
                                                    fontSize:
                                                        Get.height * 0.016,
                                                    fontWeight: FontWeight.w400,
                                                    fontFamily: "Inter",
                                                    color: Color(0xff868585)),
                                              ),
                                            ),
                                            Text(
                                              "Joining at : ${DateFormat('dd-MM-yyyy').format((data.start)!)}",
                                              style: TextStyle(
                                                  fontSize: Get.height * 0.016,
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily: "Inter",
                                                  color: Color(0xff868585)),
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ))
                              ],
                            );
                          },
                        )),
                  ],
                ),
              )
            : Scaffold(
                body: Center(
                  child: Text(
                    "No Internet..",
                    style: TextStyle(
                      color: AppColor.blackColor,
                      fontSize: Get.height * 0.024,
                      fontWeight: FontWeight.w600,
                      fontFamily: "Inter",
                    ),
                  ),
                ),
              );
      },
    );
  }

  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileNoController = TextEditingController();
  TextEditingController inquiryDateController = TextEditingController();
  TextEditingController educationDetailsController = TextEditingController();
  final referenceController = TextEditingController();
  final remarksController = TextEditingController();

  List<String> courseItems = [
    "C",
    "C++",
    "DART",
    "FLUTTER",
    "UI/UX",
    "Node.js"
  ];

  AddNewInquiryController addNewInquiryController =
      Get.put(AddNewInquiryController());

  List<String> counselledList = ["Nikunj Malani", "Nevil Vaghasiya"];

  CounsellerDropDown() {
    counselledList.forEach((value) {
      addNewInquiryController.counsellerList.add(value);
    });
  }

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  DateTime? _dateTime;
  var dateSelected;

  AddNewInquiryReqModel addNewInquiryReqModel = AddNewInquiryReqModel();

  Future updateInquiryClick() async {
    addNewInquiryReqModel.fullName = fullNameController.text.trim();
    addNewInquiryReqModel.email = emailController.text.trim();
    addNewInquiryReqModel.mobile = mobileNoController.text.trim();
    addNewInquiryReqModel.inquiryDate = dateSelected;
    addNewInquiryReqModel.education = educationDetailsController.text.trim();
    addNewInquiryReqModel.reference = referenceController.text.trim();
    addNewInquiryReqModel.course = addNewInquiryController.course;
    addNewInquiryReqModel.status = "pending";
    addNewInquiryReqModel.counselled = addNewInquiryController.counseller;
    addNewInquiryReqModel.remarks = remarksController.text.trim();

    bool result =
        await AddNewInquiryRepo.addNewInquiryrepo(addNewInquiryReqModel);

    if (result == true) {
      print("UPDATE SUCCESSFULLY-------->>>>>>>");
      Get.back(result: {'update': true});
    } else {
      print("UPDATE FAILED-------->>>>>>>");
      Get.snackbar("Message", "Update Failed.....");
    }
  }

  StatefulBuilder buildSimpleDialog() {
    RxBool isLoading = false.obs;
    return StatefulBuilder(
      builder: (BuildContext context, void Function(void Function()) setState) {
        return AbsorbPointer(
          child: SimpleDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(Get.height * 0.012)),
            children: [
              SizedBox(
                height: Get.height * 0.02,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Get.width * 0.02),
                child: Center(
                  child: Text(
                    "Add Inquiry",
                    style: TextStyle(
                      color: AppColor.blackColor,
                      fontSize: Get.height * 0.028,
                      fontWeight: FontWeight.w600,
                      fontFamily: "Inter",
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: Get.height * 0.025,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Get.width * 0.02),
                child: Row(
                  children: [
                    Container(
                      height: Get.height * 0.07,
                      width: Get.width * 0.15,
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
                    SizedBox(
                      width: Get.width * 0.02,
                    ),
                    Container(
                      height: Get.height * 0.07,
                      width: Get.width * 0.15,
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
                              horizontal: Get.width * 0.03),
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
                  children: [
                    Container(
                      height: Get.height * 0.07,
                      width: Get.width * 0.15,
                      child: TextFormField(
                        controller: mobileNoController,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(10),
                        ],
                        keyboardType: TextInputType.number,
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
                              horizontal: Get.width * 0.03),
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
                    SizedBox(
                      width: Get.width * 0.02,
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
                        height: Get.height * 0.07,
                        width: Get.width * 0.15,
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Get.height * 0.012),
                            border: Border.all(color: AppColor.secondaryColor)),
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
                                    'INQUIRY DATE',
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
                  children: [
                    Container(
                      height: Get.height * 0.07,
                      width: Get.width * 0.15,
                      child: TextFormField(
                        controller: educationDetailsController,
                        decoration: InputDecoration(
                          prefixIcon: Padding(
                            padding: EdgeInsets.all(Get.width * 0.004),
                            child: Image(
                              image: AssetImage("assets/images/Graduate.png"),
                              height: 5,
                              width: 5,
                              //fit: BoxFit.fill,
                            ),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: Get.height * 0.025,
                              horizontal: Get.width * 0.03),
                          labelText: "EDUCATION DETAILS",
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
                    SizedBox(
                      width: Get.width * 0.02,
                    ),
                    Container(
                      height: Get.height * 0.07,
                      width: Get.width * 0.15,
                      child: TextFormField(
                        controller: referenceController,
                        decoration: InputDecoration(
                          prefixIcon: Padding(
                            padding: EdgeInsets.all(Get.width * 0.004),
                            child: Image(
                              image: AssetImage("assets/images/Document.png"),
                              height: 5,
                              width: 5,
                              //fit: BoxFit.fill,
                            ),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: Get.height * 0.025,
                              horizontal: Get.width * 0.03),
                          labelText: "HOW DID YOU KNOW ABOUT US?",
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
                  children: [
                    Container(
                      height: Get.height * 0.17,
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
                          GetBuilder<AddNewInquiryController>(
                            builder: (controller) {
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
                                              "${courseItems[index]}",
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
                    SizedBox(
                      width: Get.width * 0.02,
                    ),
                    Container(
                      height: Get.height * 0.17,
                      width: Get.width * 0.15,
                      //color: Colors.yellow,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GetBuilder<AddNewInquiryController>(
                            builder: (counsellerController) {
                              return Container(
                                height: Get.height * 0.065,
                                width: Get.width * 0.15,
                                child: FormField<String>(
                                  builder: (FormFieldState<String> state) {
                                    return InputDecorator(
                                      decoration: InputDecoration(
                                        /*contentPadding: EdgeInsets.symmetric(
                                      vertical: Get.height * 0.025,
                                      horizontal: Get.width * 0.03),*/
                                        prefixIcon: Padding(
                                          padding: EdgeInsets.all(10.0),
                                          child: Image(
                                            image: AssetImage(
                                                "assets/images/User.png"),
                                            height: 5,
                                            width: 5,
                                            //fit: BoxFit.fill,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: AppColor.greyColor),
                                          borderRadius: BorderRadius.circular(
                                              Get.height * 0.012),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: AppColor.greyColor),
                                          borderRadius: BorderRadius.circular(
                                              Get.height * 0.012),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: AppColor.greyColor),
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
                                            fontSize: 16,
                                            //color: text_gray_color,
                                            fontFamily: "Inter",
                                          ),
                                          hint: Text(
                                            "COUNSELLED BY",
                                            style: TextStyle(
                                                color: AppColor.secondaryColor,
                                                fontSize: Get.height * 0.017,
                                                fontFamily: "Inter",
                                                fontWeight: FontWeight.w500),
                                          ),
                                          value: counsellerController
                                              .counsellerSelected,
                                          isExpanded: true,
                                          isDense: true,
                                          onChanged: (newValue) {
                                            //batchController.setSelected(newValue!);
                                            counsellerController
                                                .counsellerSelected = newValue!;
                                            counsellerController.update();
                                            counsellerController.counseller =
                                                newValue;

                                            print(
                                                "NEW Counseller--------------${counsellerController.counseller}");
                                          },
                                          items: counsellerController
                                              .counsellerList
                                              .map((valueItem) {
                                            return DropdownMenuItem(
                                              value: valueItem,
                                              child: Text(
                                                valueItem,
                                                style: TextStyle(
                                                    color:
                                                        AppColor.secondaryColor,
                                                    fontSize:
                                                        Get.height * 0.017,
                                                    fontFamily: "Inter",
                                                    fontWeight:
                                                        FontWeight.w500),
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
                          SizedBox(
                            height: Get.height * 0.015,
                          ),
                          Container(
                            height: Get.height * 0.065,
                            width: Get.width * 0.15,
                            child: TextFormField(
                              controller: remarksController,
                              decoration: InputDecoration(
                                prefixIcon: Padding(
                                  padding: EdgeInsets.all(Get.width * 0.004),
                                  child: Image(
                                    image: AssetImage(
                                        "assets/images/Document.png"),
                                    height: 5,
                                    width: 5,
                                    //fit: BoxFit.fill,
                                  ),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: Get.height * 0.025,
                                    horizontal: Get.width * 0.03),
                                labelText: "REMARK",
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
                  ],
                ),
              ),
              SizedBox(
                height: Get.height * 0.025,
              ),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: Get.width * 0.07),
                  child: Obx(
                    () => isLoading.value
                        ? AppProgressLoader()
                        : MaterialButton(
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(Get.height * 0.012)),
                            color: AppColor.primaryColor,
                            height: Get.height * 0.06,
                            minWidth: Get.width * 0.1,
                            onPressed: () async {
                              FocusScope.of(context).unfocus();

                              print(
                                  "addNewInquiryController.course--------${addNewInquiryController.course}");
                              print(
                                  "addNewInquiryController.counseller----------------${addNewInquiryController.counseller}");

                              if (_formkey.currentState!.validate()) {
                                if (fullNameController.text.trim() != "" &&
                                    emailController.text.trim() != "" &&
                                    mobileNoController.text.trim() != "" &&
                                    educationDetailsController.text.trim() !=
                                        "" &&
                                    referenceController.text.trim() != "") {
                                  isLoading.value = true;

                                  print(
                                      "isLoading.value-------${isLoading.value}");
                                  updateInquiryClick();

                                  fullNameController.clear();
                                  emailController.clear();
                                  educationDetailsController.clear();
                                  mobileNoController.clear();
                                  educationDetailsController.clear();
                                  referenceController.clear();
                                  remarksController.clear();

                                  isLoading.value = false;
                                } else {
                                  isLoading.value = false;
                                  Get.snackbar("Message", "Please Enter Value");
                                }
                              } else {
                                isLoading.value = false;
                                Get.snackbar(
                                    "Message", "Please Enter Valid Value");
                              }
                            },
                            child: Text(
                              "Add & Save",
                              style: TextStyle(
                                  fontSize: Get.height * 0.019,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "Inter",
                                  color: Colors.white),
                            ),
                          ),
                  )),
              SizedBox(
                height: Get.height * 0.02,
              ),
            ],
          ),
          absorbing: isLoading.value,
        );
      },
    );
  }

  GestureDetector buildStudentCard(
      {required String fullname,
      required String email,
      required String date,
      required int id}) {
    return GestureDetector(
      onTap: () {
        inquiryID = id;
        getAllInquiryController.onItemTapped(id);
        print("STUDENT ID-------->>>>>>>>>>${inquiryID}");
        getInquiryDetailsController.fetchInquiryDetailsStudent(id: inquiryID);
      },
      child: Container(
        margin: EdgeInsets.only(bottom: Get.height * 0.03),
        height: Get.height * 0.12,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Get.height * 0.012),
            border: Border.all(color: AppColor.greyColor)),
        child: Container(
          margin: EdgeInsets.only(left: Get.width * 0.02),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                fullname,
                style: TextStyle(
                  color: AppColor.blackColor,
                  fontSize: Get.height * 0.021,
                  fontWeight: FontWeight.w600,
                  fontFamily: "Inter",
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: Get.height * 0.005),
                child: Text(
                  email,
                  style: TextStyle(
                      fontSize: Get.height * 0.016,
                      fontWeight: FontWeight.w400,
                      fontFamily: "Inter",
                      color: Color(0xff868585)),
                ),
              ),
              Text(
                "Inquiry Date : ${date} ",
                style: TextStyle(
                    fontSize: Get.height * 0.016,
                    fontWeight: FontWeight.w400,
                    fontFamily: "Inter",
                    color: Color(0xff868585)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
