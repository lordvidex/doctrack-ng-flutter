import 'package:final_year/features/controllers/workflow.dart';
import 'package:final_year/features/route/route.dart';
import 'package:final_year/utils/constants/colors.dart';
import 'package:final_year/utils/widgets/custom_appbar.dart';
import 'package:final_year/utils/widgets/custom_search.dart';
import 'package:final_year/utils/widgets/docs_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class NationalProfileScreen extends StatelessWidget {
  const NationalProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
        return GetBuilder<WorkflowController>(
          builder: (controller) {
            return Scaffold(
              appBar: customAppBAr(text: 'Workflows', hasBox: true, textColor: AppColors.mainColor, fontSize: 14.sp),
              body: Column(
                children: [
                   customSearch(onChanged: (value){
                      controller.getWorkflow(value);
                   } 
                   ),
                  controller.workFlows.isEmpty?Container(): Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      physics: const BouncingScrollPhysics(),
                      itemCount: controller.workFlows.length,
                      itemBuilder: (context, index){
                        final workFlow = controller.workFlows[index];
                      return nationalDocContainer(text: workFlow.name, onTap: (){
                        print('...steps ${workFlow.steps}');
                        Get.toNamed(AppRoute.flowSteps, arguments: {
                          'steps' : workFlow.steps,
                          'name' : workFlow.name,
                          'workflowId' : workFlow.id
                        });
                      },);
                     }),
                  )
                ],
              )
              
            );
          }
        );
     
  }
}