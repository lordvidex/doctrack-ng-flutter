import 'package:final_year/features/controllers/workflow.dart';
import 'package:final_year/utils/widgets/custom_appbar.dart';
import 'package:final_year/utils/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class FieldViewScreen extends StatelessWidget {
  const FieldViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WorkflowController>(builder: (workflowCOntroller) {
      return Scaffold(
          appBar: customAppBAr(text: 'Inspect workflow fields'),
          body: workflowCOntroller.fields.isEmpty
              ? Center(child: boldText(text: 'No field is required'))
              : Column(
                  children: [
                    Padding(
                        padding:
                            EdgeInsets.only(left: 20.w, right: 20.w, top: 10.h),
                        child: Table(
                          border: TableBorder.all(),
                          children: [
                            TableRow(children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: boldText(
                                    text: 'Field Name',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: boldText(
                                    text: 'Field Description',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),
                              ),
                            ]),
                            ...(workflowCOntroller.fields.map((field) {
                              return TableRow(children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: boldText(
                                      text: field.name ?? 'No name',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                      field.description ?? 'No description '),
                                )
                              ]);
                            }).toList())
                          ],
                        )

                        //   Column(
                        //     children: [
                        //       ListView.separated(
                        //           separatorBuilder: (_, __) => const Divider(),
                        //           physics: const NeverScrollableScrollPhysics(),
                        //           shrinkWrap: true,
                        //           itemCount: workflowCOntroller.fields.length,
                        //           itemBuilder: (context, index) {
                        //             final field =
                        //                 workflowCOntroller.fields[index];
                        //             return Row(children: [
                        //              ,
                        //             ]);
                        //           }),
                        //       SizedBox(
                        //         height: 50.h,
                        //       ),
                        //     ],
                        //   ),
                        ),
                  ],
                ));
    });
  }
}
