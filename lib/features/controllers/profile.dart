import 'package:final_year/features/route/route.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  RxBool isNationalProfileCreating = false.obs;
  RxBool isProfileCreating = false.obs;
  
  // create natonal profile
  createNationalProfile() {
    isNationalProfileCreating.value = true;
    Future.delayed(const Duration(seconds: 2))
        .then((value) => Get.toNamed(AppRoute.createProfile));
    isNationalProfileCreating.value = false;
  }

  // create profile

  createProfile() {
    isProfileCreating.value = true;
    Future.delayed(const Duration(seconds: 2))
        .then((value) => Get.toNamed(AppRoute.uploadDocuments));
    isProfileCreating.value = false;
  }
}
