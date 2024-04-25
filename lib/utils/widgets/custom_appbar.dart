import 'package:final_year/utils/constants/colors.dart';
import 'package:final_year/utils/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

AppBar customAppBAr({required String text , Color textColor = AppColors.boldTextColor, double fontSize = 16, bool centerTitle = true, bool hasBox = false}){
  return  AppBar(
    centerTitle: centerTitle,
        scrolledUnderElevation: 0.0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
           hasBox==true?  Container(
              margin: EdgeInsets.only(right: 3.w),
              height: 9.h,
            width: 9.w,
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.mainColor,
                width: 2
              )
            ),
            ):Container(),
            boldText(text: text, fontSize: fontSize.sp, textColor: textColor),
          ],
        )
      );
}