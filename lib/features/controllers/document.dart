import 'package:final_year/features/api/apiClient.dart';
import 'package:final_year/features/models/field.dart';
import 'package:final_year/features/models/response.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../models/document.dart';

class DocumentController extends GetxController {
  ApiClient apiClient;
  DocumentController({required this.apiClient});

  List<Document> documents = [];
  Rx<Document?> currentDocument = null.obs;

  Future<void> getDocuments() async {
    Response response = await apiClient.getData('/v1/document');
    if (response.statusCode != 200) {
      return;
    }
    documents = (response.body['documents'] as List)
        .map((e) => Document.fromMap(e))
        .toList();
    update();
  }

  Future<Document?> createDocument(workflowId) async {
    Response response =
        await apiClient.postData('/v1/document', {'workflowId': workflowId});
    if (response.statusCode != 200) {
      return null;
    }
    final id = response.body['id'];
    response = await apiClient.getData('/v1/document/$id');
    if (response.statusCode != 200) {
      return null;
    }
    return Document.fromMap(response.body['document']);
  }
}

class DocumentStepsController extends GetxController {
  ApiClient apiClient;
  DocumentStepsController({required this.apiClient});

  List<DocumentStep> documentSteps = [];
  String documentId = '';
  bool loading = false;

  Future<void> getDocumentSteps(String documentId) async {
    this.documentId = documentId;
    loading = true;
    update();
    final response = await apiClient.getData('/v1/document/$documentId/steps');
    loading = false;
    update();

    if (response.statusCode != 200) {
      return;
    }
    documentSteps = (response.body['steps'] as List)
        .map((e) => DocumentStep.fromMap(e))
        .toList()
      ..sort((a, b) => a.step.index - b.step.index);

    for (var element in documentSteps) {
      element.events.sort((a, b) => a.createdAt.compareTo(b.createdAt));
    }
    update();
  }
}

class DocumentStepController extends GetxController {
  final ApiClient apiClient;
  final DocumentStep step;
  bool loading = false;
  List<WorkflowField> fields = [];
  Map<String, Rx<TextEditingController?>> textControllers = {};
  Map<String, RxBool?> checkControllers = {};
  DocumentStepController({required this.apiClient, required this.step}) {
    _setCurrentData();
  }

  Future<ResponseModel> uploadFields(String documentId) async {
    loading = true;
    update();
    print('model: ${_makeModel()}');
    var futures = _makeModel()
        .map((f) => apiClient.postData(
            '/v1/document/$documentId/step/${step.id}/field', f.toMap()))
        .toList();
    await Future.wait(futures);

    await apiClient.postData('/v1/document/$documentId/step/${step.id}/event', {
      'event': {
        'actor': 'ACTOR_USER',
        'type': 'TYPE_SUBMISSION',
      }
    });
    loading = false;
    update();
    return ResponseModel(
        isSuccess: true,
        message:
            'Your entry has been submitted. Admin will review and update it soon.');
  }

  Future<void> getAllFields() async {
    loading = true;
    Response response =
        await apiClient.getData("/v1/step/${step.step.id}/fields");
    if (response.statusCode == 200) {
      final emptyField = FieldModel.fromJson(response.body).fieldslist?.isEmpty;
      if (emptyField != true) {
        fields = [];
        fields.addAll(FieldModel.fromJson(response.body).fieldslist!);
      }
    } else {}
    _setEmptyData();
    loading = false;
    update();
  }

  /// setCurrentData sets the current data that the user has previously entered for these fields.
  void _setCurrentData() {
    step.fields.forEach((f) {
      switch (f.field.type) {
        case 'TYPE_SHORT_TEXT':
        case 'TYPE_LONG_TEXT':
        case 'TYPE_NUMBER':
        case 'TYPE_LINK':
          textControllers[f.field.id!] =
              TextEditingController(text: f.data?.text).obs;
          break;
        case 'TYPE_BOOL':
          checkControllers[f.field.id!] = (f.data?.boolean ?? false).obs;
          break;
      }
    });
    print(step.fields.length);
    print('From _setCurrentData: $textControllers $checkControllers');
    update();
  }

  void _setEmptyData() {
    fields.forEach((f) {
      switch (f.type) {
        case 'TYPE_SHORT_TEXT':
        case 'TYPE_LONG_TEXT':
        case 'TYPE_NUMBER':
        case 'TYPE_LINK':
          if (textControllers[f.id] == null) {
            textControllers[f.id!] = TextEditingController().obs;
          }
          break;
        case 'TYPE_BOOL':
          if (checkControllers[f.id] == null) {
            checkControllers[f.id!] = false.obs;
          }
          break;
      }
    });
    print(fields.length);
    print('From _setEmptyData: $textControllers $checkControllers');
  }

  List<UploadFieldModel> _makeModel() {
    final result = <UploadFieldModel>[];
    textControllers.forEach((k, v) {
      result.add(
          UploadFieldModel(fieldId: k, data: FieldData(text: v.value!.text)));
    });
    checkControllers.forEach((key, value) {
      result.add(UploadFieldModel(
          fieldId: key, data: FieldData(boolean: value!.value)));
    });
    return result;
  }
}
