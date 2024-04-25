
import 'package:final_year/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget boldText(
    {required String text,
    Color textColor = AppColors.boldTextColor,
    double fontSize = 20,
    FontWeight fontWeight = FontWeight.w600,
   // String fontFamily = 'Nunito Sans',
    TextAlign textAlign = TextAlign.start}) {
  return Text(
    text,
    textAlign: textAlign,
    style: TextStyle(
        color: textColor,
        fontWeight: fontWeight,
        fontSize: fontSize.sp,
        fontFamily: 'Apercu Pro',
        ),
  );
}
