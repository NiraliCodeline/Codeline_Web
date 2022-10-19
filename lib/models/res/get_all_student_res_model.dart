// To parse this JSON data, do
//
//     final getAllStudentsResModel = getAllStudentsResModelFromJson(jsonString);

import 'dart:convert';

GetAllStudentsResModel getAllStudentsResModelFromJson(String str) =>
    GetAllStudentsResModel.fromJson(json.decode(str));

String getAllStudentsResModelToJson(GetAllStudentsResModel data) =>
    json.encode(data.toJson());

class GetAllStudentsResModel {
  GetAllStudentsResModel({
    this.data,
  });

  List<Datum>? data;

  factory GetAllStudentsResModel.fromJson(Map<String, dynamic> json) =>
      GetAllStudentsResModel(
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
  DateTime? joiningDate;
  String? currentCourse;
  String? favorite;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        studentId: json["student_id"],
        fullName: json["full_name"],
        avatar: json["avatar"],
        email: json["email"],
        joiningDate: DateTime.parse(json["joining_date"]),
        currentCourse: json["current_course"],
        favorite: json["favorite"],
      );

  Map<String, dynamic> toJson() => {
        "student_id": studentId,
        "full_name": fullName,
        "avatar": avatar,
        "email": email,
        "joining_date":
            "${joiningDate!.year.toString().padLeft(4, '0')}-${joiningDate!.month.toString().padLeft(2, '0')}-${joiningDate!.day.toString().padLeft(2, '0')}",
        "current_course": currentCourse,
        "favorite": favorite,
      };
}
