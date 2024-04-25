import 'package:final_year/dep/init.dart';
import 'package:final_year/features/controllers/workflow.dart';
import 'package:final_year/features/route/route.dart';
import 'package:final_year/utils/constants/url.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDep();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    bool loggedIn =  WorkflowController.instance.isLoggedIn();
    return ScreenUtilInit(
      
      designSize:const Size(360, 690),
      minTextAdapt: true,
      builder: (context, _) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            appBarTheme:const AppBarTheme(backgroundColor: Colors.white),
            scaffoldBackgroundColor: Colors.white,
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          initialRoute: loggedIn?AppRoute.nationalProfile: AppRoute.initial,
          getPages: AppRoute.pages,
        );
      }
    );
  }
}

