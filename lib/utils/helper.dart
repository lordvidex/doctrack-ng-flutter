import 'package:final_year/utils/enum/enum.dart';
import 'package:final_year/utils/widgets/docs_container.dart';
import 'package:final_year/utils/widgets/text.dart';
import 'package:final_year/utils/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'constants/colors.dart';

Widget fieldType<T>(
    {required String fieldType,
    required String title,
    required String hintText,
    Function(String)? onChanged,
    Function(bool?)? onToggle, // for checkboxes
    TextEditingController? controller}) {
  if (fieldType == FieldType.TYPE_LONG_TEXT.toString()) {
    return inputField(
        mainText: title,
        hintText: hintText,
        maxLines: 15,
        onChanged: onChanged,
        controller: controller);
  } else if (fieldType == FieldType.TYPE_SHORT_TEXT.toString()) {
    return inputField(
        mainText: title,
        hintText: hintText,
        maxLines: 1,
        onChanged: onChanged,
        controller: controller);
  } else if (fieldType == FieldType.TYPE_NUMBER.toString()) {
    return inputField(
        mainText: title,
        hintText: hintText,
        fieldWidth: 100.w,
        onChanged: onChanged,
        keyboardType: TextInputType.number,
        controller: controller);
  } else if (fieldType == FieldType.TYPE_FILE.toString()) {
    return uploadDocContainer(mainText: 'NIN', onTap: () => null);
  } else if (fieldType == FieldType.TYPE_LINK.toString()) {
    return inputField(
        mainText: title,
        hintText: hintText,
        maxLines: 2,
        onChanged: onChanged,
        controller: controller);
  } else if (fieldType == FieldType.TYPE_BOOL.toString()) {
    return Row(
      children: [
        Checkbox.adaptive(
          value: false,
          onChanged: onToggle,
        ),
        boldText(text: title),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: Tooltip(
                message: hintText,
                enableFeedback: true,
                triggerMode: TooltipTriggerMode.tap,
                child: const Icon(Icons.info, color: AppColors.mainColor))),
      ],
    );
  } else {
    return inputField(
        mainText: title,
        hintText: hintText,
        maxLines: 2,
        onChanged: onChanged,
        controller: controller);
  }
}
