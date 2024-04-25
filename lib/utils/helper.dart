import 'package:final_year/utils/enum/enum.dart';
import 'package:final_year/utils/widgets/docs_container.dart';
import 'package:final_year/utils/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget fieldType({
  required String fieldType,
  required String title,
  required String hintText,
  Function(String)? onChanged,
  TextEditingController? controller
  }){
   if(fieldType== FieldType.TYPE_LONG_TEXT.toString()){
    return inpuutField(mainText: title, hintText:hintText, maxLines: 100, onChanged: onChanged, controller: controller );
   }else if(fieldType == FieldType.TYPE_SHORT_TEXT.toString()){
    return inpuutField(mainText: title, hintText:hintText, maxLines: 2,onChanged: onChanged, controller: controller );

   }else if(fieldType == FieldType.TYPE_NUMBER.toString()){
    return inpuutField(mainText: title, hintText:hintText, fieldWidth: 100.w, onChanged: onChanged, controller: controller);
   }else if(fieldType == FieldType.TYPE_FILE.toString()){
    return uploadDocContainer(mainText: 'NIN', onTap: () => null);
   }else if(fieldType == FieldType.TYPE_LINK.toString()){
    return inpuutField(mainText: title, hintText:hintText, maxLines: 2 , onChanged: onChanged, controller: controller);
   }else if(fieldType == FieldType.TYPE_BOOL.toString()){
    return inpuutField(mainText: title, hintText:hintText, maxLines: 2 , onChanged: onChanged, controller: controller);
   }
   else{
    return inpuutField(mainText: title, hintText:hintText, maxLines: 2 , onChanged: onChanged, controller: controller);
   }
}