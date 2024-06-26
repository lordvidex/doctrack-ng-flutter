import 'package:final_year/features/screens/step_field_screen.dart';
import 'package:final_year/features/screens/step_events_screen.dart';
import 'package:final_year/utils/constants/colors.dart';
import 'package:final_year/utils/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../controllers/document.dart';
import '../models/document.dart';

class DocumentDetailsScreen extends StatelessWidget {
  const DocumentDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Document document = Get.arguments['document'];
    final currentIndex = document.stepsCompleted;
    Get.put(DocumentStepsController(apiClient: Get.find())
      ..getDocumentSteps(document.id));

    return GetBuilder<DocumentStepsController>(builder: (controller) {
      return Scaffold(
        appBar: customAppBAr(
            text: 'Document - ${document.workflow.name}',
            hasBox: true,
            titleOverflow: TextOverflow.ellipsis,
            textColor: AppColors.mainColor,
            fontSize: 14.sp),
        backgroundColor: Colors.white,
        body: controller.loading
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: <Widget>[
                  _Header(doc: document),
                  Expanded(
                      child: _TimelineDelivery(
                          controller.documentSteps, currentIndex)),
                ],
              ),
      );
    });
  }
}

class _TimelineDelivery extends StatelessWidget {
  final List<DocumentStep> steps;
  final int currentIndex;

  const _TimelineDelivery(this.steps, this.currentIndex);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView.builder(
          itemCount: steps.length,
          itemBuilder: (ctx, i) {
            final docStep = steps[i];
            Get.put(
                DocumentStepController(apiClient: Get.find(), step: docStep),
                tag: docStep.id);
            return TimelineTile(
              alignment: TimelineAlign.manual,
              lineXY: 0.1,
              isFirst: i == 0,
              isLast: i == steps.length - 1,
              indicatorStyle: IndicatorStyle(
                width: 20,
                iconStyle: IconStyle(
                    fontSize: 10,
                    iconData: i < currentIndex
                        ? Icons.check
                        : i == currentIndex
                            ? Icons.co_present
                            : Icons.horizontal_rule,
                    color: Colors.white),
                color: i < currentIndex
                    ? const Color(0xFF27AA69)
                    : currentIndex == i
                        ? const Color(0xFF2B619C)
                        : const Color(0xFFDADADA),
                padding: const EdgeInsets.all(6),
              ),
              endChild: GetBuilder<DocumentStepController>(
                  tag: docStep.id,
                  builder: (context) {
                    return _RightChild(
                      disabled: i > currentIndex,
                      title: docStep.step.title,
                      stepData: docStep,
                      message: docStep.step.description,
                      isUserTurn: docStep.isUserTurn,
                      totalFields: docStep.step.fieldsCount,
                    );
                  }),
              beforeLineStyle: LineStyle(
                color: i <= currentIndex
                    ? const Color(0xFF27AA69)
                    : currentIndex == i
                        ? const Color(0xFF2B619C)
                        : const Color(0xFFDADADA),
              ),
              afterLineStyle: LineStyle(
                color: i < currentIndex
                    ? const Color(0xFF27AA69)
                    : const Color(0xFFDADADA),
              ),
            );
          }),
    );
  }
}

class _RightChild extends StatelessWidget {
  const _RightChild({
    Key? key,
    required this.title,
    required this.message,
    required this.stepData,
    this.isUserTurn = false,
    this.disabled = false,
    this.totalFields = 0,
  }) : super(key: key);

  final String title;
  final String message;
  final bool disabled;
  final bool isUserTurn;
  final int totalFields;
  final DocumentStep stepData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: <Widget>[
          Opacity(
            opacity: disabled ? 0.5 : 1,
            child: const CircleAvatar(
              backgroundColor: AppColors.mainColor,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                    color: disabled
                        ? const Color(0xFFBABABA)
                        : const Color(0xFF636564),
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  message,
                  style: TextStyle(
                    color: disabled
                        ? const Color(0xFFD5D5D5)
                        : const Color(0xFF636564),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          if (!disabled)
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () async {
                    final controller =
                        Get.find<DocumentStepController>(tag: stepData.id);
                    await controller.getAllFields();
                    Get.to(() => StepFieldScreen(step: stepData));
                  },
                  child: Chip(
                      backgroundColor: AppColors.mainColor,
                      labelStyle: const TextStyle(color: Colors.white),
                      label: Text(
                        isUserTurn ? 'Submit' : 'View Data',
                        style: const TextStyle(fontSize: 10),
                      ),
                      padding: const EdgeInsets.all(0)),
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(() => StepsEventScreen(events: stepData.events));
                  },
                  child: const Chip(
                      backgroundColor: AppColors.mainColor,
                      labelStyle: TextStyle(color: Colors.white),
                      label: Text(
                        'View History',
                        style: TextStyle(fontSize: 10),
                      ),
                      padding: EdgeInsets.all(0)),
                ),
              ],
            )
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final Document doc;
  const _Header({required this.doc});
  @override
  Widget build(BuildContext context) {
    final document = doc;
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFFF9F9F9),
        border: Border(
          bottom: BorderSide(
            color: Color(0xFFE9E9E9),
            width: 3,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: <Widget>[
            const Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    'ESTIMATED TIME',
                    style: TextStyle(
                      color: Color(0xFFA2A2A2),
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    'Unknown',
                    style: TextStyle(
                      color: Color(0xFF636564),
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Text(
                    'Document ID',
                    style: TextStyle(
                      color: Color(0xFFA2A2A2),
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    '#${document.id}',
                    style: const TextStyle(
                      color: Color(0xFF636564),
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
