import 'dart:convert';
import 'package:codeline_info_responsive_ui/api_handler/handlers.dart';
import 'package:codeline_info_responsive_ui/constant/api_routes.dart';
import 'package:codeline_info_responsive_ui/constant/const.dart';

class TwoPhaseAuthenticationRepo {
  static Future<Map<String, dynamic>> twoPhaseAuthMethod(
      {required String code}) async {
    //Map<String, String> header = {"Authorization": '${ApiRoutes.dataToken}'};
    Map<String, String> header = {"Authorization": '${bearerToken}'};

    var response = await API.apiHandlers(
        Url: "${ApiRoutes.verifyCode}",
        apiTypes: ApiTypes.Post,
        reqBody: {"secret_code": code},
        header: header);

    print("TwoPhaseAuthentication response-------------$response");

    if (response != null) {
      Map<String, dynamic> resData = jsonDecode(response);

      if (resData['verify_code'] != null) {
        print("verify_code=>${resData['verify_code']}");
        return {"result": true, "verify_code": resData['verify_code']};
      } else {
        return {"result": false, "verify_code": null};
      }
    } else {
      return {"result": false, "verify_code": null};
    }
  }
}
