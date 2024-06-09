import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:homease/core/controllers/auth_controller.dart';
import 'package:homease/core/controllers/complaint_controller.dart';
import 'package:homease/core/routes/app_routes.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:responsive_framework/utils/scroll_behavior.dart';
import 'core/config/locale/locale.dart';
import 'package:homease/core/controllers/app_Controller.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'dart:async';
import 'package:sizer/sizer.dart';
import 'views/pages/login.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
 //NotificationService.CreateChannel();
   Get.put(ComplaintController());

  runApp(Sizer(builder: (context, orientation, deviceType) {
    return MyApp();
  }));
}

class MyApp extends StatelessWidget {
  final AuthController authController = Get.put(AuthController());
  AppController appCtrl = Get.put(AppController());
  MyApp({Key? key});

  
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'HomEase',
      themeMode: appCtrl.theme,
      debugShowCheckedModeBanner: false,
      locale: appCtrl.lang,
      translations: MyLocal(),
      initialRoute: "/splashscreen",
      getPages: approutes(),
      builder: (context, widget) => ResponsiveWrapper.builder(
        ClampingScrollWrapper.builder(context, widget!),
        breakpoints: const [
          ResponsiveBreakpoint.autoScale(350, name: MOBILE),
          ResponsiveBreakpoint.autoScale(600, name: TABLET),
          ResponsiveBreakpoint.autoScale(800, name: DESKTOP),
          ResponsiveBreakpoint.autoScale(1700, name: 'XL'),
        ],
      ),
    );
  }
}

class SplashScreen extends StatelessWidget {
 @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSplashScreen(
        duration: 1000,
        nextRoute: "/market",
        splash: Image.asset(
          'assets/images/logo.png',
          width: 400.w,
          height: 400.h,
        ),
        nextScreen: Container(),

      
      ),
    );
  }
}
