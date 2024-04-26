import 'package:final_year/features/controllers/auth.dart';
import 'package:final_year/features/models/login.dart';
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

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
                    boldText(text: 'Sign in to portal'),
                    SizedBox(
                      height: 30.h,
                    ),
                    inputField(
                      hintText: 'E-mail',
                      controller: authcontroller.emailController,
                      onChanged: (p0) {
                        authcontroller.checkIfLoginTextControllerIsNotEmpty();
                      },
                    ),
                    inputField(
                      hintText: 'Enter Password',
                      controller: authcontroller.passwordController,
                      onChanged: (p0) {
                        authcontroller.checkIfLoginTextControllerIsNotEmpty();
                      },
                    ),
                    customButton(
                      text: 'Sign in',
                      buttonBgColor: authcontroller.textFieldAllFilled == true
                          ? AppColors.mainColor
                          : AppColors.mainColor.withOpacity(0.4),
                      onTap: () async {
                        Get.focusScope?.unfocus();
                        if (authcontroller.textFieldAllFilled == true) {
                          LoginModel loginBody = LoginModel(
                              email: authcontroller.emailController.text,
                              password: authcontroller.passwordController.text);
                          await authcontroller
                              .loginUser(loginBody)
                              .then((ResponseModel response) {
                            if (response.isSuccess == true) {
                              Get.offAllNamed(AppRoute.nationalProfile);

                              successSnackbar(
                                  title: 'Success', message: response.message);
                            } else {
                              errorSnackbar(
                                  title: 'Error', message: response.message);
                            }
                          });
                        } else {
                          errorSnackbar(
                              title: 'Error', message: 'Please fill the field');
                        }
                      },
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        boldText(
                            text: 'Don\'t have an account?',
                            textColor: AppColors.hintTextColor,
                            fontSize: 14.sp),
                        SizedBox(
                          width: 5.w,
                        ),
                        GestureDetector(
                            onTap: () {
                              authcontroller.clearTextFieldController();
                              Get.offAllNamed(AppRoute.home);
                            },
                            child: boldText(
                                text: 'Sign up',
                                textColor: AppColors.mainColor,
                                fontSize: 14.sp))
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
