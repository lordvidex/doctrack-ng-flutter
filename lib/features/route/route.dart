import 'package:final_year/features/screens/application_created.dart';
import 'package:final_year/features/screens/create_national_profile.dart';
import 'package:final_year/features/screens/field_screen.dart';
import 'package:final_year/features/screens/flow_steps.dart';
import 'package:final_year/features/screens/login.dart';
import 'package:final_year/features/screens/national_profile.dart';
import 'package:final_year/features/screens/profile.dart';
import 'package:final_year/features/screens/sign_up.dart';
import 'package:final_year/features/screens/signature.dart';
import 'package:final_year/features/screens/upload_document.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../screens/document_steps_screen.dart';
import '../screens/home_screen.dart';

class AppRoute {
  static const String initial = '/signup';
  static const String login = '/login';
  static const String createNationalProfile = '/createNationalProfile';
  static const String createProfile = '/createProfile';
  static const String uploadDocuments = '/uploadDocuments';
  static const String signature = '/signature';
  static const String nationalProfile = '/nationalProfile';
  static const String applicationCreated = '/applicationCreated';
  static const String flowSteps = '/flowsteps';
  static const String field = '/field';
  static const String singleWorkflow = '/singleWorkflow';
  static const String home = '/';
  static const String viewDocumentDetails = '/documentDetails';

  static List<GetPage> pages = [
    GetPage(
      name: initial,
      page: () => const SignupScreen(),
      // middlewares: [
      //   WelcomeMiddleWare(priority: 1)
      // ],
      curve: Curves.easeInOut,
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: login,
      page: () => const LoginScreen(),
      curve: Curves.easeInOut,
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: createNationalProfile,
      page: () => const CreateNationalProfileScreen(),
      curve: Curves.easeInOut,
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: createProfile,
      page: () => const ProfileScreen(),
      curve: Curves.easeInOut,
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: uploadDocuments,
      page: () => const UploadDocuments(),
      curve: Curves.easeInOut,
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: signature,
      page: () => const SignatureScreen(),
      curve: Curves.easeInOut,
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: applicationCreated,
      page: () => const ApplicationCreatedScreen(),
      curve: Curves.easeInOut,
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: flowSteps,
      page: () => const WorkflowStepsScreen(),
      curve: Curves.easeInOut,
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: field,
      page: () => const FieldScreen(),
      curve: Curves.easeInOut,
      transition: Transition.fadeIn,
    ),
    GetPage(
        name: home,
        page: () => HomeScreen(),
        curve: Curves.easeInOut,
        transition: Transition.fadeIn),
    GetPage(
        name: viewDocumentDetails,
        page: () => const DocumentDetailsScreen(),
        curve: Curves.easeIn,
        transition: Transition.fadeIn),
  ];
}
