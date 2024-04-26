import 'package:final_year/features/controllers/document.dart';
import 'package:final_year/features/controllers/workflow.dart';
import 'package:final_year/features/models/workflow.dart';
import 'package:final_year/features/route/route.dart';
import 'package:final_year/utils/constants/colors.dart';
import 'package:final_year/utils/widgets/button.dart';
import 'package:final_year/utils/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class WorkflowStepsScreen extends StatelessWidget {
  const WorkflowStepsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<WorkflowStep> steps = Get.arguments['steps'];
    String name = Get.arguments['name'];
    String workflowId = Get.arguments['workflowId'];

    return GetBuilder<WorkflowController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          title: boldText(text: '$name Steps'),
          centerTitle: true,
        ),
        body: Padding(
            padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 20.h),
            child: steps.isEmpty
                ? Center(child: boldText(text: 'No step is available'))
                : Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                            itemCount: steps.length,
                            itemBuilder: (context, index) {
                              final step = steps[index];
                              return GestureDetector(
                                onTap: () => controller
                                    .getFlowField(step.id)
                                    .then((value) =>
                                        Get.toNamed(AppRoute.fieldView)),
                                child: Container(
                                  margin: EdgeInsets.only(bottom: 10.h),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 15.w, vertical: 10.h),
                                  decoration: BoxDecoration(
                                      color:
                                          AppColors.greyColor.withOpacity(0.4)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      boldText(text: step.title),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      Text(step.description)
                                    ],
                                  ),
                                ),
                              );
                            }),
                      ),
                      customButton(
                          text: 'Create Document',
                          onTap: () async {
                            final document =
                                await Get.find<DocumentController>()
                                    .createDocument(workflowId);
                            Get.toNamed(AppRoute.viewDocumentDetails,
                                arguments: {
                                  'document': document,
                                });
                          })
                    ],
                  )),
      );
    });
  }
}
