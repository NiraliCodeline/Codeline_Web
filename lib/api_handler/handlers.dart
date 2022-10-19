import 'dart:convert';

import 'package:http/http.dart' as http;

enum ApiTypes { Get, Post }

class API {
  static Future<String?> apiHandlers(
      {required String Url,
      required ApiTypes apiTypes,
      Map<String, dynamic>? reqBody,
      Map<String, String>? header}) async {
    http.Response? response;
    try {
      if (apiTypes == ApiTypes.Get) {
        try {
          response = await http.get(Uri.parse(Url), headers: header);
        } catch (e) {
          print(e);
        }
      } else {
        try {
          response = await http.post(Uri.parse(Url),
              body: jsonEncode(reqBody), headers: header);
        } catch (e) {
          print(e);
        }
      }

      if (response?.statusCode == 200) {
        return response?.body;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
