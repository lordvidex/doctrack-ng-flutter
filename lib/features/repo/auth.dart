import 'dart:async';
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
  Timer? _timer;
  AuthRepo({required this.apiClient, required this.sharedPreferences});

  @override
  void onInit() {
    super.onInit();
    _timer ??= Timer.periodic(const Duration(minutes: 30), (_) => tryLogin());
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }

  Future<Response> registration(SignUpModel body) async {
    sharedPreferences.setString('email', body.email);
    sharedPreferences.setString('password', body.password);
    return await apiClient.postData(
        UrlConstants.REGISTRATION_ENDPOINT, body.toJson());
  }

  Future<Response> login(LoginModel body) async {
    sharedPreferences.setString('email', body.email);
    sharedPreferences.setString('password', body.password);
    return await apiClient.postData(UrlConstants.LOGIN_ENDPOINT, body.toJson());
  }

  Future<Response> verifyToken(String accessToken) async {
    return await apiClient.postData(
        UrlConstants.VERIFY_TOKEN_ENDPOINT, {'accessToken': accessToken});
  }

  Future<void> saveUserToken(String token, User user) async {
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

    await sharedPreferences.setString(StorageConstants.TOKEN, token.trim());
    await sharedPreferences.setString(StorageConstants.USER, user.toJson());
  }

  logOut() {
    sharedPreferences.remove(UrlConstants.TOKEN);
    apiClient.token = '';
    apiClient.updateToken('');
    OneSignal.logout();
  }

  Future<bool> isLoggedIn() async {
    if (sharedPreferences.containsKey(UrlConstants.TOKEN)) {
      final token = sharedPreferences.getString(UrlConstants.TOKEN);
      if (token == null) {
        return false;
      }
      apiClient.updateToken(token);
      try {
        final verif = await verifyToken(token);
        if (verif.statusCode != 200) {
          throw Exception('invalid token');
        }
      } catch (e) {
        if (await tryLogin()) {
          return true;
        }
        return false;
      }
      return true;
    }
    return false;
  }

  Future<bool> tryLogin() async {
    try {
      final email = sharedPreferences.getString('email') ?? '';
      final pass = sharedPreferences.getString('password') ?? '';
      if (email.isEmpty || pass.isEmpty) {
        return false;
      }
      final response = await login(LoginModel(email: email, password: pass));
      if (response.statusCode == 200) {
        apiClient.updateToken(response.body['token'].trim());
        return true;
      }
      return false;
    } catch (e) {
      log('tryLogin: $e');
      return false;
    }
  }
  // Future<bool>saveUserInfo(SignUpModel body ) async{
  //   return await sharedPreferences.setString(AppConstants.SAVE_USER_INFO, jsonEncode(body));
  // }
}
