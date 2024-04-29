import 'dart:developer';

import 'package:dio/dio.dart' as d;
import 'package:final_year/utils/constants/url.dart';
import 'package:get/get.dart';

import '../models/login.dart';

class ApiClient extends GetConnect implements GetxService {
  late String appbaseUrl;
  late String token;
  late User currentUser;
  late d.Dio dio;
  late Map<String, String> mainHeader;
  ApiClient({required this.appbaseUrl, required this.dio}) {
    baseUrl = appbaseUrl;
    timeout = const Duration(seconds: 60);
    token = UrlConstants.TOKEN;
    mainHeader = {
      'Content-type': 'application/json',
      'Authorization': 'bearer ${token.trim()}'.trim(),
      "HttpHeaders.contentTypeHeader": "application/json",
    };
  }

  updateToken(token) {
    token = token.trim();
    mainHeader = {
      'Content-Type': 'application/json',
      'Authorization': 'bearer $token',
      "HttpHeaders.contentTypeHeader": "application/json",
    };
  }

  Future<Response> getData(String uri,
      {Map<String, String>? additionalHeaders}) async {
    final headers = additionalHeaders ?? {};
    mainHeader.forEach((key, value) {
      headers[key] = value;
    });
    print(headers);

    try {
      // print('trying normal.....');
      // final oldResponse =
      //     await dio.get(uri, options: d.Options(headers: headers));
      // print(oldResponse.data);
      // print(oldResponse.headers);
      // print(oldResponse.body);

      Response response = await get(uri, headers: headers);
      print(response.body);
      print(response.statusCode);
      print(response.headers);
      return response;
    } catch (e) {
      print(e.toString());
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> postData(String url, dynamic body) async {
    log('url: $url, body: $body');
    try {
      Response response = await post(url, body, headers: mainHeader);
      log(response.bodyString ?? 'empty body string');
      return response;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }
}
