
import 'package:final_year/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget customSearch({
  required Function(String query) onChanged
}){
  return Container(
        margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          height: 55.h,
          child: Card(
            elevation: 0,
            color: Colors.white,
            shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.sp),
                  side: BorderSide.none
                  ),
            child: TextField(
              onChanged: onChanged,
              cursorColor: AppColors.mainColor,
              decoration: InputDecoration(
                isDense: true,
                
                prefixIcon: Icon(Icons.search),
                hintText: 'Search for documents',
                hintStyle: TextStyle(
                  color: AppColors.greyColor,
                  fontSize: 12.sp
                ),
                border: InputBorder.none,
                enabledBorder: OutlineInputBorder(
                   borderSide:const BorderSide(
                   color: AppColors.greyColor
                  ),
                 borderRadius: BorderRadius.circular(10)
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:const BorderSide(
                   color: AppColors.mainColor,
                   
                  ),
                  borderRadius: BorderRadius.circular(10.sp)
                ),
                errorBorder: const OutlineInputBorder(
                  borderSide: BorderSide.none
                ),
                focusedErrorBorder:const  OutlineInputBorder(
                  borderSide: BorderSide.none
                ),
               
              ),
            ),
          ),
        );
}