import 'package:dio/dio.dart';
import 'package:final_year/features/api/apiClient.dart';
import 'package:final_year/features/controllers/auth.dart';
import 'package:final_year/features/controllers/document.dart';
import 'package:final_year/features/controllers/profile.dart';
import 'package:final_year/features/controllers/upload_docs.dart';
import 'package:final_year/features/controllers/workflow.dart';
import 'package:final_year/features/repo/auth.dart';
import 'package:final_year/utils/constants/url.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

const appID = "ae200f01-781d-44ca-8c34-8f4913b65e56";

Future<void> initDep() async {
  //TODO: Remove this method to stop OneSignal Debugging
  await OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
  OneSignal.initialize(appID);
  await OneSignal.Notifications.requestPermission(true);
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => Dio(BaseOptions(
      baseUrl: UrlConstants.BASEURL,
      headers: {'Content-Type': 'application/json'})));
  Get.lazyPut(() => sharedPreferences, fenix: true);
  Get.lazyPut(
      () => ApiClient(appbaseUrl: UrlConstants.BASEURL, dio: Get.find()));
  Get.lazyPut(() => AuthController(authRepo: Get.find()), fenix: true);
  Get.lazyPut(() =>
      AuthRepo(apiClient: Get.find(), sharedPreferences: sharedPreferences));
  Get.lazyPut(() => ProfileController(), fenix: true);
  Get.lazyPut(
      () => UploadDocumentsController(
          apiClient: Get.find(), sharedPreferences: sharedPreferences),
      fenix: true);
  Get.lazyPut(
      () => WorkflowController(
          apiClient: Get.find(), sharedPreferences: sharedPreferences),
      fenix: true);
  Get.lazyPut(() => DocumentController(apiClient: Get.find()), fenix: true);
}
