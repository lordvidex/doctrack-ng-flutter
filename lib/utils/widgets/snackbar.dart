import 'package:final_year/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

errorSnackbar({required String title, required String message}) {
  return Get.snackbar(title, message,
      isDismissible: true,
      shouldIconPulse: true,
      colorText: Colors.white,
      duration: const Duration(seconds: 3),
      icon: const Icon(Icons.warning),
      backgroundColor: Colors.red.shade600);
}

successSnackbar({required String title, required String message}) {
  return Get.snackbar(title, message,
      isDismissible: true,
      shouldIconPulse: true,
      colorText: Colors.white,
      duration: const Duration(seconds: 3),
      icon: const Icon(Icons.done),
      backgroundColor: AppColors.mainColor);
}