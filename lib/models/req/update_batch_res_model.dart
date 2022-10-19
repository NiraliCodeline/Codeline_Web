// To parse this JSON data, do
//
//     final updateBatchResModel = updateBatchResModelFromJson(jsonString);

import 'dart:convert';

UpdateBatchReqModel updateBatchResModelFromJson(String str) =>
    UpdateBatchReqModel.fromJson(json.decode(str));

String updateBatchResModelToJson(UpdateBatchReqModel data) =>
    json.encode(data.toJson());

class UpdateBatchReqModel {
  UpdateBatchReqModel({
    this.studentId,
    this.batch,
  });

  int? studentId;
  List<Batches>? batch;

  factory UpdateBatchReqModel.fromJson(Map<String, dynamic> json) =>
      UpdateBatchReqModel(
        studentId: json["student_id"],
        batch:
            List<Batches>.from(json["batch"].map((x) => Batches.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "student_id": studentId,
        "batch": List<dynamic>.from(batch!.map((x) => x.toJson())),
      };
}

class Batches {
  Batches({
    this.batch,
    this.currentBatch,
  });

  String? batch;
  int? currentBatch;

  factory Batches.fromJson(Map<String, dynamic> json) => Batches(
        batch: json["batch"],
        currentBatch: json["current_batch"],
      );

  Map<String, dynamic> toJson() => {
        "batch": batch,
        "current_batch": currentBatch,
      };
}
