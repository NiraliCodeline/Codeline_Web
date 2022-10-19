/*import 'dart:convert';

GetStudentsDetailsResModel getStudentsDetailsResModelFromJson(String str) =>
    GetStudentsDetailsResModel.fromJson(json.decode(str));

String getStudentsDetailsResModelToJson(GetStudentsDetailsResModel data) =>
    json.encode(data.toJson());

class GetStudentsDetailsResModel {
  GetStudentsDetailsResModel({
    this.studentDetails,
  });

  List<StudentDetail>? studentDetails;

  factory GetStudentsDetailsResModel.fromJson(Map<String, dynamic> json) =>
      GetStudentsDetailsResModel(
        studentDetails: List<StudentDetail>.from(
            json["student_Details"].map((x) => StudentDetail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "student_Details":
            List<dynamic>.from(studentDetails!.map((x) => x.toJson())),
      };
}

class StudentDetail {
  StudentDetail({
    this.studentId,
    this.fullName,
    this.avatar,
    this.email,
    this.joiningDate,
    this.mobile,
    this.address,
    this.course,
    this.currentCourse,
    this.batch,
    this.allInstallments,
  });

  String? studentId;
  String? fullName;
  String? avatar;
  String? email;
  DateTime? joiningDate;
  String? mobile;
  String? address;
  String? course;
  String? currentCourse;
  List<Batch>? batch;
  List<AllInstallment>? allInstallments;

  factory StudentDetail.fromJson(Map<String, dynamic> json) => StudentDetail(
        studentId: json["student_id"],
        fullName: json["full_name"],
        avatar: json["avatar"],
        email: json["email"],
        joiningDate: DateTime.parse(json["joining_date"]),
        mobile: json["mobile"],
        address: json["address"],
        course: json["course"],
        currentCourse: json["current_course"],
        batch: List<Batch>.from(json["batch"].map((x) => Batch.fromJson(x))),
        allInstallments: List<AllInstallment>.from(
            json["all_Installments"].map((x) => AllInstallment.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "student_id": studentId,
        "full_name": fullName,
        "avatar": avatar,
        "email": email,
        "joining_date":
            "${joiningDate!.year.toString().padLeft(4, '0')}-${joiningDate!.month.toString().padLeft(2, '0')}-${joiningDate!.day.toString().padLeft(2, '0')}",
        "mobile": mobile,
        "address": address,
        "course": course,
        "current_course": currentCourse,
        "batch": List<dynamic>.from(batch!.map((x) => x.toJson())),
        "all_Installments":
            List<dynamic>.from(allInstallments!.map((x) => x.toJson())),
      };
}

class AllInstallment {
  AllInstallment({
    this.installmentId,
    this.amount,
    this.date,
    this.completed,
  });

  String? installmentId;
  String? amount;
  String? date;
  String? completed;

  factory AllInstallment.fromJson(Map<String, dynamic> json) => AllInstallment(
        installmentId: json["installment_id"],
        amount: json["amount"],
        date: json["date"],
        completed: json["completed"],
      );

  Map<String, dynamic> toJson() => {
        "installment_id": installmentId,
        "amount": amount,
        "date": date,
        "completed": completed,
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
}*/

// To parse this JSON data, do
//
//     final getStudentsDetailsResModel = getStudentsDetailsResModelFromJson(jsonString);

import 'dart:convert';

GetStudentsDetailsResModel getStudentsDetailsResModelFromJson(String str) =>
    GetStudentsDetailsResModel.fromJson(json.decode(str));

String getStudentsDetailsResModelToJson(GetStudentsDetailsResModel data) =>
    json.encode(data.toJson());

class GetStudentsDetailsResModel {
  GetStudentsDetailsResModel({
    this.studentDetails,
  });

  StudentDetails? studentDetails;

  factory GetStudentsDetailsResModel.fromJson(Map<String, dynamic> json) =>
      GetStudentsDetailsResModel(
        studentDetails: StudentDetails.fromJson(json["student_Details"]),
      );

  Map<String, dynamic> toJson() => {
        "student_Details": studentDetails!.toJson(),
      };
}

class StudentDetails {
  StudentDetails({
    this.studentId,
    this.fullName,
    this.avatar,
    this.email,
    this.joiningDate,
    this.mobile,
    this.address,
    this.course,
    this.currentCourse,
    this.batch,
    this.courseCompleted,
    this.allInstallments,
  });

  String? studentId;
  String? fullName;
  String? avatar;
  String? email;
  DateTime? joiningDate;
  String? mobile;
  String? address;
  String? course;
  String? currentCourse;
  List<Batch>? batch;
  String? courseCompleted;
  List<AllInstallment>? allInstallments;

  factory StudentDetails.fromJson(Map<String, dynamic> json) => StudentDetails(
        studentId: json["student_id"],
        fullName: json["full_name"],
        avatar: json["avatar"],
        email: json["email"],
        joiningDate: DateTime.parse(json["joining_date"]),
        mobile: json["mobile"],
        address: json["address"],
        course: json["course"],
        currentCourse: json["current_course"],
        batch: List<Batch>.from(json["batch"].map((x) => Batch.fromJson(x))),
        courseCompleted: json["course_completed"],
        allInstallments: List<AllInstallment>.from(
            json["all_Installments"].map((x) => AllInstallment.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "student_id": studentId,
        "full_name": fullName,
        "avatar": avatar,
        "email": email,
        "joining_date":
            "${joiningDate!.year.toString().padLeft(4, '0')}-${joiningDate!.month.toString().padLeft(2, '0')}-${joiningDate!.day.toString().padLeft(2, '0')}",
        "mobile": mobile,
        "address": address,
        "course": course,
        "current_course": currentCourse,
        "batch": List<dynamic>.from(batch!.map((x) => x.toJson())),
        "course_completed": courseCompleted,
        "all_Installments":
            List<dynamic>.from(allInstallments!.map((x) => x.toJson())),
      };
}

class AllInstallment {
  AllInstallment({
    this.installmentId,
    this.amount,
    this.date,
    this.completed,
  });

  String? installmentId;
  String? amount;
  String? date;
  String? completed;

  factory AllInstallment.fromJson(Map<String, dynamic> json) => AllInstallment(
        installmentId: json["installment_id"],
        amount: json["amount"],
        date: json["date"],
        completed: json["completed"],
      );

  Map<String, dynamic> toJson() => {
        "installment_id": installmentId,
        "amount": amount,
        "date": date,
        "completed": completed,
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
