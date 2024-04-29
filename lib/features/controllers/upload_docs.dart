import 'package:file_picker/file_picker.dart';
import 'package:final_year/features/api/apiClient.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UploadDocumentsController extends GetxController {
  ApiClient apiClient;
  SharedPreferences sharedPreferences;
  UploadDocumentsController(
      {required this.apiClient, required this.sharedPreferences});
  final _filePicker = FilePicker.platform;

  // pick file
  pickFile() async {
    final pickedFile = await _filePicker.pickFiles();
    if (pickedFile != null) {}
  }
}
