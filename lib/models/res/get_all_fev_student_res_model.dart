// To parse this JSON data, do
//
//     final getAllFevStudentResModel = getAllFevStudentResModelFromJson(jsonString);

import 'dart:convert';

GetAllFevStudentResModel getAllFevStudentResModelFromJson(String str) =>
    GetAllFevStudentResModel.fromJson(json.decode(str));

String getAllFevStudentResModelToJson(GetAllFevStudentResModel data) =>
    json.encode(data.toJson());

class GetAllFevStudentResModel {
  GetAllFevStudentResModel({
    this.data,
  });

  List<Datum>? data;

  factory GetAllFevStudentResModel.fromJson(Map<String, dynamic> json) =>
      GetAllFevStudentResModel(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    this.studentId,
    this.fullName,
    this.avatar,
    this.email,
    this.joiningDate,
    this.currentCourse,
    this.favorite,
  });

  String? studentId;
  String? fullName;
  String? avatar;
  String? email;
  String? joiningDate;
  String? currentCourse;
  String? favorite;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        studentId: json["student_id"],
        fullName: json["full_name"],
        avatar: json["avatar"],
        email: json["email"],
        joiningDate: json["joining_date"],
        currentCourse: json["current_course"],
        favorite: json["favorite"],
      );

  Map<String, dynamic> toJson() => {
        "student_id": studentId,
        "full_name": fullName,
        "avatar": avatar,
        "email": email,
        "joining_date": joiningDate,
        "current_course": currentCourse,
        "favorite": favorite,
      };
}
