import 'package:final_year/features/api/apiClient.dart';
import 'package:final_year/features/controllers/auth.dart';
import 'package:final_year/features/controllers/field.dart';
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
  OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
  OneSignal.initialize(appID);
  OneSignal.Notifications.requestPermission(true);
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences);
  Get.lazyPut(() => ApiClient(appbaseUrl: UrlConstants.BASEURL));
  Get.lazyPut(() => AuthController(authRepo: Get.find()));
  Get.lazyPut(() => AuthRepo(apiClient: Get.find(), sharedPreferences: sharedPreferences));
  Get.lazyPut(() => ProfileController(), fenix: true);
  Get.lazyPut(() => UploadDocumentsController(apiClient: Get.find(), sharedPreferences: sharedPreferences), fenix: true);
  Get.lazyPut(() => WorkflowController(apiClient: Get.find(), sharedPreferences: sharedPreferences));
  Get.lazyPut(() => FieldController(workflowController: Get.find(), apiClient: Get.find(), sharedPreferences: sharedPreferences), fenix: true);
}