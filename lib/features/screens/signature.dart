import 'package:dotted_border/dotted_border.dart';
import 'package:final_year/features/route/route.dart';
import 'package:final_year/utils/constants/colors.dart';
import 'package:final_year/utils/widgets/button.dart';
import 'package:final_year/utils/widgets/custom_appbar.dart';
import 'package:final_year/utils/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SignatureScreen extends StatelessWidget {
  const SignatureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBAr(text: 'Signature'),
      body: Padding(
        padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 20.h, bottom: 50.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            boldText(text: 'Sign in the Box '),
            SizedBox(height: 10.h,),
            DottedBorder(
              dashPattern: [9.w, 9.w],
                color: AppColors.dottedBorderColor,
                 
                 
                strokeWidth: 2,
              radius: Radius.circular(10.sp),
              child: Container(
              width: double.infinity,
              height: 370.h,
              decoration: BoxDecoration(
                      color: AppColors.greyColor,
                      borderRadius: BorderRadius.circular(10.sp),)
            )),
            Expanded(child: Container()),
            customButton(text: 'Complete', onTap: (){
              Get.toNamed(AppRoute.nationalProfile);
            })
          ],
        ),
      ),
    );
  }
}