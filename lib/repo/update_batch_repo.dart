import 'dart:convert';
import 'package:codeline_info_responsive_ui/api_handler/handlers.dart';
import 'package:codeline_info_responsive_ui/constant/api_routes.dart';
import 'package:codeline_info_responsive_ui/models/req/update_batch_res_model.dart';
import '../screens/splash_screen.dart';

class UpdateBatchRepo {
  static Future<bool> updateCurrentBatchRepo(
      UpdateBatchReqModel updateBatchResModel) async {
    //Map<String, String> header = {"Authorization": '${ApiRoutes.dataToken}'};
    Map<String, String> header = {"Authorization": '${bearerToken}'};

    var response = await API.apiHandlers(
        Url: '${ApiRoutes.updateBatch}',
        apiTypes: ApiTypes.Post,
        reqBody: updateBatchResModel.toJson(),
        header: header);

    //print("STUDENT-ID-----------${ApiRoutes.allStudentsDetails}$id");
    print("UpdateBatch RESPONSE------------${response}");
    //("URL--------------${ApiRoutes.allStudentsDetails}");

    if (response != null) {
      var responseData = jsonDecode(response);
      if (responseData['update_Course'] == "successfully") return true;
      return false;
    } else {
      return false;
    }

    //return getStudentsDetailsResModelFromJson(response!);
  }
}
