// To parse this JSON data, do
//
//     final feesReportReqModel = feesReportReqModelFromJson(jsonString);

import 'dart:convert';

FeesReportReqModel feesReportReqModelFromJson(String str) =>
    FeesReportReqModel.fromJson(json.decode(str));

String feesReportReqModelToJson(FeesReportReqModel data) =>
    json.encode(data.toJson());

class FeesReportReqModel {
  FeesReportReqModel({
    this.passcode,
  });

  String? passcode;

  factory FeesReportReqModel.fromJson(Map<String, dynamic> json) =>
      FeesReportReqModel(
        passcode: json["passcode"],
      );

  Map<String, dynamic> toJson() => {
        "passcode": passcode,
      };
}
