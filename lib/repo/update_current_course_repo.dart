import 'dart:convert';
import 'package:codeline_info_responsive_ui/api_handler/handlers.dart';
import 'package:codeline_info_responsive_ui/constant/api_routes.dart';
import 'package:codeline_info_responsive_ui/models/req/update_current_course_req_model.dart';
import '../screens/splash_screen.dart';

class UpdateCurrentCourseRepo {
  static Future<bool> updateCurrentCourserepo(
      UpdateCurrentCourseReqModel updateCurrentCourseReqModel) async {
    //Map<String, String> header = {"Authorization": '${ApiRoutes.dataToken}'};
    Map<String, String> header = {"Authorization": '${bearerToken}'};

    var response = await API.apiHandlers(
        Url: '${ApiRoutes.updateCurrentCourse}',
        apiTypes: ApiTypes.Post,
        reqBody: updateCurrentCourseReqModel.toJson(),
        header: header);

    //print("STUDENT-ID-----------${ApiRoutes.allStudentsDetails}$id");
    print("UpdateCurrentCourse RESPONSE------------${response}");
    //("URL--------------${ApiRoutes.allStudentsDetails}");

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
