import 'package:final_year/utils/constants/colors.dart';
import 'package:final_year/utils/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget inputField(
    {Widget? widget,
    bool addInfoButton = false,
    TextInputType keyboardType = TextInputType.text,
    String? hintText,
    String? mainText,
    Color hintColor = Colors.grey,
    int maxLines = 1,
    double? fieldWidth,
    TextEditingController? controller,
    bool readOnly = false,
    Function(String)? onChanged,
    bool obscureText = false,
    Function()? onTap}) {
  return Container(
    margin: EdgeInsets.only(top: 10.h),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            boldText(
              text: mainText ?? '',
              fontSize: 12.sp,
            ),
            if (addInfoButton)
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: Tooltip(
                      message: hintText,
                      child:
                          const Icon(Icons.info, color: AppColors.mainColor))),
          ],
        ),
        SizedBox(
          height: 5.h,
        ),
        SizedBox(
          height: 60.h,
          width: fieldWidth,
          child: TextField(
            cursorColor: AppColors.mainColor,
            maxLines: maxLines,
            style: TextStyle(fontSize: 18.sp, decoration: TextDecoration.none),
            controller: controller,
            keyboardType: keyboardType,
            obscureText: obscureText,
            onTap: onTap,
            readOnly: readOnly,
            onChanged: onChanged,
            decoration: InputDecoration(
                hintText: hintText,
                hintStyle: TextStyle(
                    color: AppColors.hintTextColor.withOpacity(0.4),
                    fontWeight: FontWeight.w400),
                // contentPadding: EdgeInsets.only(right: 10),

                errorBorder:
                    const OutlineInputBorder(borderSide: BorderSide.none),
                enabledBorder: const OutlineInputBorder(
                    borderSide:
                        BorderSide(color: AppColors.textFieldBorderColor)),
                focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.mainColor))),
          ),
        )
      ],
    ),
  );
}
