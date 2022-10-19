// To parse this JSON data, do
//
//     final getInquiryDetailsResModel = getInquiryDetailsResModelFromJson(jsonString);

import 'dart:convert';

GetInquiryDetailsResModel getInquiryDetailsResModelFromJson(String str) =>
    GetInquiryDetailsResModel.fromJson(json.decode(str));

String getInquiryDetailsResModelToJson(GetInquiryDetailsResModel data) =>
    json.encode(data.toJson());

class GetInquiryDetailsResModel {
  GetInquiryDetailsResModel({
    this.inquiryDetails,
  });

  List<InquiryDetail>? inquiryDetails;

  factory GetInquiryDetailsResModel.fromJson(Map<String, dynamic> json) =>
      GetInquiryDetailsResModel(
        inquiryDetails: List<InquiryDetail>.from(
            json["inquiry_details"].map((x) => InquiryDetail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "inquiry_details":
            List<dynamic>.from(inquiryDetails!.map((x) => x.toJson())),
      };
}

class InquiryDetail {
  InquiryDetail({
    this.inquiryId,
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

  String? inquiryId;
  String? fullName;
  String? email;
  String? mobile;
  DateTime? inquiryDate;
  String? education;
  String? reference;
  String? course;
  String? status;
  String? counselled;
  String? remarks;

  factory InquiryDetail.fromJson(Map<String, dynamic> json) => InquiryDetail(
        inquiryId: json["Inquiry_id"],
        fullName: json["full_name"],
        email: json["email"],
        mobile: json["mobile"],
        inquiryDate: DateTime.parse(json["inquiry_date"]),
        education: json["education"],
        reference: json["Reference"],
        course: json["course"],
        status: json["status"],
        counselled: json["counselled"],
        remarks: json["remarks"],
      );

  Map<String, dynamic> toJson() => {
        "Inquiry_id": inquiryId,
        "full_name": fullName,
        "email": email,
        "mobile": mobile,
        "inquiry_date": inquiryDate!.toIso8601String(),
        "education": education,
        "Reference": reference,
        "course": course,
        "status": status,
        "counselled": counselled,
        "remarks": remarks,
      };
}
