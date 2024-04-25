import 'package:final_year/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget progressIndicator() {
  return Material(
    borderRadius: BorderRadius.circular(30),
    elevation: 5,
    child: CircleAvatar(
      radius: 30.sp,
      backgroundColor: Colors.white,
      child: const CircularProgressIndicator(
        color: AppColors.mainColor,
      ),
    ),
  );
}