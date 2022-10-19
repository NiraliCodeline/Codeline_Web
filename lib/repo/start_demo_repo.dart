import 'dart:convert';
import 'package:codeline_info_responsive_ui/api_handler/handlers.dart';
import 'package:codeline_info_responsive_ui/constant/api_routes.dart';
import '../models/req/start_demo_req_model.dart';
import '../screens/splash_screen.dart';

class StartDemoRepo {
  static Future<bool> startDemorepo(StartDemoReqModel startDemoReqModel) async {
    //Map<String, String> header = {"Authorization": '${ApiRoutes.dataToken}'};
    Map<String, String> header = {"Authorization": '${bearerToken}'};

    var response = await API.apiHandlers(
        Url: '${ApiRoutes.startDemo}',
        apiTypes: ApiTypes.Post,
        reqBody: startDemoReqModel.toJson(),
        header: header);

    //print("STUDENT-ID-----------${ApiRoutes.allStudentsDetails}$id");
    print("StartDemo RESPONSE------------${response}");
    ("StartDemoURL--------------${ApiRoutes.startDemo}");

    if (response != null) {
      var responseData = jsonDecode(response);
      if (responseData['demo_register'] == "successfully") return true;
      return false;
    } else {
      return false;
    }

    //return getStudentsDetailsResModelFromJson(response!);
  }
}
