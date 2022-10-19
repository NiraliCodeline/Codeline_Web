// To parse this JSON data, do
//
//     final startDemoReqModel = startDemoReqModelFromJson(jsonString);

import 'dart:convert';

StartDemoReqModel startDemoReqModelFromJson(String str) =>
    StartDemoReqModel.fromJson(json.decode(str));

String startDemoReqModelToJson(StartDemoReqModel data) =>
    json.encode(data.toJson());

class StartDemoReqModel {
  StartDemoReqModel({
    this.inquiryId,
    this.startDate,
    this.endDate,
  });

  int? inquiryId;
  String? startDate;
  String? endDate;

  factory StartDemoReqModel.fromJson(Map<String, dynamic> json) =>
      StartDemoReqModel(
        inquiryId: json["inquiry_id"],
        startDate: json["startDate"],
        endDate: json["endDate"],
      );

  Map<String, dynamic> toJson() => {
        "inquiry_id": inquiryId,
        "startDate": startDate,
        "endDate": endDate,
      };
}
