// To parse this JSON data, do
//
//     final addNewInquiryReqModel = addNewInquiryReqModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

AddNewInquiryReqModel addNewInquiryReqModelFromJson(String str) =>
    AddNewInquiryReqModel.fromJson(json.decode(str));

String addNewInquiryReqModelToJson(AddNewInquiryReqModel data) =>
    json.encode(data.toJson());

class AddNewInquiryReqModel {
  AddNewInquiryReqModel({
    this.fullName,
    this.email,
    this.mobile,
    this.inquiryDate,
    this.education,
    this.reference,
    this.course,
    this.status,
    this.counselled,
    this.remarks,
  });

  String? fullName;
  String? email;
  String? mobile;
  String? inquiryDate;
  String? education;
  String? reference;
  List<dynamic>? course;
  String? status;
  String? counselled;
  String? remarks;

  factory AddNewInquiryReqModel.fromJson(Map<String, dynamic> json) =>
      AddNewInquiryReqModel(
        fullName: json["full_name"],
        email: json["email"],
        mobile: json["mobile"],
        inquiryDate: json["inquiry_date"],
        education: json["education"],
        reference: json["reference"],
        course: List<dynamic>.from(json["course"].map((x) => x)),
        status: json["status"],
        counselled: json["counselled"],
        remarks: json["remarks"],
      );

  Map<String, dynamic> toJson() => {
        "full_name": fullName,
        "email": email,
        "mobile": mobile,
        "inquiry_date": inquiryDate,
        "education": education,
        "reference": reference,
        "course": List<dynamic>.from(course!.map((x) => x)),
        "status": status,
        "counselled": counselled,
        "remarks": remarks,
      };
}
