import 'package:final_year/features/controllers/workflow.dart';
import 'package:final_year/features/route/route.dart';
import 'package:final_year/utils/constants/colors.dart';
import 'package:final_year/utils/widgets/custom_appbar.dart';
import 'package:final_year/utils/widgets/custom_search.dart';
import 'package:final_year/utils/widgets/docs_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controllers/document.dart';

class DocumentsScreen extends StatefulWidget {
  const DocumentsScreen({super.key});

  @override
  State<DocumentsScreen> createState() => _DocumentsScreenState();
}

class _DocumentsScreenState extends State<DocumentsScreen> {
  @override
  void initState() {
    Get.find<DocumentController>().getDocuments();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DocumentController>(builder: (controller) {
      return Scaffold(
          appBar: customAppBAr(
              text: 'My Documents',
              hasBox: true,
              textColor: AppColors.mainColor,
              fontSize: 14.sp),
          body: Column(
            children: [
              controller.documents.isEmpty
                  ? Container()
                  : Expanded(
                      child: ListView.builder(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          physics: const BouncingScrollPhysics(),
                          itemCount: controller.documents.length,
                          itemBuilder: (context, index) {
                            final doc = controller.documents[index];
                            return nationalDocContainer(
                              text: doc.workflow.name,
                              onTap: () {
                                Get.toNamed(AppRoute.viewDocumentDetails, arguments: {
                                  'document': doc,
                                });
                              },
                            );
                          }),
                    )
            ],
          ));
    });
  }
}
