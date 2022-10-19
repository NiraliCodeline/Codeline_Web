import 'dart:convert';
import 'package:codeline_info_responsive_ui/api_handler/handlers.dart';
import 'package:codeline_info_responsive_ui/constant/api_routes.dart';
import '../models/req/update_Isfavourite_res_Model.dart';
import '../screens/splash_screen.dart';

class UpdateIsfavouriteRepo {
  static Future<bool> updateIsfavouriterepo(
      UpdateIsFavouriteResModel updateIsFavouriteResModel) async {
    //Map<String, String> header = {"Authorization": '${ApiRoutes.dataToken}'};
    Map<String, String> header = {"Authorization": '${bearerToken}'};

    var response = await API.apiHandlers(
        Url: '${ApiRoutes.updateIsFavourite}',
        apiTypes: ApiTypes.Post,
        reqBody: updateIsFavouriteResModel.toJson(),
        header: header);

    //print("STUDENT-ID-----------${ApiRoutes.allStudentsDetails}$id");
    print("UpdateIs favourite RESPONSE------------${response}");
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
