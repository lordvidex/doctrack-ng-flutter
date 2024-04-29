import 'package:final_year/utils/enum/enum.dart';
import 'package:final_year/utils/widgets/docs_container.dart';
import 'package:final_year/utils/widgets/text.dart';
import 'package:final_year/utils/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'constants/colors.dart';

Widget fieldType<T>(
    {required String fieldType,
    required String title,
    required String hintText,
    Function(String)? onChanged,
    bool? toggleValue,
    Function(bool?)? onToggle, // for checkboxes
    TextEditingController? controller}) {
  print(fieldType);
  print(FieldType.TYPE_LONG_TEXT.toString());
  if (fieldType == 'TYPE_LONG_TEXT') {
    return inputField(
        mainText: title,
        addInfoButton: true,
        hintText: hintText,
        maxLines: 15,
        onChanged: onChanged,
        controller: controller);
  } else if (fieldType == 'TYPE_SHORT_TEXT') {
    return inputField(
        mainText: title,
        addInfoButton: true,
        hintText: hintText,
        maxLines: 1,
        onChanged: onChanged,
        controller: controller);
  } else if (fieldType == 'TYPE_NUMBER') {
    return inputField(
        mainText: title,
        hintText: hintText,
        addInfoButton: true,
        fieldWidth: 100.w,
        onChanged: onChanged,
        keyboardType: TextInputType.number,
        controller: controller);
  } else if (fieldType == 'TYPE_FILE') {
    return uploadDocContainer(mainText: 'NIN', onTap: () {});
  } else if (fieldType == 'TYPE_LINK') {
    return inputField(
        mainText: title,
        hintText: hintText,
        addInfoButton: true,
        maxLines: 2,
        onChanged: onChanged,
        controller: controller);
  } else if (fieldType == 'TYPE_BOOL') {
    return Row(
      children: [
        Checkbox.adaptive(
          value: toggleValue,
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
        addInfoButton: true,
        maxLines: 2,
        onChanged: onChanged,
        controller: controller);
  }
}
