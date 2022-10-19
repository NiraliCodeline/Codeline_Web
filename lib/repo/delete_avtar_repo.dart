import 'dart:convert';

import '../api_handler/handlers.dart';
import '../constant/api_routes.dart';

class DeleteAvatarRepo {
  static Future<bool> deleteAvatar({required String image_url}) async {
    var response = await API.apiHandlers(
      Url: "${ApiRoutes.deleteAvatar}",
      apiTypes: ApiTypes.Post,
      reqBody: {"image_url": image_url},
    );

    print("DeleteAvatar response-----------------$response");

    try {
      print("TRy condition----------");
      if (response != null) {
        print("if condition----------");
        Map<String, dynamic> resData = jsonDecode(response);
        if (resData['message'] == "File Deleted...!") {
          print("message=>${resData['message']}");
          return true;
        }
      }
    } catch (e) {
      print("DELETE AVATAR ERROR--------$e");
    }
    return false;
  }
}
