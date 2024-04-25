import 'package:final_year/features/controllers/field.dart';
import 'package:final_year/features/controllers/workflow.dart';
import 'package:final_year/utils/helper.dart';
import 'package:final_year/utils/widgets/button.dart';
import 'package:final_year/utils/widgets/custom_appbar.dart';
import 'package:final_year/utils/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class FieldScreen extends StatelessWidget {
  const FieldScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final workflowId = Get.parameters['workflowId'];
    print('...the workflowId is $workflowId');
    return GetBuilder<WorkflowController>(builder: (workflowCOntroller) {
      return GetBuilder<FieldController>(
        builder: (controller) {
          return Scaffold(
              appBar: customAppBAr(text: 'Fill the fields'),
              body: SingleChildScrollView(
                child: workflowCOntroller.fields.isEmpty
                    ? Center(child: boldText(text: 'No field is required'))
                    : Column(
                        children: [
                          Padding(
                            padding:
                                EdgeInsets.only(left: 20.w, right: 20.w, top: 10.h),
                            child: Column(
                              children: [
                                ListView.builder(
                                    physics: const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: workflowCOntroller.fields.length,
                                    itemBuilder: (context, index) {
                                      final field = workflowCOntroller.fields[index];
                                      return fieldType(
                                        fieldType: field.type!,
                                        title: field.name!,
                                        hintText: field.description!,
                                        controller: controller.controllers[index],
                                        onChanged: (value) => controller
                                            .updateInputValue(value, index),
                                      );
                                    }),
                                SizedBox(
                                  height: 50.h,
                                ),
                                customButton(text: 'Submit', onTap: () {
                                  controller.getDocId(workflowId!);
                                })
                              ],
                            ),
                          ),
                        ],
                      ),
              ));
        }
      );
    });
  }
}
