import 'package:codeline_info_responsive_ui/api_handler/handlers.dart';
import 'package:codeline_info_responsive_ui/constant/api_routes.dart';
import '../models/res/get_all_fev_student_res_model.dart';
import '../screens/splash_screen.dart';

class GetAllFevStudentRepo {
  static Future<GetAllFevStudentResModel?> getAllFevStudentRepo() async {
    //Map<String, String> header = {"Authorization": '${ApiRoutes.dataToken}'};
    Map<String, String> header = {"Authorization": '${bearerToken}'};

    var response = await API.apiHandlers(
        Url: ApiRoutes.getAllFevStudent,
        apiTypes: ApiTypes.Get,
        header: header);

    print("GetAllFevStudent RESPONSE------------${response}");
    print("GetAllFevStudent URL--------------${ApiRoutes.getAllFevStudent}");

    return getAllFevStudentResModelFromJson(response!);
  }
}
