import 'package:final_year/features/api/apiClient.dart';
import 'package:final_year/features/models/field.dart';
import 'package:final_year/features/models/workflow.dart';
import 'package:final_year/utils/constants/url.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WorkflowController extends GetxController {
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
    Response response = await apiClient.getData("/v1/step/$stepId/fields");
    if (response.statusCode == 200) {
      final emptyField = FieldModel.fromJson(response.body).fieldslist?.isEmpty;
      if (emptyField != true) {
        fields = [];
        fields.addAll(FieldModel.fromJson(response.body).fieldslist!);
        update();
      }
    } else {}
  }
}
