import 'dart:convert';
import 'package:codeline_info_responsive_ui/api_handler/handlers.dart';
import 'package:codeline_info_responsive_ui/constant/api_routes.dart';
import 'package:codeline_info_responsive_ui/constant/const.dart';

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
