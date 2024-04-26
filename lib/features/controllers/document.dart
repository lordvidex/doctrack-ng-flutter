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
  }
}