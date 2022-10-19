import 'package:codeline_info_responsive_ui/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TabletViewAddNewStudentScreen extends StatefulWidget {
  const TabletViewAddNewStudentScreen({Key? key}) : super(key: key);

  @override
  State<TabletViewAddNewStudentScreen> createState() =>
      _TabletViewAddNewStudentScreenState();
}

class _TabletViewAddNewStudentScreenState
    extends State<TabletViewAddNewStudentScreen> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileNoController = TextEditingController();
  TextEditingController JoiningDateController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController feesController = TextEditingController();

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
                  left: Get.width * 0.025),
              child: Image(
                height: Get.height * 0.08,
                width: Get.width * 0.08,
                image: AssetImage("assets/images/Vector.png"),
              ),
            )),
        toolbarHeight: Get.height * 0.07,
        leadingWidth: Get.width * 0.1,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: Get.height * 0.02,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
            child: Row(
              children: [
                Container(
                  height: Get.height * 0.12,
                  width: Get.width * 0.18,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Get.height * 0.012),
                      image: DecorationImage(
                          image: AssetImage(
                            "assets/images/Image 1.png",
                          ),
                          fit: BoxFit.cover)),
                ),
                SizedBox(
                  width: Get.width * 0.055,
                ),
                Container(
                  height: Get.height * 0.07,
                  width: Get.width * 0.55,
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
            height: Get.height * 0.05,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: Get.height * 0.07,
                  width: Get.width * 0.43,
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
                      labelText: "  EMAIL ADDRESS",
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
                /*SizedBox(
                  width: Get.width * 0.03,
                ),*/
                Container(
                  height: Get.height * 0.07,
                  width: Get.width * 0.43,
                  child: TextFormField(
                    controller: mobileNoController,
                    decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(Get.height * 0.004),
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
                      labelText: "   MOBILE NO.",
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
            height: Get.height * 0.03,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: Get.height * 0.07,
                  width: Get.width * 0.43,
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
                Container(
                  height: Get.height * 0.07,
                  width: Get.width * 0.43,
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
            height: Get.height * 0.03,
          ),
          Padding(
            padding: EdgeInsets.only(left: Get.width * 0.05),
            child: Text(
              "Course",
              style: TextStyle(
                color: AppColor.blackColor,
                fontSize: Get.height * 0.019,
                fontWeight: FontWeight.w600,
                fontFamily: "Inter",
              ),
            ),
          ),
          SizedBox(
            height: Get.height * 0.02,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
            child: Container(
                height: Get.height * 0.135,
                //color: Colors.green,
                child: GridView.builder(
                  itemCount: 6,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisExtent: Get.height * 0.05,
                      crossAxisCount: 3,
                      crossAxisSpacing: Get.width * 0.025,
                      mainAxisSpacing: Get.height * 0.015),
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
                              fontSize: Get.height * 0.019,
                              fontWeight: FontWeight.w500,
                              fontFamily: "Inter",
                              color: AppColor.whiteColor),
                        ),
                      ),
                    );
                  },
                )),
          ),
          SizedBox(
            height: Get.height * 0.03,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: Get.height * 0.14,
                  width: Get.width * 0.45,
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
                        width: Get.width * 0.43,
                        child: TextFormField(
                          controller: feesController,
                          decoration: InputDecoration(
                            prefixIcon: Padding(
                              padding: EdgeInsets.all(Get.width * 0.004),
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
                            labelText: "  FEES",
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
                Container(
                  height: Get.height * 0.15,
                  width: Get.width * 0.42,
                  //color: Colors.yellow,
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
                                    borderRadius: BorderRadius.circular(
                                        Get.height * 0.012),
                                    color: AppColor.primaryColor),
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: Get.height * 0.017,
                                        width: Get.width * 0.017,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                                color: AppColor.whiteColor)),
                                        child: Center(
                                          child: Text(
                                            "1",
                                            style: TextStyle(
                                                fontSize: Get.height * 0.012,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: "Inter",
                                                color: AppColor.whiteColor),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: Get.width * 0.01,
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
              ],
            ),
          ),
          SizedBox(
            height: Get.height * 0.05,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
            child: Center(
              child: MaterialButton(
                onPressed: () {},
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(Get.height * 0.012)),
                color: AppColor.primaryColor,
                height: Get.height * 0.06,
                minWidth: Get.width * 0.35,
                child: Text(
                  "Add & Save",
                  style: TextStyle(
                      fontSize: Get.height * 0.019,
                      fontWeight: FontWeight.w500,
                      fontFamily: "Inter",
                      color: Colors.white),
                ),
              ),
            ),
          ),
          SizedBox(
            height: Get.height * 0.02,
          ),
        ],
      ),
    );
  }
}
