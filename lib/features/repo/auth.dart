import 'dart:developer';

import 'package:final_year/features/api/apiClient.dart';
import 'package:final_year/features/models/login.dart';
import 'package:final_year/features/models/registration.dart';
import 'package:final_year/utils/constants/url.dart';
import 'package:get/get.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepo extends GetxService {
  ApiClient apiClient;
  SharedPreferences sharedPreferences;
  AuthRepo({required this.apiClient, required this.sharedPreferences});

  Future<Response> registration(SignUpModel body) async {
    return await apiClient.postData(
        UrlConstants.REGISTRATION_ENDPOINT, body.toJson());
  }

  Future<Response> login(LoginModel body) async {
    return await apiClient.postData(UrlConstants.LOGIN_ENDPOINT, body.toJson());
  }

  Future<Response> verifyToken(String accessToken) async {
    return await apiClient.postData(
        UrlConstants.VERIFY_TOKEN_ENDPOINT, {'accessToken': accessToken});
  }

  saveUserToken(String token, User user) async {
    apiClient.token = token;
    apiClient.currentUser = user;
    apiClient.updateToken(token);
    if (user.id.isNotEmpty) {
      log('logged in to one signal, id: ${user.id}');
      await OneSignal.login(user.id);
    }
    if (user.email.isNotEmpty) {
      OneSignal.User.addEmail(user.email)
          .then((_) => log('added email ${user.email} to onesignal'));
    }
    if (user.orgId.isNotEmpty) {
      OneSignal.User.addAlias('orgId', user.orgId)
          .then((_) => log('added orgId ${user.orgId} to onesignal'));
    }

    await sharedPreferences.setString(StorageConstants.TOKEN, token);
    await sharedPreferences.setString(StorageConstants.USER, user.toJson());
  }

  logOut() {
    sharedPreferences.remove(UrlConstants.TOKEN);
    apiClient.token = '';
    apiClient.updateToken('');
    OneSignal.logout();
  }

  bool isLoogedIn() {
    return sharedPreferences.containsKey(UrlConstants.TOKEN);
  }
  // Future<bool>saveUserInfo(SignUpModel body ) async{
  //   return await sharedPreferences.setString(AppConstants.SAVE_USER_INFO, jsonEncode(body));
  // }
}
