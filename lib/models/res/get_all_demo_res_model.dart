// To parse this JSON data, do
//
//     final getAllDemoResModel = getAllDemoResModelFromJson(jsonString);

import 'dart:convert';

GetAllDemoResModel getAllDemoResModelFromJson(String str) =>
    GetAllDemoResModel.fromJson(json.decode(str));

String getAllDemoResModelToJson(GetAllDemoResModel data) =>
    json.encode(data.toJson());

class GetAllDemoResModel {
  GetAllDemoResModel({
    this.data,
  });

  List<Datum>? data;

  factory GetAllDemoResModel.fromJson(Map<String, dynamic> json) =>
      GetAllDemoResModel(
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
    this.start,
    this.end,
    this.afterDemoStatus,
  });

  String? inquiryId;
  String? fullName;
  String? email;
  DateTime? start;
  DateTime? end;
  String? afterDemoStatus;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        inquiryId: json["inquiry_id"],
        fullName: json["full_name"],
        email: json["email"],
        start: DateTime.parse(json["start"]),
        end: DateTime.parse(json["end"]),
        afterDemoStatus: json["after_demo_status"],
      );

  Map<String, dynamic> toJson() => {
        "inquiry_id": inquiryId,
        "full_name": fullName,
        "email": email,
        "start":
            "${start!.year.toString().padLeft(4, '0')}-${start!.month.toString().padLeft(2, '0')}-${start!.day.toString().padLeft(2, '0')}",
        "end":
            "${end!.year.toString().padLeft(4, '0')}-${end!.month.toString().padLeft(2, '0')}-${end!.day.toString().padLeft(2, '0')}",
        "after_demo_status": afterDemoStatus,
      };
}
