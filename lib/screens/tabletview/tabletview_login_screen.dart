import 'package:codeline_info_responsive_ui/constant/colors.dart';
import 'package:codeline_info_responsive_ui/constant/progress_indicator.dart';
import 'package:codeline_info_responsive_ui/controllers/internet_connectivity_controller.dart';
import 'package:codeline_info_responsive_ui/repo/loginRepo.dart';
import 'package:codeline_info_responsive_ui/repo/two_phase_authentication_repo.dart';
import 'package:codeline_info_responsive_ui/screens/allview/allview_home_screen.dart';
import 'package:codeline_info_responsive_ui/screens/mobileview/mobileview_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class TabLateViewLogInScreen extends StatefulWidget {
  const TabLateViewLogInScreen({Key? key}) : super(key: key);

  @override
  State<TabLateViewLogInScreen> createState() => _TabLateViewLogInScreenState();
}

class _TabLateViewLogInScreenState extends State<TabLateViewLogInScreen> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  RxBool isLoading = false.obs;

  ConnectivityProvider connectivityController = Get.put(ConnectivityProvider());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ConnectivityProvider>(
      builder: (controller) {
        return controller.isOnline
            ? Scaffold(
                body: Form(
                    key: _formkey,
                    child: Obx(
                      () => AbsorbPointer(
                        child: Stack(
                          children: [
                            SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(
                                        left: Get.width * 0.05,
                                        right: Get.width * 0.05,
                                        top: Get.height * 0.05),
                                    width: Get.width * 0.55,
                                    height: Get.height / 3.5,
                                    child: SvgPicture.asset(
                                      "assets/images/Login WebView logo.svg",
                                      fit: BoxFit.fill,
                                      height: Get.height * 0.45,
                                      width: Get.width * 0.3,
                                    ),
                                  ),
                                  Container(
                                    height: Get.height / 1.65,
                                    width: Get.width,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: Get.width * 0.05),
                                    margin: EdgeInsets.symmetric(
                                        horizontal: Get.width * 0.08,
                                        vertical: Get.height * 0.028),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            Get.height * 0.015),
                                        border: Border.all(
                                            color: AppColor.primaryColor,
                                            width: Get.width * 0.001)),
                                    child: Column(
                                      //crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: Get.height * 0.05,
                                        ),
                                        Center(
                                          child: SvgPicture.asset(
                                            "assets/images/SplashScreen_Icon.svg",
                                            fit: BoxFit.fill,
                                            height: Get.height * 0.13,
                                            width: Get.width * 0.26,
                                          ),
                                        ),
                                        SizedBox(
                                          height: Get.height * 0.035,
                                        ),
                                        Text(
                                          "Login",
                                          style: TextStyle(
                                            color: AppColor.neavyBlueColor,
                                            fontSize: Get.height * 0.030,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: "Inter",
                                          ),
                                        ),
                                        SizedBox(
                                          height: Get.height * 0.035,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: Get.width * 0.015),
                                          child: Container(
                                            child: TextFormField(
                                              style: TextStyle(
                                                  fontSize: Get.height * 0.018),
                                              controller: userNameController,
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
                                              decoration: InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                        vertical:
                                                            Get.height * 0.025,
                                                        horizontal:
                                                            Get.width * 0.015),
                                                labelText: 'Username',
                                                labelStyle: TextStyle(
                                                    color:
                                                        AppColor.secondaryColor,
                                                    fontSize:
                                                        Get.height * 0.018,
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
                                                          Get.width * 0.008),
                                                ),
                                                border: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color:
                                                          AppColor.greyColor),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          Get.width * 0.008),
                                                ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color:
                                                          AppColor.greyColor),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          Get.width * 0.008),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: Get.height * 0.02,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: Get.width * 0.015),
                                          child: Container(
                                            child: TextFormField(
                                              style: TextStyle(
                                                  fontSize: Get.height * 0.018),
                                              controller: passwordController,
                                              validator: (String? value) {
                                                // add your custom validation here.
                                                if (value!.isEmpty) {
                                                  return 'Please enter some text';
                                                }
                                                if (value.length < 5) {
                                                  return 'Must be more than 5 character';
                                                }
                                                return null;
                                              },
                                              decoration: InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                        vertical:
                                                            Get.height * 0.025,
                                                        horizontal:
                                                            Get.width * 0.015),
                                                labelText: 'Password',
                                                labelStyle: TextStyle(
                                                    color:
                                                        AppColor.secondaryColor,
                                                    fontSize:
                                                        Get.height * 0.018,
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
                                                          Get.width * 0.008),
                                                ),
                                                border: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color:
                                                          AppColor.greyColor),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          Get.width * 0.008),
                                                ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color:
                                                          AppColor.greyColor),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          Get.width * 0.008),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: Get.height * 0.008,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: Get.width * 0.015),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  /*Get.to(
                                ResetPasswordScreen());*/
                                                },
                                                child: Text(
                                                  "FORGOT PASSWORD",
                                                  style: TextStyle(
                                                    color: AppColor.greyColor,
                                                    fontSize:
                                                        Get.height * 0.015,
                                                    fontWeight: FontWeight.w700,
                                                    fontFamily: "Inter",
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: Get.height * 0.035,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: Get.width * 0.015),
                                          child: MaterialButton(
                                            onPressed: () async {
                                              if (_formkey.currentState!
                                                  .validate()) {
                                                FocusScope.of(context)
                                                    .requestFocus(
                                                        new FocusNode());
                                                isLoading.value = true;

                                                var loginRes =
                                                    await LoginRepo.login(
                                                        username:
                                                            userNameController
                                                                .text
                                                                .trim(),
                                                        password:
                                                            passwordController
                                                                .text
                                                                .trim());

                                                if (loginRes['result']) {
                                                  Get.offAll(secretcodeDialog(
                                                    context,
                                                    token: loginRes['token'],
                                                    role: loginRes['role'],
                                                  ));
                                                  isLoading.value = false;
                                                } else {
                                                  isLoading.value = false;
                                                  Get.snackbar(
                                                    "Login Error",
                                                    'This Username is not found! Please try again later',
                                                  );
                                                }
                                              } else {
                                                isLoading.value = false;
                                                Get.snackbar(
                                                    "Message", "login failed!");
                                              }
                                            },
                                            height: Get.height * 0.06,
                                            minWidth: Get.width * 0.3,
                                            color: AppColor.primaryColor,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        Get.width * 0.008)),
                                            child: Text(
                                              "Login",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: Get.height * 0.024,
                                                fontWeight: FontWeight.w600,
                                                fontFamily: "Inter",
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: Get.height * 0.01,
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            isLoading.value
                                ? Container(
                                    color: Colors.white.withOpacity(0.5),
                                    child: Center(child: AppProgressLoader()),
                                  )
                                : SizedBox()
                          ],
                        ),
                        absorbing: isLoading.value,
                      ),
                    )),
              )
            : Scaffold(
                body: Center(
                  child: Text(
                    "No Internet..",
                    style: TextStyle(
                      color: AppColor.blackColor,
                      fontSize: Get.height * 0.025,
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

Future secretcodeDialog(
  BuildContext context, {
  var token,
  var role,
}) {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  RxBool isLoading = false.obs;
  TextEditingController secretcodeController = TextEditingController();
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return Form(
        key: _formkey,
        child: SimpleDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Get.height * 0.012)),
          children: [
            SizedBox(
              height: Get.height * 0.035,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
              child: Text(
                "Secret Code",
                style: TextStyle(
                  color: AppColor.neavyBlueColor,
                  fontSize: Get.height * 0.030,
                  fontWeight: FontWeight.w600,
                  fontFamily: "Inter",
                ),
              ),
            ),
            SizedBox(
              height: Get.height * 0.035,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
              child: Container(
                child: TextFormField(
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(7),
                  ],
                  controller: secretcodeController,
                  validator: (value) {
                    if (value!.length != 7) {
                      return 'Code must be of 7 digit';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                        vertical: Get.height * 0.025,
                        horizontal: Get.width * 0.015),
                    labelText: 'SECRET CODE',
                    labelStyle: TextStyle(
                        color: AppColor.secondaryColor,
                        fontSize: Get.height * 0.018,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w500),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColor.greyColor),
                      borderRadius: BorderRadius.circular(Get.width * 0.008),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColor.greyColor),
                      borderRadius: BorderRadius.circular(Get.width * 0.008),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColor.greyColor),
                      borderRadius: BorderRadius.circular(Get.width * 0.008),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: Get.height * 0.02,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
              child: isLoading.value
                  ? AppProgressLoader()
                  : MaterialButton(
                      onPressed: () async {
                        if (_formkey.currentState!.validate()) {
                          FocusScope.of(context).requestFocus(new FocusNode());
                          isLoading.value = true;
                          var result = await TwoPhaseAuthenticationRepo
                              .twoPhaseAuthMethod(
                                  code: secretcodeController.text.trim());
                          /* await Future.delayed(
                                          Duration(minutes: 5));*/
                          if (result["verify_code"] == 1) {
                            GetStorage().write('token', token);
                            GetStorage().write("role", role);
                            getDashboardDetailsController
                                .fetchAllDashboardDetails()
                                .then((value) {
                              Get.offAll(AllViewHomeScreen());
                            });
                            // Get.offAll(HomeScreen());
                          } else {
                            isLoading.value = false;
                            print("Wrong verified");
                            Get.snackbar(
                                "2 Phase Code", "Please valid verified code");
                          }
                        }
                      },
                      height: Get.height * 0.06,
                      minWidth: Get.width * 0.3,
                      color: AppColor.primaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(Get.width * 0.008)),
                      child: Text(
                        "Verification",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: Get.height * 0.024,
                          fontWeight: FontWeight.w600,
                          fontFamily: "Inter",
                        ),
                      ),
                    ),
            ),
            SizedBox(
              height: Get.height * 0.035,
            ),
          ],
        ),
      );
    },
  );
}
