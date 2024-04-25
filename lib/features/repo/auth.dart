import 'package:final_year/features/api/apiClient.dart';
import 'package:final_year/features/models/login.dart';
import 'package:final_year/features/models/registration.dart';
import 'package:final_year/utils/constants/url.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepo extends GetxService{
  ApiClient apiClient;
  SharedPreferences sharedPreferences;
  AuthRepo({required this.apiClient, required this.sharedPreferences});

 Future<Response> registration(SignUpModel body) async{
  return await apiClient.postData(UrlConstants.REGISTRATION_ENDPOINT, body.toJson());
  }
  Future<Response> login(LoginModel body) async{
  return await apiClient.postData(UrlConstants.LOGIN_ENDPOINT, body.toJson());
  }
  Future<Response> verifyToken(String accessToken) async{
  return await apiClient.postData(UrlConstants.VERIFY_TOKEN_ENDPOINT, {'accessToken': accessToken});
  }
  saveUserToken(String token) async {
    apiClient.token=token;
    apiClient.updateToken(token);
    await sharedPreferences.setString(StorageConstants.TOKEN, token);
    
  }
  logOut(){
    sharedPreferences.remove(UrlConstants.TOKEN);
    apiClient.token='';
    apiClient.updateToken('');
  
  }
  bool isLoogedIn()  {
    return  sharedPreferences.containsKey(UrlConstants.TOKEN);
  }
  // Future<bool>saveUserInfo(SignUpModel body ) async{
  //   return await sharedPreferences.setString(AppConstants.SAVE_USER_INFO, jsonEncode(body));
  // }

}