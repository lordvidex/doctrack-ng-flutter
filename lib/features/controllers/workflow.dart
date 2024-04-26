import 'package:final_year/features/api/apiClient.dart';
import 'package:final_year/features/models/field.dart';
import 'package:final_year/features/models/workflow.dart';
import 'package:final_year/utils/constants/url.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WorkflowController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    // for(int i=0; i< 5; i++){
    //   controllers.add(TextEditingController());
    // values.add('');
    // }
  }

  static WorkflowController get instance => Get.find();
  ApiClient apiClient;
  SharedPreferences sharedPreferences;
  WorkflowController(
      {required this.apiClient, required this.sharedPreferences});
  List<Workflow> workFlows = <Workflow>[];
  List<WorkflowField> fields = [];
//  List<TextEditingController> controllers = <TextEditingController>[];
//  List<String> values =[];

  // serching for flows
  Future<void> getWorkflow(query) async {
    String? token = sharedPreferences.containsKey(StorageConstants.TOKEN)
        ? sharedPreferences.getString(StorageConstants.TOKEN)
        : '';
    Map<String, String> mainHeader = {
      'Content-type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    Response response = await apiClient.getData("/v1/workflow?query=$query",
        additionalHeaders: mainHeader);

    if (response.statusCode == 200) {
      workFlows = [];
      workFlows.addAll(Flows.fromJson(response.body).workFlows);
      update();
    } else {
      print('workflow query failed');
    }
  }

  Future<void> getFlowField(String stepId) async {
    String? token = sharedPreferences.containsKey(StorageConstants.TOKEN)
        ? sharedPreferences.getString(StorageConstants.TOKEN)
        : '';
    Map<String, String> mainHeader = {
      'Content-type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    Response response = await apiClient.getData("/v1/step/$stepId/fields",
        additionalHeaders: mainHeader);
    if (response.statusCode == 200) {
      final emptyField = FieldModel.fromJson(response.body).fieldslist?.isEmpty;
      if (emptyField != true) {
        fields = [];
        fields.addAll(FieldModel.fromJson(response.body).fieldslist!);
        update();
      }
    } else {}
  }

  bool isLoggedIn() {
    return sharedPreferences.containsKey(StorageConstants.TOKEN);
  }

  // fieldType({
  //   required String mainText,
  //   required String hintText
  // }){
  //   var initialType = FieldType.TYPE_NONE;
  //   switch(initialType){
  //     case FieldType.TYPE_LONG_TEXT || FieldType.TYPE_SHORT_TEXT:
  //     return customTextField(mainText: mainText, hintText: hintText);
  //     case

  //   }
  // }
}
