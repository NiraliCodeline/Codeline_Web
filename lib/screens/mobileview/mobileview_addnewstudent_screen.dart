import 'dart:io';
import 'dart:math';

import 'package:codeline_info_responsive_ui/constant/api_routes.dart';
import 'package:codeline_info_responsive_ui/constant/colors.dart';
import 'package:codeline_info_responsive_ui/constant/progress_indicator.dart';
import 'package:codeline_info_responsive_ui/controllers/add_new_student_controller.dart';
import 'package:codeline_info_responsive_ui/controllers/internet_connectivity_controller.dart';
import 'package:codeline_info_responsive_ui/models/req/add_new_student_req_model.dart';
import 'package:codeline_info_responsive_ui/repo/add_new_student_repo.dart';
import 'package:codeline_info_responsive_ui/screens/splash_screen.dart';
import 'package:codeline_info_responsive_ui/widgets/common_button.dart';
import 'package:codeline_info_responsive_ui/widgets/common_textformfeild.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

class MobileViewAddNewStudentScreen extends StatefulWidget {
  const MobileViewAddNewStudentScreen({Key? key}) : super(key: key);

  @override
  State<MobileViewAddNewStudentScreen> createState() =>
      _MobileViewAddNewStudentScreenState();
}

class _MobileViewAddNewStudentScreenState
    extends State<MobileViewAddNewStudentScreen> {
  final fullnameController = TextEditingController();
  final emailController = TextEditingController();
  final mobileNoController = TextEditingController();
  final joiningdateController = TextEditingController();
  final addressController = TextEditingController();
  final feesController = TextEditingController();
  final amountController = TextEditingController();

  AddNewStudentController _addNewStudentController =
      Get.put(AddNewStudentController());

  ConnectivityProvider connectivityController = Get.put(ConnectivityProvider());

  RxBool isLoading = false.obs;

  AddNewStudentReqModel addNewStudentReqModel = AddNewStudentReqModel();
  Future updateClick() async {
    isLoading.value = true;
    String? url = await uploadUserImage(
      fileName: "${Random().nextInt(1000)}${_image!.path.split('/').first}",
    );

    print("IMAGE URL-----------1${url}");
    addNewStudentReqModel.avatar = url;

    addNewStudentReqModel.fullName = fullnameController.text.trim();
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

  BatchesDropDown() {
    batchList.forEach((value) {
      _addNewStudentController.batches.add(value);
    });
  }

  File? _image;

  Future getImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;

    final imageTemporary = File(image.path);

    setState(() {
      this._image = imageTemporary;
    });
    print("Image---------${_image}");
  }

  Future<String?> uploadUserImage({String? fileName}) async {
    Map<String, String> header = {
      //"Authorization": '${bearerToken}',
      "Content-Type": "multipart/form-data"
    };

    print("FileName:${fileName}");
    dio.FormData formData = new dio.FormData.fromMap({
      "image_url": await dio.MultipartFile.fromFile(_image!.path,
          filename: _image!.path.split("/").last),
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

  @override
  void initState() {
    super.initState();
    connectivityController.startMonitoring();
    BatchesDropDown();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    List<String> courseItems = [
      "C",
      "C++",
      "DART",
      "FLUTTER",
      "UI/UX",
      "Node.js"
    ];

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
                        Get.back(result: {'update': false});
                        /*String? imageUrl = await uploadUserImage(
                fileName:
                    "${Random().nextInt(1000)}${_image!.path.split('/').first}",
              );
              print("DeleteAvatar URL........${imageUrl}");
              bool result =
                  await DeleteAvatarRepo.deleteAvatar(image_url: imageUrl!);
              if (result) {
                print("DeleteAvatar Done........${imageUrl}");
                Get.back();
              } else {
                print("DeleteAvatar Failed........");
              }*/
                      },
                      icon: Image(
                        height: 14.sp,
                        width: 154.sp,
                        image: AssetImage("assets/images/Vector.png"),
                      )),
                  actions: [
                    Padding(
                      padding: EdgeInsets.only(right: width * 0.008.w),
                      child: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.help_outline,
                            size: 22.sp,
                            color: AppColor.blackColor,
                          )),
                    ),
                  ],
                ),
                body: AbsorbPointer(
                  child: Stack(
                    children: [
                      SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: Form(
                          key: _formkey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: width * 0.017.w),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: height * 0.027.h,
                                      width: width * 0.11.w,
                                      //color: Colors.green,
                                      child: Stack(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Container(
                                              height: height * 0.024.h,
                                              width: width * 0.10.w,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.sp)),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        20.sp),
                                                child: _image == null
                                                    ? Image.asset(
                                                        "assets/images/person.image.png",
                                                        fit: BoxFit.cover,
                                                      )
                                                    : Image.file(
                                                        _image!,
                                                        fit: BoxFit.cover,
                                                      ),
                                              ),
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.bottomCenter,
                                            child: GestureDetector(
                                              onTap: getImage,
                                              child: Container(
                                                height: height * 0.005.h,
                                                width: width * 0.04.w,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color:
                                                            AppColor.whiteColor,
                                                        width: 1.sp),
                                                    color: Colors.grey
                                                        .withOpacity(0.5),
                                                    shape: BoxShape.circle),
                                                child: Center(
                                                    child: Icon(
                                                  Icons.camera_alt_outlined,
                                                  color: AppColor.whiteColor,
                                                  size: 15.sp,
                                                )),
                                              ),
                                            ),
                                          ),
                                          _image == null
                                              ? SizedBox()
                                              : Positioned(
                                                  right: 1,
                                                  top: 0,
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        _image = null;
                                                      });
                                                    },
                                                    child: Container(
                                                      height: 22.sp,
                                                      width: 22.sp,
                                                      decoration: BoxDecoration(
                                                          color: Colors
                                                              .red.shade700,
                                                          shape:
                                                              BoxShape.circle),
                                                      child: Icon(
                                                        Icons.close,
                                                        size: 18.sp,
                                                        color:
                                                            AppColor.whiteColor,
                                                      ),
                                                    ),
                                                  ))
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: height * 0.005.h,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: width * 0.017.w),
                                child: Common_TextFormFeild(
                                    obscure: false,
                                    controller: fullnameController,
                                    labelText: 'STUDENT FULL NAME',
                                    prefixIcon: Padding(
                                      padding: EdgeInsets.all(10.0),
                                      child: Image(
                                        image: AssetImage(
                                            "assets/images/User.png"),
                                        height: 5,
                                        width: 5,
                                        //fit: BoxFit.fill,
                                      ),
                                    )),
                              ),
                              SizedBox(
                                height: height * 0.003.h,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: width * 0.017.w),
                                child: Common_TextFormFeild(
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
                                    obscure: false,
                                    controller: emailController,
                                    keyboardType: TextInputType.emailAddress,
                                    labelText: 'EMAIL ADDRESS',
                                    prefixIcon: Padding(
                                      padding: EdgeInsets.all(11.0),
                                      child: Image(
                                        image: AssetImage(
                                            "assets/images/Mail.png"),
                                        height: 5,
                                        width: 5,
                                        //fit: BoxFit.fill,
                                      ),
                                    )),
                              ),
                              SizedBox(
                                height: height * 0.003.h,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: width * 0.017.w),
                                child: Container(
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
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
                                        padding: EdgeInsets.all(10.0),
                                        child: Image(
                                          image: AssetImage(
                                              "assets/images/Phone.png"),
                                          height: 5,
                                          width: 5,
                                          //fit: BoxFit.fill,
                                        ),
                                      ),
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 19.0.sp,
                                          horizontal: 11.0.sp),
                                      labelText: 'MOBILE NO.',
                                      labelStyle: TextStyle(
                                          color: AppColor.secondaryColor,
                                          fontSize: 14.sp,
                                          fontFamily: "Inter",
                                          fontWeight: FontWeight.w500),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: AppColor.greyColor),
                                        borderRadius:
                                            BorderRadius.circular(10.0.sp),
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: AppColor.greyColor),
                                        borderRadius:
                                            BorderRadius.circular(10.0.sp),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: height * 0.003.h,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: width * 0.017.w),
                                child: GestureDetector(
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
                                              primary: AppColor
                                                  .primaryColor, // <-- SEE HERE
                                              onPrimary: AppColor
                                                  .whiteColor, // <-- SEE HERE
                                              onSurface: AppColor
                                                  .blackColor, // <-- SEE HERE
                                            ),
                                            textButtonTheme:
                                                TextButtonThemeData(
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
                                    height: 64,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.0.sp),
                                        border: Border.all(
                                            color: AppColor.secondaryColor)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.all(11.0),
                                          child: Image(
                                            image: AssetImage(
                                                "assets/images/Calendar.png"),
                                            height: 23.sp,
                                            width: 23.sp,
                                            //fit: BoxFit.fill,
                                          ),
                                        ),
                                        _dateTime == null
                                            ? Text(
                                                'JOINING DATE',
                                                style: TextStyle(
                                                    color:
                                                        AppColor.secondaryColor,
                                                    fontSize: 14.sp,
                                                    fontFamily: "Inter",
                                                    fontWeight:
                                                        FontWeight.w500),
                                              )
                                            : Text(
                                                "${_dateTime!.day}-${_dateTime!.month}-${_dateTime!.year}",
                                                style: TextStyle(
                                                  color: AppColor.blackColor,
                                                  fontSize: 13.sp,
                                                  fontFamily: "Inter",
                                                  //fontWeight: FontWeight.w400
                                                ),
                                              ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: height * 0.003.h,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: width * 0.017.w),
                                child: Container(
                                  child: TextFormField(
                                    obscureText: false,
                                    controller: addressController,
                                    maxLines: 5,
                                    minLines: 1,
                                    keyboardType: TextInputType.multiline,
                                    decoration: InputDecoration(
                                      prefixIcon: Padding(
                                        padding: EdgeInsets.all(11.0),
                                        child: Image(
                                          image: AssetImage(
                                              "assets/images/Visit.png"),
                                          height: 5,
                                          width: 5,
                                          //fit: BoxFit.fill,
                                        ),
                                      ),
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 19.0.sp,
                                          horizontal: 11.0.sp),
                                      labelText: "ADDRESS",
                                      labelStyle: TextStyle(
                                          color: AppColor.secondaryColor,
                                          fontSize: 14.sp,
                                          fontFamily: "Inter",
                                          fontWeight: FontWeight.w500),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: AppColor.blackColor),
                                        borderRadius:
                                            BorderRadius.circular(10.0.sp),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: AppColor.secondaryColor),
                                        borderRadius:
                                            BorderRadius.circular(10.0.sp),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: height * 0.003.h,
                              ),
                              Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: width * 0.017.w),
                                  child: GetBuilder(
                                    builder: (AddNewStudentController
                                        batchController) {
                                      return Container(
                                        child: FormField<String>(
                                          builder:
                                              (FormFieldState<String> state) {
                                            return InputDecorator(
                                              decoration: InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                        vertical: 19.0.sp,
                                                        horizontal: 11.0.sp),
                                                prefixIcon: Padding(
                                                  padding: EdgeInsets.all(10.0),
                                                  child: Image(
                                                    image: AssetImage(
                                                        "assets/images/batch2.png"),
                                                    height: 3.sp,
                                                    width: 3.sp,
                                                    fit: BoxFit.fill,
                                                  ),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color:
                                                          AppColor.greyColor),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0.sp),
                                                ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: AppColor
                                                          .secondaryColor),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0.sp),
                                                ),
                                              ),
                                              child:
                                                  DropdownButtonHideUnderline(
                                                child: DropdownButton<String>(
                                                  icon: Icon(
                                                    Icons
                                                        .keyboard_arrow_down_outlined,
                                                    color:
                                                        AppColor.secondaryColor,
                                                  ),
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    //color: text_gray_color,
                                                    fontFamily:
                                                        "verdana_regular",
                                                  ),
                                                  hint: Text(
                                                    "BATCH TIME",
                                                    style: TextStyle(
                                                        color: AppColor
                                                            .secondaryColor,
                                                        fontSize: 14.sp,
                                                        fontFamily: "Inter",
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                  value: batchController
                                                      .batchSelected,
                                                  isExpanded: true,
                                                  isDense: true,
                                                  onChanged: (newValue) {
                                                    //batchController.setSelected(newValue!);
                                                    batchController
                                                            .batchSelected =
                                                        newValue!;
                                                    batchController.update();
                                                    batchController
                                                        .batchesTime = newValue;

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
                                                            color: AppColor
                                                                .secondaryColor,
                                                            fontSize: 14.sp,
                                                            fontFamily: "Inter",
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
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
                                  )),
                              SizedBox(
                                height: height * 0.003.h,
                              ),
                              Divider(
                                thickness: 1,
                                color: AppColor.greyColor,
                              ),
                              SizedBox(
                                height: height * 0.002.h,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: width * 0.017.w),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Course",
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
                                height: height * 0.003.h,
                              ),
                              GetBuilder(
                                builder: (AddNewStudentController controller) {
                                  return Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: width * 0.017.w),
                                    child: Container(
                                      height: height * 0.020.h,
                                      child: GridView.builder(
                                        physics: BouncingScrollPhysics(),
                                        itemCount: courseItems.length,
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
                                            (BuildContext context, int index) {
                                          return GestureDetector(
                                            onTap: () {
                                              if (!controller.course.contains(
                                                  courseItems[index])) {
                                                print(
                                                    "COURSE ADDED-------${courseItems[index]}");
                                                controller.addCourse(
                                                    courseItems[index]);
                                              } else {
                                                courseItems.forEach((element) {
                                                  print(
                                                      "Element---------$element");
                                                  if (courseItems[index] ==
                                                      element) {
                                                    controller
                                                        .removeCourse(element);
                                                  }
                                                });
                                              }
                                            },
                                            child: Container(
                                              height: height * 0.008.h,
                                              width: width * 0.10.w,
                                              decoration: BoxDecoration(
                                                color: controller.course
                                                        .contains(
                                                            courseItems[index])
                                                    ? AppColor.primaryColor
                                                    : AppColor.backgroundColor,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        10.sp),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  courseItems[index],
                                                  style: TextStyle(
                                                      fontSize: 12.sp,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontFamily: "Inter",
                                                      color: controller.course
                                                              .contains(
                                                                  courseItems[
                                                                      index])
                                                          ? Colors.white
                                                          : Colors.grey),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  );
                                },
                              ),
                              Divider(
                                thickness: 1,
                                color: AppColor.greyColor,
                              ),
                              SizedBox(
                                height: height * 0.003.h,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: width * 0.017.w),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Total Fees",
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
                                height: height * 0.003.h,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: width * 0.017.w),
                                child: Common_TextFormFeild(
                                  obscure: false,
                                  controller: feesController,
                                  keyboardType: TextInputType.number,
                                  labelText: 'FEES',
                                  prefixIcon: Padding(
                                    padding: EdgeInsets.all(11.0),
                                    child: Image(
                                      image: AssetImage(
                                          "assets/images/Activity Feed.png"),
                                      height: 5,
                                      width: 5,
                                      //fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: height * 0.003.h,
                              ),
                              Divider(
                                thickness: 1,
                                color: AppColor.greyColor,
                              ),
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
                                      "Installment",
                                      style: TextStyle(
                                        color: AppColor.blackColor,
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: "Inter",
                                      ),
                                    ),
                                    FloatingActionButton(
                                        elevation: 0.0,
                                        backgroundColor: AppColor.primaryColor,
                                        child: Icon(
                                          Icons.add,
                                          size: 30.sp,
                                          color: AppColor.whiteColor,
                                        ),
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return SimpleDialog(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            13.sp)),
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        "Installment",
                                                        style: TextStyle(
                                                          color:
                                                              Color(0xff3F3F3F),
                                                          fontSize: 18.sp,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontFamily: "Inter",
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: height * 0.003.h,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal:
                                                                width * 0.02.w),
                                                    child: TextFormField(
                                                      // keyboardType: TextInputType
                                                      //     .number,
                                                      obscureText: false,
                                                      controller:
                                                          amountController,
                                                      // validator: widget.validator,
                                                      decoration:
                                                          InputDecoration(
                                                        prefixIcon: Icon(
                                                          Icons
                                                              .currency_rupee_rounded,
                                                          color: AppColor
                                                              .blackColor,
                                                        ),
                                                        contentPadding:
                                                            EdgeInsets
                                                                .symmetric(
                                                                    vertical:
                                                                        6.0.sp,
                                                                    horizontal:
                                                                        5.0.sp),
                                                        labelText: 'Amount',
                                                        labelStyle: TextStyle(
                                                            color: AppColor
                                                                .secondaryColor,
                                                            fontSize: 13.sp,
                                                            fontFamily: "Inter",
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: AppColor
                                                                  .blackColor),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.0.sp),
                                                        ),
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: AppColor
                                                                  .greyColor),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.0.sp),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: height * 0.002.h,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal:
                                                                width * 0.02.w),
                                                    child: MaterialButton(
                                                      height: height * 0.008.h,
                                                      minWidth: width * 0.09.w,
                                                      color:
                                                          AppColor.primaryColor,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8.sp)),
                                                      child: Center(
                                                        child: Text(
                                                          "ADD",
                                                          style: TextStyle(
                                                              fontSize: 12.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontFamily:
                                                                  "Inter",
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ),
                                                      onPressed: () {
                                                        if (amountController
                                                                .text
                                                                .trim() !=
                                                            "") {
                                                          //amountController.text = "1000";
                                                          print(
                                                              'Asssssssss${amountController.text.split('x')}');
                                                          var first =
                                                              amountController
                                                                  .text
                                                                  .split('x')
                                                                  .first;
                                                          print(
                                                              'first${amountController.text.split('x').first}');
                                                          var last = int.parse(
                                                              amountController
                                                                  .text
                                                                  .split('x')
                                                                  .last);
                                                          print(
                                                              'last${amountController.text.split('x').last.runtimeType}');
                                                          var length =
                                                              amountController
                                                                  .text
                                                                  .split('x')
                                                                  .length;
                                                          print(
                                                              'length$length');

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

                                                          amountController
                                                              .clear();
                                                          Get.back();
                                                        }
                                                      },
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: height * 0.002.h,
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        })
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: height * 0.003.h,
                              ),
                              GetBuilder<AddNewStudentController>(
                                builder: (AddNewStudentController
                                    addNewStudentController) {
                                  return Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: width * 0.017.w),
                                      child: addNewStudentController
                                              .installments.isEmpty
                                          ? Container(
                                              height: height * 0.020.h,
                                              child: Center(
                                                child: Text(
                                                  "Please Add Installment",
                                                  style: TextStyle(
                                                      fontSize: 13.sp,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontFamily: "Inter",
                                                      color: AppColor
                                                          .secondaryColor
                                                          .withOpacity(0.8)),
                                                ),
                                              ),
                                            )
                                          : Container(
                                              height: height * 0.020.h,
                                              child: GridView.builder(
                                                physics:
                                                    BouncingScrollPhysics(),
                                                itemCount:
                                                    addNewStudentController
                                                        .installments.length,
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
                                                    onLongPress: () =>
                                                        removeInstallment(
                                                            index),
                                                    child: Container(
                                                      height: height * 0.008.h,
                                                      width: width * 0.10.w,
                                                      decoration: BoxDecoration(
                                                        color: AppColor
                                                            .primaryColor,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    10.sp),
                                                      ),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Container(
                                                            height: height *
                                                                0.006.h,
                                                            width:
                                                                width * 0.012.w,
                                                            decoration: BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle,
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .white)),
                                                            child: Center(
                                                              child: Text(
                                                                "${index + 1}",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        9.sp,
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
                                                            width:
                                                                width * 0.004.w,
                                                          ),
                                                          Text(
                                                            "${addNewStudentController.installments[index]}",
                                                            style: TextStyle(
                                                                fontSize: 12.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontFamily:
                                                                    "Inter",
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ));
                                },
                              ),
                              SizedBox(
                                height: height * 0.003.h,
                              ),
                              Divider(
                                thickness: 1,
                                color: AppColor.greyColor,
                              ),
                              SizedBox(
                                height: height * 0.005.h,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: width * 0.017.w),
                                child: CommonButton(
                                  height: height * 0.011.h,
                                  width: width * 0.30.w,
                                  onPressed: () async {
                                    print(
                                        "DATETIME---------------${dateSelected}");
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
                                        if (fullnameController.text.trim() != "" &&
                                            emailController.text.trim() != "" &&
                                            mobileNoController.text.trim() !=
                                                "" &&
                                            addressController.text.trim() !=
                                                "" &&
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
                                        Get.snackbar("Message",
                                            "Please Enter Valid Value");
                                      }
                                    } else {
                                      isLoading.value = false;
                                      Get.snackbar("Message",
                                          "Please check Fees and installment");
                                    }
                                  },
                                  child: Text(
                                    "Add & Save",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: "Inter",
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: height * 0.004.h,
                              ),
                            ],
                          ),
                        ),
                      ),
                      isLoading.value
                          ? Container(
                              color: Colors.white.withOpacity(0.8),
                              child: Center(
                                child: AppProgressLoader(),
                              ),
                            )
                          : SizedBox()
                    ],
                  ),
                  absorbing: isLoading.value,
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
                        fontSize: 15.sp,
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
                        fontSize: 15.sp,
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
}
