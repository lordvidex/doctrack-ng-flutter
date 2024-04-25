import 'package:final_year/utils/constants/colors.dart';
import 'package:final_year/utils/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget customButton({required String text, bool isDecline = false,required VoidCallback onTap, Color buttonBgColor = AppColors.mainColor}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      margin: EdgeInsets.only(top: 70.h),
      padding: EdgeInsets.symmetric(vertical: 15.h),
      alignment: Alignment.center,
      width: double.infinity,
      decoration: BoxDecoration(
          color: buttonBgColor,
          borderRadius: BorderRadius.circular(30.sp),
          
          ),
      child: boldText(
          text: text,
          textColor: AppColors.whiteColor,
          fontSize: 16.sp,
          fontWeight: FontWeight.w700 ),
    ),
  );
}
Widget browseFileButton({
  required VoidCallback onTap
}){
  return GestureDetector(
    onTap: onTap,
    child: Container(
      margin: EdgeInsets.only(top: 15.h),
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: AppColors.dottedBorderColor,
        borderRadius: BorderRadius.circular(15.sp)
      ),
      child: boldText(text: 'Browse files', fontSize: 14.sp),
    ),
  );
}