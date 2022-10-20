import 'dart:convert';
import 'package:codeline_info_responsive_ui/api_handler/handlers.dart';
import 'package:codeline_info_responsive_ui/constant/api_routes.dart';
import 'package:codeline_info_responsive_ui/constant/const.dart';
import 'package:codeline_info_responsive_ui/models/req/update_Iscompleted_req_model.dart';

class UpdateIsCompletedRepo {
  static Future<bool> updateIsCompletedrepo(
      UpdateIsCompletedReqModel updateIsCompletedReqModel) async {
    //Map<String, String> header = {"Authorization": '${ApiRoutes.dataToken}'};
    Map<String, String> header = {"Authorization": '${bearerToken}'};

    var response = await API.apiHandlers(
        Url: '${ApiRoutes.updateIsCompleted}',
        apiTypes: ApiTypes.Post,
        reqBody: updateIsCompletedReqModel.toJson(),
        header: header);

    //print("STUDENT-ID-----------${ApiRoutes.allStudentsDetails}$id");
    print("UpdateIsCompleted RESPONSE------------${response}");
    ("UpdateIsCompletedURL--------------${ApiRoutes.updateIsCompleted}");

    if (response != null) {
      var responseData = jsonDecode(response);
      if (responseData['Course_completed'] == "successfully") return true;
      return false;
    } else {
      return false;
    }

    //return getStudentsDetailsResModelFromJson(response!);
  }
}
