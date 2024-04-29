import 'package:final_year/features/models/login.dart';
import 'package:final_year/features/models/registration.dart';
import 'package:final_year/features/models/response.dart';
import 'package:final_year/features/repo/auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  AuthRepo authRepo;
  AuthController({required this.authRepo});
  bool isLoading = false;
  bool textFieldAllFilled = false;
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

//  late UserModel _userModel;
//  UserModel get userModel => _userModel;

  Future<ResponseModel> registerUser(SignUpModel body) async {
    isLoading = true;
    update();
    ResponseModel responseModel;
    Response response = await authRepo.registration(body);
    if (response.statusCode == 200) {
      response.body['token'];
      responseModel =
          ResponseModel(isSuccess: true, message: 'Registration Successfull');
      isLoading = false;
      update();
      clearTextFieldController();
      return responseModel;
    } else {
      isLoading = false;
      update();
      return ResponseModel(
          isSuccess: false, message: response.statusText.toString());
    }
  }

  Future<ResponseModel> loginUser(loginBody) async {
    isLoading = true;
    update();
    ResponseModel responseModel;
    Response response = await authRepo.login(loginBody);
    if (response.statusCode == 200) {
      responseModel = ResponseModel(isSuccess: true, message: 'Login Success');
      isLoading = false;
      update();
      clearTextFieldController();

      return responseModel;
    } else {
      isLoading = false;
      update();
      return ResponseModel(
          isSuccess: false, message: response.statusText.toString());
    }
  }

  checkIfSiunUpTextControllerIsNotEmpty() {
    if (firstNameController.text.isNotEmpty &&
        lastNameController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty) {
      textFieldAllFilled = true;

      update();
    } else {}
  }

  checkIfLoginTextControllerIsNotEmpty() {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      textFieldAllFilled = true;
      update();
    } else {}
  }

  logOut() {
    authRepo.logOut();
  }

  clearTextFieldController() {
    firstNameController.clear();
    lastNameController.clear();
    passwordController.clear();
    emailController.clear();
    textFieldAllFilled = false;
    update();
  }
}
