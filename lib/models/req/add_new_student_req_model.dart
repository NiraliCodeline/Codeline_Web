// To parse this JSON data, do
//
//     final addNewStudentReqModel = addNewStudentReqModelFromJson(jsonString);

import 'dart:convert';

String addNewStudentReqModelToJson(AddNewStudentReqModel data) =>
    json.encode(data.toJson());

class AddNewStudentReqModel {
  AddNewStudentReqModel({
    this.avatar,
    this.fullName,
    this.email,
    this.mobile,
    this.joiningDate,
    this.address,
    this.course,
    this.totalFees,
    this.favorite,
    this.studentId,
  });

  String? avatar;
  String? fullName;
  String? email;
  String? mobile;
  String? joiningDate;
  String? address;
  List<String>? course;
  String? totalFees;
  bool? favorite;
  int? studentId;
  List<Installment> installments = [];
  List<Batch> batch = [];

  Map<String, dynamic> toJson() => {
        "avatar": avatar,
        "full_name": fullName,
        "email": email,
        "mobile": mobile,
        "joining_date": joiningDate,
        "address": address,
        "course": List<dynamic>.from(course!.map((x) => x)),
        "total_fees": totalFees,
        "favorite": favorite,
        "student_id": studentId,
        "installments": List<Map<String, dynamic>>.from(
            installments.map((x) => x.toJson())),
        "batch": List<Map<String, dynamic>>.from(batch.map((x) => x.toJson())),
      };
}

class Installment {
  Installment({
    this.amount,
    this.installmentNo,
    this.isDone,
  });

  int? amount;
  int? installmentNo;
  bool? isDone;

  factory Installment.fromJson(Map<String, dynamic> json) => Installment(
        amount: json["amount"],
        installmentNo: json["installment_no"],
        isDone: json["isDone"],
      );

  Map<String, dynamic> toJson() => {
        "amount": amount,
        "installment_no": installmentNo,
        "isDone": isDone,
      };
}

class Batch {
  Batch({
    this.batch,
    this.currentBatch,
  });

  String? batch;
  int? currentBatch;

  factory Batch.fromJson(Map<String, dynamic> json) => Batch(
        batch: json["batch"],
        currentBatch: json["current_batch"],
      );

  Map<String, dynamic> toJson() => {
        "batch": batch,
        "current_batch": currentBatch,
      };
}

/*class Batch {
  Batch({
    this.batch,
    this.currentBatch,
  });

  String? batch;
  int? currentBatch;

  factory Batch.fromJson(Map<String, dynamic> json) => Batch(
        batch: json["batch"],
        currentBatch: json["current_batch"],
      );

  Map<String, dynamic> toJson() => {
        "batch": batch,
        "current_batch": currentBatch,
      };
}*/
