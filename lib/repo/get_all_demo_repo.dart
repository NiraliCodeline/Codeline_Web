import 'package:codeline_info_responsive_ui/api_handler/handlers.dart';
import 'package:codeline_info_responsive_ui/constant/api_routes.dart';
import 'package:codeline_info_responsive_ui/constant/const.dart';
import 'package:codeline_info_responsive_ui/models/res/get_all_demo_res_model.dart';

class GetAllDemoRepo {
  static Future<GetAllDemoResModel?> getAllDemorepo() async {
    //Map<String, String> header = {"Authorization": '${ApiRoutes.dataToken}'};
    Map<String, String> header = {"Authorization": '${bearerToken}'};

    var response = await API.apiHandlers(
        Url: ApiRoutes.getAllDemo, apiTypes: ApiTypes.Get, header: header);

    print("GetAllDemoRESPONSE------------${response}");
    print("GetAllDemoURL--------------${ApiRoutes.getAllDemo}");

    return getAllDemoResModelFromJson(response!);
  }
}
