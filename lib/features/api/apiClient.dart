import 'package:final_year/utils/constants/url.dart';
import 'package:get/get.dart';

import '../models/login.dart';

class ApiClient extends GetConnect implements GetxService {
  late String appbaseUrl;
  late String token;
  late User currentUser;
  late Map<String, String> mainHeader;
  ApiClient({required this.appbaseUrl}) {
    baseUrl = appbaseUrl;
    timeout = const Duration(seconds: 60);
    token = UrlConstants.TOKEN;
    mainHeader = {
      'Content-type': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }

  updateToken(token) {
    mainHeader = {
      'Content-type': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }

  Future<Response> getData(String uri,
      {Map<String, String>? mainHeader}) async {
    try {
      print('trying.....');
      Response response = await get(uri, headers: mainHeader);
      return response;
    } catch (e) {
      print(e.toString());
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> postData(String url, dynamic body,
      {String? accessToken}) async {
    print('...the token is $accessToken');
    final header = {
      'Content-type': 'application/json',
      'Authorization': 'Bearer $accessToken',
      "HttpHeaders.contentTypeHeader": "application/json"
    };
    try {
      Response response = await post(url, body, headers: header);
      return response;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }
}
