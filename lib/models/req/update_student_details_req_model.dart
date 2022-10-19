// To parse this JSON data, do
//
//     final updateStudentDetailsReqModel = updateStudentDetailsReqModelFromJson(jsonString);

import 'dart:convert';

UpdateStudentDetailsReqModel updateStudentDetailsReqModelFromJson(String str) =>
    UpdateStudentDetailsReqModel.fromJson(json.decode(str));

String updateStudentDetailsReqModelToJson(UpdateStudentDetailsReqModel data) =>
    json.encode(data.toJson());

class UpdateStudentDetailsReqModel {
  UpdateStudentDetailsReqModel({
    this.studentId,
    this.fullName,
    this.email,
    this.phoneNo,
    this.address,
  });

  int? studentId;
  String? fullName;
  String? email;
  String? phoneNo;
  String? address;

  factory UpdateStudentDetailsReqModel.fromJson(Map<String, dynamic> json) =>
      UpdateStudentDetailsReqModel(
        studentId: json["student_id"],
        fullName: json["full_name"],
        email: json["email"],
        phoneNo: json["phone_no"],
        address: json["address"],
      );

  Map<String, dynamic> toJson() => {
        "student_id": studentId,
        "full_name": fullName,
        "email": email,
        "phone_no": phoneNo,
        "address": address,
      };
}
