import 'dart:developer';

import 'package:final_year/features/controllers/document.dart';
import 'package:final_year/features/models/document.dart';
import 'package:final_year/utils/helper.dart';
import 'package:final_year/utils/widgets/button.dart';
import 'package:final_year/utils/widgets/custom_appbar.dart';
import 'package:final_year/utils/widgets/snackbar.dart';
import 'package:final_year/utils/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class StepFieldScreen extends StatelessWidget {
  final DocumentStep step;
  const StepFieldScreen({super.key, required this.step});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DocumentStepsController>(
        builder: (stepsController) => GetBuilder<DocumentStepController>(
            tag: step.id,
            builder: (controller) {
              return Scaffold(
                  appBar: customAppBAr(text: 'Fill the fields'),
                  body: controller.loading
                      ? const Center(child: CircularProgressIndicator())
                      : step.step.fieldsCount == 0
                          ? Center(
                              child: boldText(text: 'No field is required'))
                          : Padding(
                              padding: EdgeInsets.only(
                                  left: 20.w,
                                  right: 20.w,
                                  top: 10.h,
                                  bottom: 10.h),
                              child: Column(
                                children: [
                                  Expanded(
                                    child: ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: controller.fields.length,
                                        itemBuilder: (context, index) {
                                          final field =
                                              controller.fields[index];
                                          return Obx(() {
                                            return fieldType(
                                              fieldType: field.type!,
                                              title: field.name!,
                                              hintText: field.description!,
                                              controller: controller
                                                  .textControllers[field.id]
                                                  ?.value,
                                              toggleValue: controller
                                                  .checkControllers[field.id]
                                                  ?.value,
                                              onToggle: (v) {
                                                controller
                                                    .checkControllers[field.id]
                                                    ?.value = v!;
                                              },
                                            );
                                          });
                                        }),
                                  ),
                                  customButton(
                                      text: 'Submit',
                                      onTap: () async {
                                        final docId =
                                            Get.find<DocumentStepsController>()
                                                .documentId;

                                        final response = await controller
                                            .uploadFields(docId);
                                        if (response.isSuccess) {
                                          successSnackbar(
                                              title: 'Successful',
                                              message: response.message);
                                          Get.find<DocumentController>()
                                              .getDocuments();
                                          Get.find<DocumentStepsController>()
                                              .getDocumentSteps(docId);
                                          Get.back();
                                        } else {
                                          errorSnackbar(
                                              title: 'Failed',
                                              message: response.message);
                                        }
                                      })
                                ],
                              ),
                            ));
            }));
  }
}
