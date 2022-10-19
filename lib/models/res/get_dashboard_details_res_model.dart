// To parse this JSON data, do
//
//     final getDashboardDetailsResModel = getDashboardDetailsResModelFromJson(jsonString);

import 'dart:convert';

GetDashboardDetailsResModel getDashboardDetailsResModelFromJson(String str) =>
    GetDashboardDetailsResModel.fromJson(json.decode(str));

String getDashboardDetailsResModelToJson(GetDashboardDetailsResModel data) =>
    json.encode(data.toJson());

class GetDashboardDetailsResModel {
  GetDashboardDetailsResModel({
    this.totalStudent,
    this.totalInquiry,
    this.currentDemo,
    this.completedStudent,
  });

  int? totalStudent;
  int? totalInquiry;
  int? currentDemo;
  int? completedStudent;

  factory GetDashboardDetailsResModel.fromJson(Map<String, dynamic> json) =>
      GetDashboardDetailsResModel(
        totalStudent: json["total_student"],
        totalInquiry: json["total_inquiry"],
        currentDemo: json["current_demo"],
        completedStudent: json["completed_student"],
      );

  Map<String, dynamic> toJson() => {
        "total_student": totalStudent,
        "total_inquiry": totalInquiry,
        "current_demo": currentDemo,
        "completed_student": completedStudent,
      };
}
