import 'package:final_year/utils/constants/colors.dart';
import 'package:final_year/utils/widgets/docs_container.dart';
import 'package:final_year/utils/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ApplicationCreatedScreen extends StatelessWidget {
  const ApplicationCreatedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 60.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            boldText(
                text:
                    'Evans Institute of Technology 2024 Fall Masters Admission Application',
                fontSize: 24.sp),
            SizedBox(
              height: 30.h,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 20.h),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 13.sp,
                        backgroundColor: AppColors.mainColor,
                        child:const Icon(Icons.check, color: Colors.white,),
                        
                      ),
                      Wrap(
                        direction: Axis.vertical,
                        children: List.generate(
                            10,
                            (index) => Container(
                                  margin: EdgeInsets.only(bottom: 5.h),
                                  height: 8,
                                  width: 2,
                                  color: AppColors.textFieldBorderColor,
                                )),
                      ),
                      CircleAvatar(
                        radius: 13.sp,
                        backgroundColor: AppColors.orangeColor,
                      ),
                      Wrap(
                        direction: Axis.vertical,
                        children: List.generate(
                            10,
                            (index) => Container(
                                  margin: EdgeInsets.only(bottom: 5.h),
                                  height: 8,
                                  width: 2,
                                  color: AppColors.textFieldBorderColor,
                                )),
                      ),
                      CircleAvatar(
                        radius: 13.sp,
                        backgroundColor: AppColors.containerBgColor,
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    applicationCreatedContainer(
                        context: context,
                        mainText: 'Application Created',
                        subText:
                            'Your application has been created please submit the required documents'),
                            applicationCreatedContainer(
                        context: context,
                        mainText: 'Awaiting transcript',
                        subText:
                            'Please submit your transcript to continue your application'),
                            applicationCreatedContainer(
                        context: context,
                        mainText: 'Awaiting transcript',
                        subText:
                            'Please submit your transcript to continue your application')
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
