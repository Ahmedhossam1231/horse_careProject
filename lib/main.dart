import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/horse_controller.dart';
import 'lang/translation.dart'; 
import 'bindings/bindings.dart';
import 'screens/before_Home/login.dart';

void main() {
    Get.put(HorseController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      translations: AppTranslation(),       
      locale: const Locale('en'),              
      fallbackLocale: const Locale('en'),        
      initialBinding: MyBindings(),
      debugShowCheckedModeBanner: false,
      title: 'Horse App',
      
      home: const LoginScreen(),
    );
  }
}
