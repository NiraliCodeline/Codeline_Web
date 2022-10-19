import 'dart:convert';

import '../api_handler/handlers.dart';
import '../constant/api_routes.dart';
import '../screens/splash_screen.dart';

class FeesReportRepo {
  static Future<Map<String, dynamic>> feesreportRepo(
      {required String passcode}) async {
    //Map<String, String> header = {"Authorization": '${ApiRoutes.dataToken}'};
    Map<String, String> header = {"Authorization": '${bearerToken}'};

    var response = await API.apiHandlers(
      Url: ApiRoutes.feesReport,
      apiTypes: ApiTypes.Post,
      header: header,
      reqBody: {
        "passcode": passcode,
      },
    );

    if (response != null) {
      Map<String, dynamic> resData = jsonDecode(response);

      print("FeesReport response-----------${resData}");
      print("Total Fees-------------${resData["Report"]["total_fees"]}");
      return {
        "result": true,
        "data": resData,
      };
    } else {
      return {"result": false, "data": null};
    }
  }
}
