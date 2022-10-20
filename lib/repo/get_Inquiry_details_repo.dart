import 'package:codeline_info_responsive_ui/api_handler/handlers.dart';
import 'package:codeline_info_responsive_ui/constant/api_routes.dart';
import 'package:codeline_info_responsive_ui/constant/const.dart';
import 'package:codeline_info_responsive_ui/models/res/get_Inquiry_details_res_model.dart';

class GetInquiryDetailsRepo {
  static Future<GetInquiryDetailsResModel?> getInquiryDetailsrepo(
      int id) async {
    //Map<String, String> header = {"Authorization": '${ApiRoutes.dataToken}'};
    Map<String, String> header = {"Authorization": 'Bearer ${bearerToken}'};

    var response = await API.apiHandlers(
        Url: '${ApiRoutes.getInquiryDetails}$id',
        apiTypes: ApiTypes.Get,
        header: header);

    print(
        "GetInquiryDetails STUDENT-ID-----------${ApiRoutes.getInquiryDetails}$id");
    print("GetInquiryDetails RESPONSE------------${response}");
    print("GetInquiryDetails URL--------------${ApiRoutes.getInquiryDetails}");

    return getInquiryDetailsResModelFromJson(response!);
  }
}
