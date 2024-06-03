import 'package:get/get.dart';
import 'package:homease/core/controllers/auth_controller.dart';
import 'package:homease/main.dart';
import 'package:homease/views/pages/account.dart';
import 'package:homease/views/pages/complaints.dart';
import 'package:homease/views/pages/login.dart';
import 'package:homease/views/pages/home.dart';
import 'package:homease/views/pages/market.dart';
import 'package:homease/views/pages/reminder.dart';


approutes() => [
  GetPage(
        name: "/splashscreen",
        page: () => SplashScreen(),
      ),
     GetPage(
           name: "/login",
           page: () => Login(),
           binding: BindingsBuilder(() {
             Get.put(AuthController());
           })),   
            GetPage(
          name: "/home",
          page: () => HomePage(),
          binding: BindingsBuilder(() {})),
          GetPage(
          name: "/market",
          page: () => MarketplacePage(),
          binding: BindingsBuilder(() {})),
           GetPage(
          name: "/reminder",
          page: () => ReminderPage(),
          binding: BindingsBuilder(() {})),
           GetPage(
          name: "/complaint",
          page: () => ComplaintPage(),
          binding: BindingsBuilder(() {})),
          
            GetPage(
          name: "/account",
          page: () => AccountSettingsPage(),
          binding: BindingsBuilder(() {})),



  
];