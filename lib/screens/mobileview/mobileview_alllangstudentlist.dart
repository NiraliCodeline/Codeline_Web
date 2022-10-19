import 'package:codeline_info_responsive_ui/constant/colors.dart';
import 'package:codeline_info_responsive_ui/constant/progress_indicator.dart';
import 'package:codeline_info_responsive_ui/controllers/get_all_fev_student_controller.dart';
import 'package:codeline_info_responsive_ui/controllers/get_all_students_controller.dart';
import 'package:codeline_info_responsive_ui/controllers/internet_connectivity_controller.dart';
import 'package:codeline_info_responsive_ui/models/req/update_Isfavourite_res_Model.dart';
import 'package:codeline_info_responsive_ui/repo/update_Isfavourite_repo.dart';
import 'package:codeline_info_responsive_ui/screens/mobileview/mobileview_addnewstudent_screen.dart';
import 'package:codeline_info_responsive_ui/screens/mobileview/mobileview_studentdetails.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:progressive_image/progressive_image.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:sizer/sizer.dart';

class MobileViewAllLangStudentList extends StatefulWidget {
  MobileViewAllLangStudentList({Key? key}) : super(key: key);

  @override
  State<MobileViewAllLangStudentList> createState() =>
      _MobileViewAllLangStudentListState();
}

