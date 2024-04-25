import 'package:final_year/utils/constants/colors.dart';
import 'package:final_year/utils/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


Widget customTextField({
  required String mainText,
  required String hintText,
  Widget? prefixWidget,
   TextEditingController? controller,
  Function(String value)? onchanged,
  InputBorder? enabledBorder,
  Color? prefixIconColor,
  bool isBoldText = false,
  bool hintBoldText = false,
  Color hintTextColor = AppColors.hintTextColor,
  bool readOnly = false,
  IconData? suffixIcon,
}) {
  return Padding(
    padding: EdgeInsets.only(top: 10.h),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        boldText(
                text: mainText,
                fontSize: 12.sp,
                ),
          
        SizedBox(
          height: 5.h,
        ),
        TextFormField(
          readOnly: readOnly,
          controller: controller,
          onChanged: onchanged,
          cursorColor: AppColors.mainColor,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            hintText: hintText,
            isDense: true,
            prefixIcon: prefixWidget,
              
            suffixIcon: Icon(
              suffixIcon,
              color: AppColors.greyColor,
            ),
            hintStyle: TextStyle(
                color: hintBoldText == true
                    ? AppColors.greyColor
                    : hintTextColor,
                fontSize: 12.sp),
            focusedBorder:  OutlineInputBorder(
                borderSide:const BorderSide(
                  color: AppColors.mainColor,
                ),
                borderRadius: BorderRadius.all(Radius.circular(10.sp))),
            enabledBorder: enabledBorder,
            // border:  OutlineInputBorder(
            //     borderSide:const BorderSide(
            //         color:AppColors.greenColor,
            //         ),
            //     borderRadius: BorderRadius.all(Radius.circular(10.sp))),
          ),
        ),
      ],
    ),
  );
}
