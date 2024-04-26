import 'package:final_year/features/controllers/auth.dart';
import 'package:final_year/features/models/registration.dart';
import 'package:final_year/features/models/response.dart';
import 'package:final_year/features/route/route.dart';
import 'package:final_year/utils/constants/colors.dart';
import 'package:final_year/utils/widgets/button.dart';
import 'package:final_year/utils/widgets/custom_appbar.dart';
import 'package:final_year/utils/widgets/progress_indicator.dart';
import 'package:final_year/utils/widgets/snackbar.dart';
import 'package:final_year/utils/widgets/text.dart';
import 'package:final_year/utils/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(builder: (authcontroller) {
      return Scaffold(
        appBar: customAppBAr(
            text: 'National Profile', centerTitle: true, hasBox: true),
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 30.h),
                child: Column(
                  children: [
                    boldText(text: 'Create Account'),
                    SizedBox(
                      height: 30.h,
                    ),
                    inputField(
                      hintText: 'Enter First Name',
                      controller: authcontroller.firstNameController,
                      onChanged: (p0) {
                        authcontroller.checkIfSiunUpTextControllerIsNotEmpty();
                      },
                    ),
                    inputField(
                      hintText: 'Enter Last Name',
                      controller: authcontroller.lastNameController,
                      onChanged: (p0) {
                        authcontroller.checkIfSiunUpTextControllerIsNotEmpty();
                      },
                    ),
                    inputField(
                      hintText: 'Enter Email',
                      controller: authcontroller.emailController,
                      onChanged: (p0) {
                        authcontroller.checkIfSiunUpTextControllerIsNotEmpty();
                      },
                    ),
                    inputField(
                      hintText: 'Enter Password',
                      controller: authcontroller.passwordController,
                      onChanged: (p0) {
                        authcontroller.checkIfSiunUpTextControllerIsNotEmpty();
                      },
                    ),
                    customButton(
                        text: 'Sign up',
                        buttonBgColor: authcontroller.textFieldAllFilled == true
                            ? AppColors.mainColor
                            : AppColors.mainColor.withOpacity(0.4),
                        onTap: () async {
                          Get.focusScope?.unfocus();
                          if (authcontroller.textFieldAllFilled == true) {
                            SignUpModel signUpBody = SignUpModel(
                                email: authcontroller.emailController.text,
                                firstName:
                                    authcontroller.firstNameController.text,
                                password:
                                    authcontroller.passwordController.text,
                                lastName:
                                    authcontroller.lastNameController.text);
                            await authcontroller
                                .registerUser(signUpBody)
                                .then((ResponseModel response) {
                              if (response.isSuccess == true) {
                                Get.offAllNamed(AppRoute.login);
                                successSnackbar(
                                    title: 'Success',
                                    message: response.message);
                              } else {
                                errorSnackbar(
                                    title: 'Error', message: response.message);
                              }
                            });
                          } else {
                            errorSnackbar(
                                title: 'Error',
                                message: 'Please fill the field');
                          }
                        }),
                    SizedBox(
                      height: 30.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        boldText(
                            text: 'Already have an account',
                            textColor: AppColors.hintTextColor,
                            fontSize: 14.sp),
                        SizedBox(
                          width: 5.w,
                        ),
                        GestureDetector(
                          onTap: () {
                            authcontroller.clearTextFieldController();
                            Get.toNamed(AppRoute.login);
                          },
                          child: boldText(
                              text: 'Login',
                              textColor: AppColors.mainColor,
                              fontSize: 14.sp),
                        )
                      ],
                    )
                  ],
                ),
              ),
              authcontroller.isLoading == true
                  ? Positioned(
                      top: (MediaQuery.sizeOf(context).height / 2) - 100.h,
                      left: (MediaQuery.sizeOf(context).width / 2) - 15.w,
                      child: progressIndicator())
                  : Container(),
            ],
          ),
        ),
      );
    });
  }
}
