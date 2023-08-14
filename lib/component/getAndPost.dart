import 'dart:convert';

import 'package:http/http.dart' as http;

class GetPost {
  getRequest(String url, Map<String, String>? header) async {
    try {
      var api = Uri.parse(url);
      var response = await http.get(api, headers: header);

      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        print(responseBody);
        return responseBody;
      } else {
        print("Error ${response.statusCode}");
      }
    } catch (e) {
      print("Error catch ${e}");
    }
  }

  deleteRequest(String url, Map<String, String>? header) async {
    try {
      var api = Uri.parse(url);
      var response = await http.delete(api, headers: header);

      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        print(responseBody);
        return responseBody;
      } else {
        print("Error ${response.statusCode}");
      }
    } catch (e) {
      print("Error catch ${e}");
    }
  }

  postRequest(
      String url, Map<String, dynamic> data, Map<String, String> header) async {
    try {
      var api = Uri.parse(url);
      var response = await http.post(api, headers: header, body: data);

      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        print(responseBody);
        return responseBody;
      } else if (response.statusCode == 404) {
        var responseBody = jsonDecode(response.body);
        print(responseBody);
        return responseBody;
      } else {
        print("try error ${response.statusCode}");
        print(response.body);
      }
    } catch (e) {
      print("Error catch ${e}");
    }
  }
}
