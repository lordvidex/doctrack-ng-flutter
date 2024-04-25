import 'package:final_year/features/api/apiClient.dart';
import 'package:final_year/features/controllers/workflow.dart';
import 'package:final_year/utils/constants/url.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FieldController extends GetxController{
  WorkflowController workflowController;
  SharedPreferences sharedPreferences;
  ApiClient apiClient;
  FieldController({required this.workflowController, required this.sharedPreferences, required this.apiClient});

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    for(int i=0; i< workflowController.fields.length; i++){
      controllers.add(TextEditingController());
    values.add('');
    }
  }
  List<TextEditingController> controllers = <TextEditingController>[];
 List<String> values =[];
   


   updateInputValue(String value, int index){
    values[index] = value;
    update();
    print('..value is ${values[index]}');
    print('.vales are $values');
  }

  Future<void> getDocId(String workflowId) async {
      final accessToken  = sharedPreferences.containsKey(StorageConstants.TOKEN)? sharedPreferences.getString(StorageConstants.TOKEN):'';
     final response = await apiClient.postData(UrlConstants.DOCUMENT_ENDPOINT, {'workflowId': workflowId}, accessToken: accessToken);
     if(response.statusCode==200){
      print('....success ${response.body}');
     }else{
      print('..statuscode ${response.statusCode}');
      print('..statustext ${response.statusText}');
     }
     }
}