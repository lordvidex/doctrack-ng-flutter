import 'package:final_year/features/controllers/auth.dart';
import 'package:final_year/features/route/route.dart';
import 'package:final_year/utils/constants/colors.dart';
import 'package:final_year/utils/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

AppBar customAppBAr(
    {required String text,
    Color textColor = AppColors.boldTextColor,
    double fontSize = 16,
    bool centerTitle = true,
    TextOverflow? titleOverflow,
    bool hasBox = false}) {
  return AppBar(
    centerTitle: centerTitle,
    scrolledUnderElevation: 0.0,
    title: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        hasBox == true
            ? Container(
                margin: EdgeInsets.only(right: 3.w),
                height: 9.h,
                width: 9.w,
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.mainColor, width: 2)),
              )
            : Container(),
        Expanded(
          child: boldText(
              text: text,
              overflow: titleOverflow,
              fontSize: fontSize.sp,
              textColor: textColor),
        ),
      ],
    ),
    actions: [
      // for logging out
      IconButton(
          padding: const EdgeInsets.fromLTRB(0, 0, 24, 0),
          onPressed: () async {
            AuthController controller = Get.find();
            await controller.authRepo.logOut();
            Get.offAllNamed(AppRoute.login);
          },
          icon: const Icon(Icons.logout, color: AppColors.mainColor))
    ],
  );
}
