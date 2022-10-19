// To parse this JSON data, do
//
//     final updateIsFavouriteResModel = updateIsFavouriteResModelFromJson(jsonString);

import 'dart:convert';

UpdateIsFavouriteResModel updateIsFavouriteResModelFromJson(String str) =>
    UpdateIsFavouriteResModel.fromJson(json.decode(str));

String updateIsFavouriteResModelToJson(UpdateIsFavouriteResModel data) =>
    json.encode(data.toJson());

class UpdateIsFavouriteResModel {
  UpdateIsFavouriteResModel({
    this.studentId,
    this.favourite,
  });

  int? studentId;
  int? favourite;

  factory UpdateIsFavouriteResModel.fromJson(Map<String, dynamic> json) =>
      UpdateIsFavouriteResModel(
        studentId: json["student_id"],
        favourite: json["favourite"],
      );

  Map<String, dynamic> toJson() => {
        "student_id": studentId,
        "favourite": favourite,
      };
}
