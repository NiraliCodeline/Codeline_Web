import 'package:codeline_info_responsive_ui/constant/colors.dart';
import 'package:codeline_info_responsive_ui/constant/progress_indicator.dart';
import 'package:codeline_info_responsive_ui/controllers/get_all_fev_student_controller.dart';
import 'package:codeline_info_responsive_ui/controllers/get_all_students_controller.dart';
import 'package:codeline_info_responsive_ui/controllers/get_students_details_controller.dart';
import 'package:codeline_info_responsive_ui/controllers/internet_connectivity_controller.dart';
import 'package:codeline_info_responsive_ui/models/req/update_Isfavourite_res_Model.dart';
import 'package:codeline_info_responsive_ui/repo/update_Isfavourite_repo.dart';
import 'package:codeline_info_responsive_ui/screens/tabletview/tabletview_addnewstudent_screen.dart';
import 'package:codeline_info_responsive_ui/screens/tabletview/tabletview_studentdetails_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:progressive_image/progressive_image.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:sizer/sizer.dart';

class TabletViewAllLangStudentList extends StatefulWidget {
  TabletViewAllLangStudentList({Key? key}) : super(key: key);

  @override
  State<TabletViewAllLangStudentList> createState() =>
      _TabletViewAllLangStudentListState();
}

int? studentId = 0;

class _TabletViewAllLangStudentListState
    extends State<TabletViewAllLangStudentList> {
  List<String> items = ["All", "C", "C++", "DART", "FLUTTER", ""];

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
                appBar: PreferredSize(
                  preferredSize: Size.fromHeight(Get.height * 0.075),
                  child: AppBar(
                    elevation: 0.0,
                    backgroundColor: AppColor.whiteColor,
                    leading: IconButton(
                        color: Colors.red,
                        onPressed: () {
                          Get.back(result: {'update': true});
                        },
                        icon: Padding(
                          padding: EdgeInsets.all(Get.height * 0.015),
                          child: Image(
                            height: Get.height * 0.08,
                            width: Get.width * 0.08,
                            image: AssetImage("assets/images/Vector.png"),
                          ),
                        )),
                    toolbarHeight: Get.height * 0.1,
                    leadingWidth: Get.width * 0.1,
                    actions: [
                      IconButton(
                        onPressed: () {
                          getAllFevStudentController.onInit();
                          //Get.to(FavouriteScreen());
                        },
                        icon: Icon(
                          Icons.favorite_outline_rounded,
                          size: Get.height * 0.04,
                          color: AppColor.blackColor,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            right: Get.width * 0.05, left: Get.width * 0.02),
                        child: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.help_outline,
                              size: Get.height * 0.04,
                              color: AppColor.blackColor,
                            )),
                      ),
                    ],
                  ),
                ),
                floatingActionButton: Container(
                  height: Get.height * 0.1,
                  width: Get.width * 0.1,
                  //color: Colors.yellow,
                  child: FloatingActionButton(
                    onPressed: () async {
                      if (GetStorage().read("role") == "admin" ||
                          GetStorage().read("role") == "hr") {
                        Get.to(TabletViewAddNewStudentScreen())!.then((value) {
                          if (value['update'])
                            getAllStudentsController.onInit();

                          print("Get new API calls");
                        });
                      } else {
                        Get.snackbar("Message",
                            "you doesn't permission to Add New Student..");
                      }
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
                body:
                    GetBuilder(builder: (GetAllStudentsController controller) {
                  if (controller.isLoading == true) {
                    return AppProgressLoader();
                  }

                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
                    height: Get.height,
                    width: Get.width,
                    child: Column(
                      children: [
                        SizedBox(
                          height: Get.height * 0.03,
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
                                  padding: EdgeInsets.all(Get.width * 0.006),
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
                                    horizontal: Get.width * 0.05),
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
                        Container(
                          height: Get.height * 0.06,
                          width: Get.width,
                          //color: AppColor.sideOpenDrawerColor,
                          child: ListView.builder(
                            physics: BouncingScrollPhysics(),
                            scrollDirection: scrollDirection,
                            controller: autoScrollController,
                            itemCount: items.length,
                            itemBuilder: (BuildContext context, int index) {
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
                                    margin: EdgeInsets.symmetric(
                                        horizontal: Get.width * 0.025),
                                    height: Get.height * 0.05,
                                    width: Get.width * 0.25,
                                    decoration: BoxDecoration(
                                        color: items[index] == ""
                                            ? AppColor.greyColor
                                                .withOpacity(0.0)
                                            : isSelected == items[index]
                                                ? AppColor.primaryColor
                                                : AppColor.sideOpenDrawerColor,
                                        borderRadius: BorderRadius.circular(
                                            Get.height * 0.012)),
                                    child: Center(
                                      child: Text(
                                        "${items[index]}",
                                        style: TextStyle(
                                          fontSize: Get.height * 0.022,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: "Inter",
                                          color: items[index] == ""
                                              ? AppColor.greyColor
                                                  .withOpacity(0.0)
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
                        ),
                        SizedBox(
                          height: Get.height * 0.03,
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
                    ),
                  );
                }),
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

  GetStudentsDetailsController getStudentsDetailsController =
      Get.put(GetStudentsDetailsController());

  GestureDetector buildContainer(
      {List<dynamic>? data, int? index, String? formattedDate, var value}) {
    return GestureDetector(
      onTap: () {
        print("Std_id: ${data[index].studentId!}");

        Get.to(TabLateViewStudentDetailsScreen(
                studentId: int.parse(data[index].studentId!)))!
            .then((value) {
          if (value['update']) getAllStudentsController.onInit();

          print("Get new API calls");
        });
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
                  margin: EdgeInsets.only(left: Get.width * 0.035),
                  height: Get.height * 0.09,
                  width: Get.width * 0.12,
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
                      width: Get.width * 0.12,
                    ),
                  ),
                ),
                SizedBox(
                  width: Get.width * 0.035,
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
                          fontSize: Get.height * 0.023,
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
                              fontSize: Get.height * 0.018,
                              fontWeight: FontWeight.w400,
                              fontFamily: "Inter",
                              color: Color(0xff868585)),
                        ),
                      ),
                      Text(
                        "Joining at : ${formattedDate}",
                        style: TextStyle(
                            fontSize: Get.height * 0.018,
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
              right: Get.width * 0.015,
              top: Get.height * 0.009,
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
