// To parse this JSON data, do
//
//     final getAllInquiryResModel = getAllInquiryResModelFromJson(jsonString);

import 'dart:convert';

GetAllInquiryResModel getAllInquiryResModelFromJson(String str) =>
    GetAllInquiryResModel.fromJson(json.decode(str));

String getAllInquiryResModelToJson(GetAllInquiryResModel data) =>
    json.encode(data.toJson());

class GetAllInquiryResModel {
  GetAllInquiryResModel({
    this.data,
  });

  List<Datum>? data;

  factory GetAllInquiryResModel.fromJson(Map<String, dynamic> json) =>
      GetAllInquiryResModel(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    this.inquiryId,
    this.fullName,
    this.email,
    this.inquiryDate,
  });

  String? inquiryId;
  String? fullName;
  String? email;
  DateTime? inquiryDate;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        inquiryId: json["inquiry_id"],
        fullName: json["full_name"],
        email: json["email"],
        inquiryDate: DateTime.parse(json["inquiry_date"]),
      );

  Map<String, dynamic> toJson() => {
        "inquiry_id": inquiryId,
        "full_name": fullName,
        "email": email,
        "inquiry_date": inquiryDate!.toIso8601String(),
      };
}
