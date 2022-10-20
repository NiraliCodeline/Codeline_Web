import 'dart:convert';
import 'package:codeline_info_responsive_ui/api_handler/handlers.dart';
import 'package:codeline_info_responsive_ui/constant/api_routes.dart';
import 'package:codeline_info_responsive_ui/constant/const.dart';
import 'package:codeline_info_responsive_ui/models/req/add_new_Inquiry_req_model.dart';

class AddNewInquiryRepo {
  static Future<bool> addNewInquiryrepo(
      AddNewInquiryReqModel addNewInquiryReqModel) async {
    //Map<String, String> header = {"Authorization": '${ApiRoutes.dataToken}'};
    Map<String, String> header = {
      "Authorization": 'Bearer ${bearerToken}',
      //'Content-Type': 'application/json'
    };
    print("bearerToken-------${bearerToken}");
    print('addNewInquiryReqModel.toJson()${addNewInquiryReqModel.toJson()}');
    var response = await API.apiHandlers(
        Url: '${ApiRoutes.addNewInquiry}',
        apiTypes: ApiTypes.Post,
        reqBody: addNewInquiryReqModel.toJson(),
        header: header);

    print("AddNewInquiryRESPONSE------------${response}");
    //("URL--------------${ApiRoutes.allStudentsDetails}");

    if (response != null) {
      var responseData = jsonDecode(response);
      if (responseData['Inquiry_register'] == "successfully") return true;
      return false;
    } else {
      return false;
    }
  }
}
