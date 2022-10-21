import 'package:codeline_info_responsive_ui/api_handler/handlers.dart';
import 'package:codeline_info_responsive_ui/constant/api_routes.dart';
import 'package:codeline_info_responsive_ui/constant/const.dart';
import 'package:codeline_info_responsive_ui/models/res/get_allInquiry_res_model.dart';

class GetAllInquiryRepo {
  static Future<GetAllInquiryResModel?> getAllInquiryrepo() async {
    //Map<String, String> header = {"Authorization": '${ApiRoutes.dataToken}'};
    Map<String, String> header = {"Authorization": '${bearerToken}'};

    var response = await API.apiHandlers(
        Url: ApiRoutes.getAllInquiry, apiTypes: ApiTypes.Get, header: header);

    print("GetAllInquiryRESPONSE------------${response}");
    print("GetAllInquiryURL--------------${ApiRoutes.getDashboardDetails}");

    return getAllInquiryResModelFromJson(response!);
  }
}
