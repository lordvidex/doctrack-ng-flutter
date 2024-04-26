import 'package:dotted_border/dotted_border.dart';
import 'package:final_year/features/route/route.dart';
import 'package:final_year/utils/constants/colors.dart';
import 'package:final_year/utils/widgets/button.dart';
import 'package:final_year/utils/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

Widget uploadDocContainer(
    {required String mainText, required VoidCallback onTap}) {
  return Padding(
    padding: EdgeInsets.only(top: 10.h),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        boldText(text: mainText),
        SizedBox(
          height: 10.h,
        ),
        DottedBorder(
          dashPattern: [9.w, 9.w],
          color: AppColors.dottedBorderColor,
          strokeWidth: 2,
          radius: Radius.circular(10.sp),
          child: Container(
            height: 136.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.greyColor,
              borderRadius: BorderRadius.circular(10.sp),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                boldText(
                    text: 'Drop files here to upload…',
                    fontWeight: FontWeight.w500,
                    fontSize: 15.sp,
                    textColor: AppColors.lightBlackColor),
                browseFileButton(onTap: onTap)
              ],
            ),
          ),
        )
      ],
    ),
  );
}

Widget nationalDocContainer({required String text, VoidCallback? onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      margin: EdgeInsets.only(top: 10.h),
      padding: EdgeInsets.only(left: 15.w, bottom: 15.h),
      height: 80.h,
      alignment: Alignment.bottomLeft,
      width: double.infinity,
      decoration: BoxDecoration(
          color: AppColors.containerBgColor,
          borderRadius: BorderRadius.circular(5.sp)),
      child: Column(
        children: [
          boldText(text: text, fontSize: 16.sp),
          
        ],
      ),
    ),
  );
}

Widget applicationCreatedContainer(
    {required BuildContext context,
    required String mainText,
    required String subText}) {
  return Container(
    margin: EdgeInsets.only(left: 15.w, bottom: 50.h),
    padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
    width: MediaQuery.sizeOf(context).width - 72.5.w,
    height: 90.h,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.sp),
        color: AppColors.containerBgColor2),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        boldText(text: mainText, fontSize: 16.sp),
        boldText(text: subText, fontSize: 12.sp, fontWeight: FontWeight.w400)
      ],
    ),
  );
}
