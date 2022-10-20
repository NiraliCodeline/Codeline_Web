import 'dart:convert';
import 'package:codeline_info_responsive_ui/constant/api_routes.dart';
import 'package:codeline_info_responsive_ui/constant/const.dart';
import 'package:http/http.dart' as http;

Future<String?> uploadUserImage({String? fileName, var image}) async {
  Map<String, String> header = {
    //"Authorization": '${ApiRoutes.dataToken}',
    "Authorization": '${bearerToken}',
    "Content-Type": "multipart/form-data"
  };
  var mulReq = await http.MultipartFile.fromPath("file", image!.path);

  var multipartRequest =
      http.MultipartRequest("POST", Uri.parse("${ApiRoutes.uploadAvatar}"));
  multipartRequest.headers.addAll(header);
  multipartRequest.files.add(mulReq);
  multipartRequest.send().then((response) {
    print("UploadUserImage Status Code:${response.statusCode}");

    print("Uploaded!");
    try {
      response.stream.transform(utf8.decoder).listen((value) {
        // response.data
        print("value ${value}");
        print("URL:${jsonDecode(value)}");
        return jsonDecode(value)['image_url'];
        print(response.reasonPhrase);
      });
    } catch (e) {
      return null;
    }
  });
  return null;
}
