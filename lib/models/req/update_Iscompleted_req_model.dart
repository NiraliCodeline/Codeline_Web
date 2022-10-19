// To parse this JSON data, do
//
//     final updateIsCompletedReqModel = updateIsCompletedReqModelFromJson(jsonString);

import 'dart:convert';

UpdateIsCompletedReqModel updateIsCompletedReqModelFromJson(String str) =>
    UpdateIsCompletedReqModel.fromJson(json.decode(str));

String updateIsCompletedReqModelToJson(UpdateIsCompletedReqModel data) =>
    json.encode(data.toJson());

class UpdateIsCompletedReqModel {
  UpdateIsCompletedReqModel({
    this.studentId,
    this.courseCompleted,
  });

  int? studentId;
  int? courseCompleted;

  factory UpdateIsCompletedReqModel.fromJson(Map<String, dynamic> json) =>
      UpdateIsCompletedReqModel(
        studentId: json["student_id"],
        courseCompleted: json["course_completed"],
      );

  Map<String, dynamic> toJson() => {
        "student_id": studentId,
        "course_completed": courseCompleted,
      };
}
