import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:homease/core/config/locale/locale.dart';
import 'package:homease/core/controllers/auth_controller.dart';
import 'package:homease/core/controllers/complaint_controller.dart';
import 'package:homease/core/routes/app_routes.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:responsive_framework/utils/scroll_behavior.dart';
import 'package:sizer/sizer.dart';
import 'package:homease/core/controllers/app_Controller.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'dart:async';
import 'views/pages/login.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// Initialize the FlutterLocalNotificationsPlugin
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();

  // Initialize local notifications
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

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
      locale: appCtrl.lang, // Set the initial locale from AppController
      fallbackLocale: Locale('en', 'US'), // Define the fallback locale
      translations: Messages(), // Set the translations class
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
          width: 100.w,
          height: 100.h,
        ),
        nextScreen: Container(),
      ),
    );
  }
}
