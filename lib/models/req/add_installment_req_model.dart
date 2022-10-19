// To parse this JSON data, do
//
//     final addInstallmentResModel = addInstallmentResModelFromJson(jsonString);

import 'dart:convert';

AddInstallmentReqModel addInstallmentResModelFromJson(String str) =>
    AddInstallmentReqModel.fromJson(json.decode(str));

String addInstallmentResModelToJson(AddInstallmentReqModel data) =>
    json.encode(data.toJson());

class AddInstallmentReqModel {
  AddInstallmentReqModel({
    this.studentId,
    this.installments,
  });

  int? studentId;
  List<Installment>? installments;

  factory AddInstallmentReqModel.fromJson(Map<String, dynamic> json) =>
      AddInstallmentReqModel(
        studentId: json["student_id"],
        installments: List<Installment>.from(
            json["installments"].map((x) => Installment.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "student_id": studentId,
        "installments":
            List<dynamic>.from(installments!.map((x) => x.toJson())),
      };
}

class Installment {
  Installment({
    this.date,
    this.completed,
    this.installmentId,
  });

  String? date;
  String? completed;
  int? installmentId;

  factory Installment.fromJson(Map<String, dynamic> json) => Installment(
        date: json["date"],
        completed: json["completed"],
        installmentId: json["installment_id"],
      );

  Map<String, dynamic> toJson() => {
        "date": date,
        "completed": completed,
        "installment_id": installmentId,
      };
}
