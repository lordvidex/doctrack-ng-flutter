import 'package:final_year/features/api/apiClient.dart';
import 'package:get/get.dart';

import '../models/document.dart';

class DocumentController extends GetxController {
  ApiClient apiClient;
  DocumentController({required this.apiClient});

  List<Document> documents = [];

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
  bool loading = false;

  Future<void> getDocumentSteps(String documentId) async {
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

    documentSteps.forEach((element) {
      element.events.sort((a, b) => a.createdAt.compareTo(b.createdAt));
    });
    update();
  }
}
