import 'dart:convert';
import 'package:codeline_info_responsive_ui/api_handler/handlers.dart';
import 'package:codeline_info_responsive_ui/constant/api_routes.dart';
import 'package:codeline_info_responsive_ui/screens/splash_screen.dart';
import '../models/req/add_installment_req_model.dart';

class AddInstallmentRepo {
  static Future<bool> updateInstallment(
      AddInstallmentReqModel addInstallmentResModel) async {
    //Map<String, String> header = {"Authorization": '${ApiRoutes.dataToken}'};
    Map<String, String> header = {"Authorization": '${bearerToken}'};

    var response = await API.apiHandlers(
        Url: '${ApiRoutes.addInstallment}',
        apiTypes: ApiTypes.Post,
        reqBody: addInstallmentResModel.toJson(),
        header: header);

    print("AddInstallmentRESPONSE------------${response}");
    print("AddInstallmentURL--------------${ApiRoutes.allStudentsDetails}");

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