class _MobileViewAllLangStudentListState
    extends State<MobileViewAllLangStudentList> {
  List<String> items = [
    "All",
    "C",
    "C++",
    "DART",
    "FLUTTER",
  ];

  bool isFavourite = false;

  final searchController = TextEditingController();

  GetAllStudentsController getAllStudentsController =
      Get.put(GetAllStudentsController());

  GetAllFevStudentController getAllFevStudentController =
      Get.put(GetAllFevStudentController());

  ConnectivityProvider connectivityController = Get.put(ConnectivityProvider());

  String isSelected = 'All';
  var isItemSelected = 0;

  final scrollDirection = Axis.horizontal;

  AutoScrollController? autoScrollController;

  @override
  void initState() {
    super.initState();
    connectivityController.startMonitoring();
    autoScrollController = AutoScrollController(
        viewportBoundaryGetter: () =>
            Rect.fromLTRB(0, 0, 0, MediaQuery.of(context).padding.bottom),
        axis: scrollDirection);
  }

  Future _scrollToIndex(int index) async {
    await autoScrollController!
        .scrollToIndex(index, preferPosition: AutoScrollPosition.begin);
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return GetBuilder<ConnectivityProvider>(
      builder: (controller) {
        return controller.isOnline
            ? Scaffold(
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
                    IconButton(
                      onPressed: () {
                        getAllFevStudentController.onInit();
                        //Get.to(FavouriteScreen());
                      },
                      icon: Icon(
                        Icons.favorite_outline_rounded,
                        size: 20.sp,
                        color: AppColor.blackColor,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: width * 0.010.w),
                      child: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.help_outline,
                            size: 20.sp,
                            color: AppColor.blackColor,
                          )),
                    ),
                  ],
                ),
                body:
                    GetBuilder(builder: (GetAllStudentsController controller) {
                  if (controller.isLoading == true) {
                    //print("controllerisLoading TRUe");
                    return AppProgressLoader();
                  }

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: height * 0.002.h,
                      ),
                      Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: width * 0.017.w),
                          child: Container(
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
                                    padding: EdgeInsets.all(12.0),
                                    child: Image(
                                      image:
                                          AssetImage("assets/images/icons.png"),
                                      height: 5,
                                      width: 5,
                                      //fit: BoxFit.fill,
                                    ),
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 17.0.sp, horizontal: 11.0.sp),
                                  hintText: "Search Student",
                                  hintStyle: TextStyle(
                                      color: AppColor.secondaryColor,
                                      fontSize: 14.sp,
                                      fontFamily: "Inter",
                                      fontWeight: FontWeight.w500),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: AppColor.greyColor),
                                    borderRadius:
                                        BorderRadius.circular(10.0.sp),
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: AppColor.greyColor),
                                    borderRadius:
                                        BorderRadius.circular(10.0.sp),
                                  ),
                                ),
                              ),
                            ),
                          )),
                      SizedBox(
                        height: height * 0.003.h,
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: width * 0.017.w),
                        child: Container(
                            height: height * 0.0082.h,
                            child: ListView(
                              physics: BouncingScrollPhysics(),
                              scrollDirection: scrollDirection,
                              controller: autoScrollController,
                              children: List.generate(items.length, (index) {
                                return AutoScrollTag(
                                  key: ValueKey(index),
                                  controller: autoScrollController!,
                                  index: index,
                                  child: GestureDetector(
                                    onTap: items[index] == ""
                                        ? null
                                        : () {
                                            setState(() {
                                              isSelected = items[index];
                                              isItemSelected = index;
                                            });
                                            _scrollToIndex(isItemSelected);
                                          },
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          right: width * 0.016.w),
                                      height: height * 0.008.h,
                                      width: width * 0.10.w,
                                      decoration: BoxDecoration(
                                        color: items[index] == ""
                                            ? AppColor.greyColor
                                                .withOpacity(0.0)
                                            : isSelected == items[index]
                                                ? AppColor.primaryColor
                                                : AppColor.backgroundColor,
                                        borderRadius:
                                            BorderRadius.circular(10.sp),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "${items[index]}",
                                          style: TextStyle(
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: "Inter",
                                            color: items[index] == ""
                                                ? AppColor.greyColor
                                                    .withOpacity(0.0)
                                                : isSelected == items[index]
                                                    ? Colors.white
                                                    : Colors.grey,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                            )),
                      ),
                      SizedBox(
                        height: height * 0.004.h,
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
                                          fontSize: 13.sp,
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
                                          DateFormat('yyyy-MM-dd').format(now!);

                                      var value =
                                          controller.searchResult[index];

                                      return buildGestureDetector(
                                          data: isSelected != 'All'
                                              ? controller.searchResult
                                                  .where((element) =>
                                                      element.currentCourse ==
                                                      isSelected)
                                                  .toList()
                                              : controller.searchResult,
                                          index: index,
                                          formattedDate: formattedDate,
                                          value: value);
                                    },
                                  )
                            : ListView.builder(
                                itemCount: isSelected != 'All'
                                    ? controller.allStudentList!.data!
                                        .where((element) =>
                                            element.currentCourse == isSelected)
                                        .toList()
                                        .length
                                    : controller.allStudentList!.data!.length,
                                shrinkWrap: true,
                                physics: BouncingScrollPhysics(),
                                itemBuilder: (BuildContext context, int index) {
                                  DateTime? now = getAllStudentsController
                                      .allStudentList!.data![index].joiningDate;
                                  String formattedDate =
                                      DateFormat('yyyy-MM-dd').format(now!);

                                  var value =
                                      controller.allStudentList!.data![index];

                                  return controller
                                          .allStudentList!.data!.isEmpty
                                      ? Center(
                                          child: Text(
                                            "No Student Found",
                                            style: TextStyle(
                                                fontSize: 13.sp,
                                                fontWeight: FontWeight.w400,
                                                fontFamily: "Inter",
                                                color: AppColor.secondaryColor
                                                    .withOpacity(0.8)),
                                          ),
                                        )
                                      : buildGestureDetector(
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
                              ),
                      ),
                      SizedBox(
                        height: height * 0.004.h,
                      ),
                    ],
                  );
                }),
                floatingActionButton: FloatingActionButton(
                  elevation: 0.0,
                  backgroundColor: AppColor.primaryColor,
                  child: Icon(
                    Icons.add,
                    size: 30.sp,
                    color: AppColor.whiteColor,
                  ),
                  onPressed: () async {
                    if (GetStorage().read("role") == "admin" ||
                        GetStorage().read("role") == "hr") {
                      Get.to(MobileViewAddNewStudentScreen())!.then((value) {
                        if (value['update']) getAllStudentsController.onInit();

                        print("Get new API calls");
                      });
                    } else {
                      Get.snackbar("Message",
                          "you doesn't permission to Add New Student..");
                    }
                  },
                ),
              )
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

  Padding buildGestureDetector(
      {List<dynamic>? data, int? index, String? formattedDate, var value}) {
    print('data------${data?.length}');
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.only(bottom: height * 0.003.h),
      child: Container(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.017.w),
              child: GestureDetector(
                onTap: () {
                  print("Std_id: ${data[index].studentId!}");

                  Get.to(MobileViewStudentDetails(
                          studentId: int.parse(data[index].studentId!)))!
                      .then((value) {
                    if (value['update']) getAllStudentsController.onInit();

                    print("Get new API calls");
                  });
                },
                child: Container(
                  height: height * 0.02.h,
                  child: Stack(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: 80.sp,
                            width: 80.sp,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.sp),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.sp),
                              child: ProgressiveImage(
                                placeholder:
                                    AssetImage('assets/images/Rectangle 1.png'),
                                thumbnail: NetworkImage(
                                    data![index!].avatar.toString()),
                                fit: BoxFit.cover,
                                image:
                                    NetworkImage(data[index].avatar.toString()),
                                height: 80.sp,
                                width: 80.sp,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: width * 0.035.sp,
                          ),
                          Container(
                            height: height * 0.02.h,
                            width: width * 0.15.w,
                            //color: Colors.yellow,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: height * 0.0025.h,
                                ),
                                Text(
                                  "${data[index].fullName.toString()}",
                                  style: TextStyle(
                                    color: AppColor.blackColor,
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "Inter",
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: height * 0.0012.h),
                                  child: Text(
                                    "${data[index].email.toString()}",
                                    style: TextStyle(
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: "Inter",
                                        color: Color(0xff868585)),
                                  ),
                                ),
                                Text(
                                  "Joining at : ${formattedDate}",
                                  style: TextStyle(
                                      fontSize: 13.sp,
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
                          top: -10,
                          right: -10,
                          child: IconButton(
                              onPressed: () async {
                                print(
                                    "IDF-------${int.parse(getAllStudentsController.allStudentList!.data![index].studentId!)}");
                                if (getAllStudentsController.allStudentList!
                                        .data![index].favorite ==
                                    "0") {
                                  print("IF CONDITION");
                                  getAllStudentsController.updateIsFav(
                                      index, true);
                                  isFavourite = true;

                                  print(
                                      "ADD FAVOURITE-----------${isFavourite}");
                                } else {
                                  print("ELSE CONDITION");
                                  getAllStudentsController.updateIsFav(
                                      index, false);
                                  isFavourite = false;

                                  print(
                                      "REMOVE FAVOURITE-----------${isFavourite}");
                                }
                                UpdateIsFavouriteResModel
                                    updateIsFavouriteResModel =
                                    UpdateIsFavouriteResModel();
                                updateIsFavouriteResModel.studentId = int.parse(
                                    getAllStudentsController.allStudentList!
                                        .data![index].studentId!);
                                updateIsFavouriteResModel.favourite =
                                    isFavourite == true ? 1 : 0;

                                await UpdateIsfavouriteRepo
                                    .updateIsfavouriterepo(
                                        updateIsFavouriteResModel);
                              },
                              icon: Icon(
                                getAllStudentsController.allStudentList!
                                            .data![index].favorite ==
                                        "1"
                                    ? Icons.favorite
                                    : Icons.favorite_outline_rounded,
                                color: getAllStudentsController.allStudentList!
                                            .data![index].favorite ==
                                        "1"
                                    ? AppColor.primaryColor
                                    : AppColor.secondaryColor,
                              )))
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: height * 0.003.h,
            ),
            Divider(
              height: 2,
              color: AppColor.secondaryColor,
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
