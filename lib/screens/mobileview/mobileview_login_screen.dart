import 'package:codeline_info_responsive_ui/constant/colors.dart';
import 'package:codeline_info_responsive_ui/constant/progress_indicator.dart';
import 'package:codeline_info_responsive_ui/controllers/internet_connectivity_controller.dart';
import 'package:codeline_info_responsive_ui/repo/loginRepo.dart';
import 'package:codeline_info_responsive_ui/screens/mobileview/two_phase_authentication.dart';
import 'package:codeline_info_responsive_ui/widgets/common_button.dart';
import 'package:codeline_info_responsive_ui/widgets/common_textformfeild.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class MobileViewLogInScreen extends StatefulWidget {
  const MobileViewLogInScreen({Key? key}) : super(key: key);

  @override
  State<MobileViewLogInScreen> createState() => _MobileViewLogInScreenState();
}

class _MobileViewLogInScreenState extends State<MobileViewLogInScreen> {
  final usernameTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  bool _passwordVisible = false;
  RxBool isLoading = false.obs;

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  ConnectivityProvider connectivityController = Get.put(ConnectivityProvider());

  @override
  void initState() {
    super.initState();
    connectivityController.startMonitoring();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return GetBuilder<ConnectivityProvider>(
      builder: (controller) {
        return controller.isOnline
            ? Scaffold(
                // resizeToAvoidBottomInset: false,
                backgroundColor: AppColor.backgroundColor,
                body: Stack(
                  children: [
                    Obx(() => AbsorbPointer(
                          child: SafeArea(
                            child: SingleChildScrollView(
                              child: Form(
                                key: _formkey,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    symbol(context),
                                    Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(40.0.sp),
                                          topRight: Radius.circular(40.0.sp),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: width * 0.02.w),
                                        child: Obx(() => Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  height: height * 0.006.h,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Login",
                                                      style: TextStyle(
                                                          color: AppColor
                                                              .neavyBlueColor,
                                                          fontSize: 30.sp,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontFamily: "Inter",
                                                          height: 0.8),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: height * 0.006.h,
                                                ),
                                                Common_TextFormFeild(
                                                  keyboardType: TextInputType
                                                      .emailAddress,
                                                  obscure: false,
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
                                                  controller:
                                                      usernameTextController,
                                                  labelText: "USERNAME",
                                                ),
                                                SizedBox(
                                                  height: height * 0.003.h,
                                                ),
                                                Container(
                                                  child: TextFormField(
                                                    obscureText:
                                                        !_passwordVisible,
                                                    controller:
                                                        passwordTextController,
                                                    validator: (String? value) {
                                                      // add your custom validation here.
                                                      if (value!.isEmpty) {
                                                        return 'Please enter some text';
                                                      }
                                                      if (value.length < 5) {
                                                        return 'Must be more than 5 charater';
                                                      }
                                                      return null;
                                                    },
                                                    decoration: InputDecoration(
                                                      contentPadding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 19.0.sp,
                                                              horizontal:
                                                                  11.0.sp),
                                                      labelText: "PASSWORD",
                                                      labelStyle: TextStyle(
                                                          color: AppColor
                                                              .secondaryColor,
                                                          fontSize: 14.sp,
                                                          fontFamily: "Inter",
                                                          fontWeight:
                                                              FontWeight.w500),
                                                      suffixIcon: IconButton(
                                                        icon: Icon(
                                                          // Based on passwordVisible state choose the icon
                                                          _passwordVisible
                                                              ? Icons.visibility
                                                              : Icons
                                                                  .visibility_off,
                                                          color: AppColor
                                                              .primaryColor,
                                                        ),
                                                        onPressed: () {
                                                          // Update the state i.e. toogle the state of passwordVisible variable
                                                          setState(() {
                                                            _passwordVisible =
                                                                !_passwordVisible;
                                                          });
                                                        },
                                                      ),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: AppColor
                                                                .greyColor),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    10.0.sp),
                                                      ),
                                                      border:
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
                                                  height: height * 0.0015.h,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {},
                                                      child: Text(
                                                        "FORGOT PASSWORD",
                                                        style: TextStyle(
                                                          color: AppColor
                                                              .greyColor,
                                                          fontSize: 13.sp,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          fontFamily: "Inter",
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: height * 0.006.h,
                                                ),
                                                isLoading.value
                                                    ? AppProgressLoader()
                                                    : CommonButton(
                                                        height:
                                                            height * 0.011.h,
                                                        width: width * 0.30.w,
                                                        onPressed: () async {
                                                          if (_formkey
                                                              .currentState!
                                                              .validate()) {
                                                            FocusScope.of(
                                                                    context)
                                                                .requestFocus(
                                                                    new FocusNode());
                                                            isLoading.value =
                                                                true;

                                                            var loginRes = await LoginRepo.login(
                                                                username:
                                                                    usernameTextController
                                                                        .text
                                                                        .trim(),
                                                                password:
                                                                    passwordTextController
                                                                        .text
                                                                        .trim());

                                                            if (loginRes[
                                                                'result']) {
                                                              Get.offAll(
                                                                  TwoPhaseAuthentication(
                                                                token: loginRes[
                                                                    'token'],
                                                                role: loginRes[
                                                                    'role'],
                                                              ));
                                                            } else {
                                                              isLoading.value =
                                                                  false;
                                                              Get.snackbar(
                                                                "Login Error",
                                                                'This Username is not found! Please try again later',
                                                              );
                                                            }
                                                          } else {
                                                            isLoading.value =
                                                                false;
                                                            Get.snackbar(
                                                                "Message",
                                                                "login failed!");
                                                          }
                                                        },
                                                        child: Text(
                                                          "Login",
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 16.sp,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontFamily: "Inter",
                                                          ),
                                                        ),
                                                      ),
                                                SizedBox(
                                                  height: height * 0.009.h,
                                                ),
                                              ],
                                            )),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          absorbing: isLoading.value,
                        )),
                  ],
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

  Widget symbol(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      height: height / 2.3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: Get.height * 0.06.sp,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: width * 0.038.w,
            ),
            child: SvgPicture.asset(
              "assets/images/SplashScreen_Icon.svg",
              fit: BoxFit.fill,
              height: height * 0.033.h,
            ),
          )
        ],
      ),
    );
  }
}
