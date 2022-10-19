import 'package:codeline_info_responsive_ui/WebView/wenview_widgets/appbar_widgets.dart';
import 'package:codeline_info_responsive_ui/constant/colors.dart';
import 'package:codeline_info_responsive_ui/constant/progress_indicator.dart';
import 'package:codeline_info_responsive_ui/controllers/get_allInquiry_controller.dart';
import 'package:codeline_info_responsive_ui/controllers/internet_connectivity_controller.dart';
import 'package:codeline_info_responsive_ui/models/req/start_demo_req_model.dart';
import 'package:codeline_info_responsive_ui/repo/start_demo_repo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class WebviewInquiryAllStudentListScreen extends StatefulWidget {
  const WebviewInquiryAllStudentListScreen({Key? key}) : super(key: key);

  @override
  State<WebviewInquiryAllStudentListScreen> createState() =>
      _WebviewInquiryAllStudentListScreenState();
}

class _WebviewInquiryAllStudentListScreenState
    extends State<WebviewInquiryAllStudentListScreen> {
  TextEditingController searchController = TextEditingController();

  GetAllInquiryController getAllInquiryController =
      Get.put(GetAllInquiryController());

  ConnectivityProvider connectivityController = Get.put(ConnectivityProvider());

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
  }

  @override
  Widget build(BuildContext context) {
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
                                                  return buildStudentCard();
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
                                        /*showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return SimpleDialog(
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(Get.height * 0.012)),
                            children: [
                              SizedBox(
                                height: Get.height * 0.02,
                              ),
                              Padding(
                                padding:
                                EdgeInsets.symmetric(horizontal: Get.width * 0.02),
                                child: Row(
                                  children: [
                                    Container(
                                      height: Get.height * 0.09,
                                      width: Get.width * 0.045,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(Get.height * 0.012),
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
                                              image:
                                              AssetImage("assets/images/User.png"),
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
                                            borderSide:
                                            BorderSide(color: AppColor.greyColor),
                                            borderRadius: BorderRadius.circular(
                                                Get.height * 0.012),
                                          ),
                                          border: OutlineInputBorder(
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
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: Get.height * 0.02,
                              ),
                              Padding(
                                padding:
                                EdgeInsets.symmetric(horizontal: Get.width * 0.02),
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
                                              image:
                                              AssetImage("assets/images/Mail.png"),
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
                                            borderSide:
                                            BorderSide(color: AppColor.greyColor),
                                            borderRadius: BorderRadius.circular(
                                                Get.height * 0.012),
                                          ),
                                          border: OutlineInputBorder(
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
                                              image:
                                              AssetImage("assets/images/Phone.png"),
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
                                            borderSide:
                                            BorderSide(color: AppColor.greyColor),
                                            borderRadius: BorderRadius.circular(
                                                Get.height * 0.012),
                                          ),
                                          border: OutlineInputBorder(
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
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: Get.height * 0.02,
                              ),
                              Padding(
                                padding:
                                EdgeInsets.symmetric(horizontal: Get.width * 0.02),
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
                                              image: AssetImage(
                                                  "assets/images/Calendar.png"),
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
                                            borderSide:
                                            BorderSide(color: AppColor.greyColor),
                                            borderRadius: BorderRadius.circular(
                                                Get.height * 0.012),
                                          ),
                                          border: OutlineInputBorder(
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
                                              image:
                                              AssetImage("assets/images/Visit.png"),
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
                                            borderSide:
                                            BorderSide(color: AppColor.greyColor),
                                            borderRadius: BorderRadius.circular(
                                                Get.height * 0.012),
                                          ),
                                          border: OutlineInputBorder(
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
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: Get.height * 0.02,
                              ),
                              Padding(
                                padding:
                                EdgeInsets.symmetric(horizontal: Get.width * 0.02),
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
                                                  padding:
                                                  EdgeInsets.all(Get.width * 0.004),
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
                                            "Total Fess",
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
                                                    mainAxisExtent:
                                                    Get.height * 0.04,
                                                    crossAxisCount: 3,
                                                    crossAxisSpacing:
                                                    Get.width * 0.01,
                                                    mainAxisSpacing:
                                                    Get.height * 0.01),
                                                itemBuilder:
                                                    (BuildContext context, int index) {
                                                  return Container(
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                        BorderRadius.circular(
                                                            Get.height * 0.012),
                                                        color: AppColor.primaryColor),
                                                    child: Center(
                                                      child: Text(
                                                        "Course",
                                                        style: TextStyle(
                                                            fontSize:
                                                            Get.height * 0.015,
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
                                padding:
                                EdgeInsets.symmetric(horizontal: Get.width * 0.02),
                                child: Row(
                                  children: [
                                    Container(
                                      height: Get.height * 0.15,
                                      width: Get.width * 0.15,
                                      // color: Colors.yellow,
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
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
                                                    backgroundColor:
                                                    AppColor.primaryColor,
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
                                                    mainAxisExtent:
                                                    Get.height * 0.038,
                                                    crossAxisCount: 3,
                                                    crossAxisSpacing:
                                                    Get.width * 0.01,
                                                    mainAxisSpacing:
                                                    Get.height * 0.01),
                                                itemBuilder:
                                                    (BuildContext context, int index) {
                                                  return Container(
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
                                                            height: Get.height * 0.013,
                                                            width: Get.width * 0.013,
                                                            decoration: BoxDecoration(
                                                                shape: BoxShape.circle,
                                                                border: Border.all(
                                                                    color: AppColor
                                                                        .whiteColor)),
                                                            child: Center(
                                                              child: Text(
                                                                "1",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                    Get.height *
                                                                        0.011,
                                                                    fontWeight:
                                                                    FontWeight.w500,
                                                                    fontFamily: "Inter",
                                                                    color: AppColor
                                                                        .whiteColor),
                                                              ),
                                                            ),
                                                          ),
                                                          Text(
                                                            "10000",
                                                            style: TextStyle(
                                                                fontSize:
                                                                Get.height * 0.015,
                                                                fontWeight:
                                                                FontWeight.w500,
                                                                fontFamily: "Inter",
                                                                color: AppColor
                                                                    .whiteColor),
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
                                                borderRadius: BorderRadius.circular(
                                                    Get.height * 0.012)),
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
                        },
                      );*/
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
                    Container(
                      margin: EdgeInsets.symmetric(
                          vertical: Get.height * 0.04,
                          horizontal: Get.width * 0.003),
                      height: Get.height,
                      width: Get.width / 3.5,
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(Get.height * 0.02),
                          border:
                              Border.all(color: AppColor.greyColor, width: 2.0)
                          //color: Colors.green
                          ),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                              child: Row(
                                children: [
                                  Container(
                                    //margin: EdgeInsets.only(left: Get.width * 0.01),
                                    height: Get.height * 0.09,
                                    width: Get.width * 0.045,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            Get.height * 0.012),
                                        image: DecorationImage(
                                            image: AssetImage(
                                              "assets/images/Image 1.png",
                                            ),
                                            fit: BoxFit.cover)),
                                  ),
                                  SizedBox(
                                    width: Get.width * 0.01,
                                  ),
                                  Container(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Keval D. Gajera",
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
                                            "kevalgajera@gmail.com",
                                            style: TextStyle(
                                                fontSize: Get.height * 0.016,
                                                fontWeight: FontWeight.w400,
                                                fontFamily: "Inter",
                                                color: Color(0xff868585)),
                                          ),
                                        ),
                                        Text(
                                          "Joining at : 22-11-2021 ",
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
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "Mobile No  :  9563956363",
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
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "Education     :  B.C.A",
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
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "Reference     :  Social Media Ads.",
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
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "Counselled     :  Nevil Vaghasiya  ",
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
                                  itemCount: 4,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          mainAxisExtent: Get.height * 0.05,
                                          crossAxisCount: 3,
                                          crossAxisSpacing: Get.width * 0.01,
                                          mainAxisSpacing: Get.height * 0.01),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              Get.height * 0.012),
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
                              padding: EdgeInsets.only(left: Get.width * 0.02),
                              child: Container(
                                height: Get.height * 0.05,
                                width: Get.width * 0.08,
                                decoration: BoxDecoration(
                                    color: AppColor.whiteColor,
                                    borderRadius: BorderRadius.circular(
                                        Get.height * 0.012),
                                    border:
                                        Border.all(color: Color(0xffFF9900))),
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
                                    borderRadius: BorderRadius.circular(
                                        Get.height * 0.012),
                                    border:
                                        Border.all(color: Color(0xffD9D9D9))),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: Get.width * 0.02,
                                      vertical: Get.height * 0.02),
                                  child: Text(
                                    "come after 30 november for demo lecture,call after 29 november...",
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
                      ),
                    ),
                    Container(
                      height: Get.height,
                      width: Get.width / 3.5,
                      // color: Colors.red,
                      margin:
                          EdgeInsets.symmetric(horizontal: Get.width * 0.02),
                      child: Column(
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
                            itemCount: 10,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                margin:
                                    EdgeInsets.only(bottom: Get.height * 0.03),
                                height: Get.height * 0.12,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        Get.height * 0.012),
                                    border:
                                        Border.all(color: AppColor.greyColor)),
                                child: Row(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(
                                          left: Get.width * 0.01),
                                      height: Get.height * 0.09,
                                      width: Get.width * 0.045,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              Get.height * 0.012),
                                          image: DecorationImage(
                                              image: AssetImage(
                                                "assets/images/Image 1.png",
                                              ),
                                              fit: BoxFit.cover)),
                                    ),
                                    SizedBox(
                                      width: Get.width * 0.01,
                                    ),
                                    Container(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Keval D. Gajera",
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
                                              "kevalgajera@gmail.com",
                                              style: TextStyle(
                                                  fontSize: Get.height * 0.016,
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily: "Inter",
                                                  color: Color(0xff868585)),
                                            ),
                                          ),
                                          Text(
                                            "Joining at : 22-11-2021 ",
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
                              );
                            },
                          ))
                        ],
                      ),
                    ),
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

  GestureDetector buildStudentCard(
      {required String fullname, required String email, required String date}) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.only(bottom: Get.height * 0.03),
        height: Get.height * 0.12,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Get.height * 0.012),
            border: Border.all(color: AppColor.greyColor)),
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.only(left: Get.width * 0.01),
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
              width: Get.width * 0.01,
            ),
            Container(
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
          ],
        ),
      ),
    );
  }
}
