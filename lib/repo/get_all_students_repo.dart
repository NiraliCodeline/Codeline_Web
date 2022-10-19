import 'package:codeline_info_responsive_ui/api_handler/handlers.dart';
import 'package:codeline_info_responsive_ui/constant/api_routes.dart';
import '../models/res/get_all_student_res_model.dart';
import '../screens/splash_screen.dart';

class GetAllStudentsRepo {
  static Future<GetAllStudentsResModel?> getAllStudentsRepo() async {
    //Map<String, String> header = {"Authorization": '${ApiRoutes.dataToken}'};
    Map<String, String> header = {"Authorization": 'Bearer ${bearerToken}'};

    var response = await API.apiHandlers(
        Url: ApiRoutes.allStudents, apiTypes: ApiTypes.Get, header: header);

    print("GetAllStudentsRESPONSE------------${response}");
    print("GetAllStudentsURL--------------${ApiRoutes.allStudents}");
    print("bearerToken--------------${bearerToken}");

    return getAllStudentsResModelFromJson(response!);
  }
}
