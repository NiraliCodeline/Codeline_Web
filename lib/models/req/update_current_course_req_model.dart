// To parse this JSON data, do
//
//     final updateCurrentCourseReqModel = updateCurrentCourseReqModelFromJson(jsonString);

import 'dart:convert';

UpdateCurrentCourseReqModel updateCurrentCourseReqModelFromJson(String str) =>
    UpdateCurrentCourseReqModel.fromJson(json.decode(str));

String updateCurrentCourseReqModelToJson(UpdateCurrentCourseReqModel data) =>
    json.encode(data.toJson());

class UpdateCurrentCourseReqModel {
  UpdateCurrentCourseReqModel({
    this.studentId,
    this.course,
  });

  int? studentId;
  String? course;

  factory UpdateCurrentCourseReqModel.fromJson(Map<String, dynamic> json) =>
      UpdateCurrentCourseReqModel(
        studentId: json["student_id"],
        course: json["course"],
      );

  Map<String, dynamic> toJson() => {
        "student_id": studentId,
        "course": course,
      };
}
